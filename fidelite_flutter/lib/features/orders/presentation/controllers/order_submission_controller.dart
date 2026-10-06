import 'dart:async';

import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/local_ticket_number_tracker.dart';
import '../../data/pending_order.dart';
import 'cart_controller.dart';
import 'pending_order_queue_controller.dart';

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

/// Couldn't reach the server, so the order was queued locally instead of
/// rejected outright -- see PendingOrderQueueController. From the staff's
/// perspective this still counts as "the order is placed": the cart is
/// cleared the same as a real success.
class OrderSubmissionQueued extends OrderSubmissionState {
  const OrderSubmissionQueued(this.order);

  final PendingOrder order;
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
      // Keeps the local counter from ever falling behind, so the next
      // order placed offline (if connection drops right after this one)
      // continues from the true last number instead of a stale one.
      unawaited(
        ref
            .read(localTicketNumberTrackerProvider)
            .recordKnown(confirmation.order.ticketNumber, confirmation.order.createdAt),
      );
    } on InvalidOrderException catch (e) {
      // A real business rejection (empty cart, item deactivated, ...) --
      // actionable right now by adjusting the cart, so surface it instead
      // of silently queuing something that would just fail again.
      state = OrderSubmissionFailure(_messageFor(e.reason));
    } catch (_) {
      // Anything else (unreachable server, timeout, ...) is treated as a
      // connectivity problem: queue it instead of losing the order.
      final queued = await ref
          .read(pendingOrderQueueControllerProvider.notifier)
          .enqueue(cart);
      state = OrderSubmissionQueued(queued);
      ref.read(cartControllerProvider.notifier).clear();
    }
  }

  void reset() => state = const OrderSubmissionIdle();

  String _messageFor(InvalidOrderExceptionReason reason) => switch (reason) {
    InvalidOrderExceptionReason.emptyCart => 'The cart is empty.',
    InvalidOrderExceptionReason.invalidQuantity =>
      'One of the quantities is invalid.',
    InvalidOrderExceptionReason.menuItemUnavailable =>
      'One of the items is no longer available. Pull to refresh the menu.',
    // Never actually thrown for a counter order (staff taking it in person
    // is what makes the shop "open" in spirit), but the enum is shared
    // with OnlineOrderEndpoint so the switch must stay exhaustive.
    InvalidOrderExceptionReason.shopNotOpen =>
      'Something went wrong submitting the order.',
    InvalidOrderExceptionReason.unknown =>
      'Something went wrong submitting the order.',
  };
}

final orderSubmissionControllerProvider =
    NotifierProvider<OrderSubmissionController, OrderSubmissionState>(
      OrderSubmissionController.new,
    );
