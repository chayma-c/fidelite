import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../wallet/data/wallet_providers.dart';
import 'cart_controller.dart';

sealed class OnlineOrderSubmissionState {
  const OnlineOrderSubmissionState();
}

class OnlineOrderSubmissionIdle extends OnlineOrderSubmissionState {
  const OnlineOrderSubmissionIdle();
}

class OnlineOrderSubmissionInProgress extends OnlineOrderSubmissionState {
  const OnlineOrderSubmissionInProgress();
}

class OnlineOrderSubmissionSuccess extends OnlineOrderSubmissionState {
  const OnlineOrderSubmissionSuccess(this.confirmation, this.lines);

  final OnlineOrderConfirmation confirmation;
  final List<CartLine> lines;
}

class OnlineOrderSubmissionFailure extends OnlineOrderSubmissionState {
  const OnlineOrderSubmissionFailure(this.message);

  final String message;
}

/// Places the customer's own cart as an order. Unlike the staff side
/// (OrderSubmissionController), there's no offline queueing -- self-ordering
/// genuinely requires a live connection (the customer has to know right away
/// whether it went through), so a connectivity failure is surfaced as a
/// plain failure instead of being queued for later.
class OnlineOrderSubmissionController
    extends Notifier<OnlineOrderSubmissionState> {
  @override
  OnlineOrderSubmissionState build() => const OnlineOrderSubmissionIdle();

  Future<void> submit({
    required OrderFulfillmentMethod fulfillmentMethod,
    required OrderPaymentMethod paymentMethod,
    String? deliveryAddress,
    String? deliveryPhone,
  }) async {
    final cart = ref.read(cartControllerProvider);
    if (cart.isEmpty) return;

    state = const OnlineOrderSubmissionInProgress();
    try {
      final confirmation = await ref
          .read(serverpodClientProvider)
          .onlineOrder
          .placeOrder(
            cart
                .map(
                  (line) => OrderItemInput(
                    menuItemId: line.menuItem.id!,
                    quantity: line.quantity,
                  ),
                )
                .toList(),
            fulfillmentMethod,
            paymentMethod,
            deliveryAddress: deliveryAddress,
            deliveryPhone: deliveryPhone,
          );
      state = OnlineOrderSubmissionSuccess(confirmation, cart);
      ref.read(cartControllerProvider.notifier).clear();
      ref.invalidate(balanceProvider);
      ref.invalidate(pointsHistoryProvider);
    } on InvalidOrderException catch (e) {
      state = OnlineOrderSubmissionFailure(_messageFor(e.reason));
    } catch (_) {
      state = const OnlineOrderSubmissionFailure(
        'Could not reach the server. Check your connection and try again.',
      );
    }
  }

  void reset() => state = const OnlineOrderSubmissionIdle();

  String _messageFor(InvalidOrderExceptionReason reason) => switch (reason) {
    InvalidOrderExceptionReason.emptyCart => 'Your cart is empty.',
    InvalidOrderExceptionReason.invalidQuantity =>
      'One of the quantities is invalid.',
    InvalidOrderExceptionReason.menuItemUnavailable =>
      'One of the items is no longer available. Pull to refresh the menu.',
    InvalidOrderExceptionReason.shopNotOpen =>
      'The shop just closed -- online ordering is unavailable right now.',
    InvalidOrderExceptionReason.insufficientPointsBalance =>
      "You don't have enough points to cover this order. Choose cash on "
          'site instead, or remove some items.',
    InvalidOrderExceptionReason.missingDeliveryDetails =>
      'Enter a delivery address and phone number.',
    InvalidOrderExceptionReason.unknown =>
      'Something went wrong placing your order.',
  };
}

final onlineOrderSubmissionControllerProvider =
    NotifierProvider<OnlineOrderSubmissionController, OnlineOrderSubmissionState>(
      OnlineOrderSubmissionController.new,
    );
