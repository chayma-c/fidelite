import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import 'cart_controller.dart';

sealed class OrderSubmissionState {
  const OrderSubmissionState();
}

class OrderSubmissionIdle extends OrderSubmissionState {
  const OrderSubmissionIdle();
}

class OrderSubmissionInProgress extends OrderSubmissionState {
  const OrderSubmissionInProgress();
}

class OrderSubmissionSuccess extends OrderSubmissionState {
  const OrderSubmissionSuccess(this.confirmation, this.lines);

  final OrderConfirmation confirmation;
  final List<CartLine> lines;
}

class OrderSubmissionFailure extends OrderSubmissionState {
  const OrderSubmissionFailure(this.message);

  final String message;
}

class OrderSubmissionController extends Notifier<OrderSubmissionState> {
  @override
  OrderSubmissionState build() => const OrderSubmissionIdle();

  Future<void> submit() async {
    final cart = ref.read(cartControllerProvider);
    if (cart.isEmpty) return;

    state = const OrderSubmissionInProgress();
    try {
      final confirmation = await ref
          .read(serverpodClientProvider)
          .order
          .submitOrder(
            cart
                .map(
                  (line) => OrderItemInput(
                    menuItemId: line.menuItem.id!,
                    quantity: line.quantity,
                  ),
                )
                .toList(),
          );
      state = OrderSubmissionSuccess(confirmation, cart);
      ref.read(cartControllerProvider.notifier).clear();
    } on InvalidOrderException catch (e) {
      state = OrderSubmissionFailure(_messageFor(e.reason));
    } catch (_) {
      state = const OrderSubmissionFailure(
        'Could not submit the order. Check your connection and try again.',
      );
    }
  }

  void reset() => state = const OrderSubmissionIdle();

  String _messageFor(InvalidOrderExceptionReason reason) => switch (reason) {
    InvalidOrderExceptionReason.emptyCart => 'The cart is empty.',
    InvalidOrderExceptionReason.invalidQuantity =>
      'One of the quantities is invalid.',
    InvalidOrderExceptionReason.menuItemUnavailable =>
      'One of the items is no longer available. Pull to refresh the menu.',
    InvalidOrderExceptionReason.unknown =>
      'Something went wrong submitting the order.',
  };
}

final orderSubmissionControllerProvider =
    NotifierProvider<OrderSubmissionController, OrderSubmissionState>(
      OrderSubmissionController.new,
    );
