import 'dart:async';

import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/cache/local_cache.dart';
import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/local_ticket_number_tracker.dart';
import '../../data/order_history_providers.dart';
import '../../data/pending_order.dart';
import 'cart_controller.dart';

/// A [PendingOrder] that has since synced -- [confirmation] is the real
/// server response (real order id, real single-use QR token), which is
/// what a ticket needs to actually carry working cashback. Not persisted:
/// if the app is killed before it's printed, the order is still safely on
/// the server (it synced), just without this "print it now" affordance --
/// staff always have the option of getting a fresh reprint from order
/// history later.
class SyncedPendingOrder {
  const SyncedPendingOrder({required this.source, required this.confirmation});

  final PendingOrder source;
  final OrderConfirmation confirmation;
}

class PendingOrdersState {
  const PendingOrdersState({
    this.queued = const [],
    this.readyToPrint = const [],
    this.isSyncing = false,
  });

  /// Orders still waiting to reach the server. Persisted, so they survive
  /// an app restart.
  final List<PendingOrder> queued;

  /// Orders that just synced during this session and haven't been printed
  /// (or dismissed) yet.
  final List<SyncedPendingOrder> readyToPrint;

  /// True for the duration of a [PendingOrderQueueController.syncAll] run.
  /// Doubles as its re-entrancy guard (reading state is synchronous, so
  /// there's no gap for a second call to sneak through) and as what the UI
  /// shows a spinner for.
  final bool isSyncing;

  PendingOrdersState copyWith({
    List<PendingOrder>? queued,
    List<SyncedPendingOrder>? readyToPrint,
    bool? isSyncing,
  }) => PendingOrdersState(
    queued: queued ?? this.queued,
    readyToPrint: readyToPrint ?? this.readyToPrint,
    isSyncing: isSyncing ?? this.isSyncing,
  );
}

const _queueCacheKey = 'pendingOrders.queue';

/// Holds orders that couldn't reach the server at submit time and syncs
/// them once it can. See [PendingOrder] for why this is a local-only queue
/// rather than anything the server knows about until sync succeeds.
class PendingOrderQueueController extends Notifier<PendingOrdersState> {
  @override
  PendingOrdersState build() {
    unawaited(_restore());
    return const PendingOrdersState();
  }

  Future<void> _restore() async {
    final restored = await ref
        .read(localCacheProvider)
        .readList(_queueCacheKey, PendingOrder.fromJson);
    if (restored != null && restored.isNotEmpty) {
      state = state.copyWith(queued: restored);
    }
  }

  Future<PendingOrder> enqueue(List<CartLine> cart) async {
    // Reserved right now, locally -- so there's a real ticket number to
    // print immediately instead of a "pending" placeholder. See
    // LocalTicketNumberTracker for what happens to it at sync time.
    final ticketNumber = await ref
        .read(localTicketNumberTrackerProvider)
        .reserveNext();
    final order = PendingOrder.fromCart(cart, ticketNumber: ticketNumber);
    state = state.copyWith(queued: [...state.queued, order]);
    await _persistQueue();
    return order;
  }

  void dismissReadyToPrint(String localId) {
    state = state.copyWith(
      readyToPrint: state.readyToPrint
          .where((entry) => entry.source.localId != localId)
          .toList(),
    );
  }

  /// Replays every queued order against the server, in the order they were
  /// placed. An order that keeps failing (offline again, or a genuine
  /// rejection like a since-deactivated item) simply stays queued for the
  /// next attempt -- distinguishing "still offline" from "this order is
  /// permanently stuck" isn't handled yet; staff can see how long something
  /// has been queued on the pending-orders screen.
  ///
  /// [PendingOrdersState.isSyncing] guards against two overlapping runs --
  /// without it, a second call starting before the first finishes (e.g.
  /// tapping the sync button twice) would let the *same* queued order be
  /// read by both calls before either removes it from [state.queued], so it
  /// gets submitted to the server twice. The first submission claims its
  /// real ticket number; the second arrives a moment later, finds that
  /// number already taken, and the server correctly refuses to double-book
  /// it -- so it falls back to a fresh number instead. What that looked
  /// like to staff: a duplicated order and a ticket number that didn't
  /// match what was printed. This guard is what actually closes that race;
  /// syncing being staff-initiated rather than automatic is a separate
  /// decision, about not wanting background network activity landing
  /// uninvited in the middle of taking an order -- see the sync button in
  /// OrderBuilderPage.
  Future<void> syncAll() async {
    if (state.queued.isEmpty || state.isSyncing) return;
    state = state.copyWith(isSyncing: true);

    try {
      final client = ref.read(serverpodClientProvider);
      final stillQueued = <PendingOrder>[];
      final newlySynced = <SyncedPendingOrder>[];

      for (final order in state.queued) {
        try {
          final confirmation = await client.order.submitOrder(
            order.lines
                .map(
                  (line) => OrderItemInput(
                    menuItemId: line.menuItemId,
                    quantity: line.quantity,
                  ),
                )
                .toList(),
            requestedTicketNumber: order.ticketNumber,
            placedAt: order.createdAt,
          );
          await ref
              .read(localTicketNumberTrackerProvider)
              .recordKnown(
                confirmation.order.ticketNumber,
                confirmation.order.createdAt,
              );
          newlySynced.add(
            SyncedPendingOrder(source: order, confirmation: confirmation),
          );
        } catch (_) {
          stillQueued.add(order);
        }
      }

      state = state.copyWith(
        queued: stillQueued,
        readyToPrint: [...state.readyToPrint, ...newlySynced],
        isSyncing: false,
      );
      await _persistQueue();

      if (newlySynced.isNotEmpty) {
        // These are now real server orders -- refresh today's sales-history
        // cache immediately rather than leaving it to catch up on its own
        // next background refresh, so the total is correct the moment
        // syncing finishes, not just eventually.
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        unawaited(
          ref.read(ordersForDayProvider(today).notifier).refreshNow(),
        );
      }
    } finally {
      if (state.isSyncing) state = state.copyWith(isSyncing: false);
    }
  }

  Future<void> _persistQueue() async {
    await ref
        .read(localCacheProvider)
        .writeList(_queueCacheKey, state.queued, (order) => order.toJson());
  }
}

final pendingOrderQueueControllerProvider =
    NotifierProvider<PendingOrderQueueController, PendingOrdersState>(
      PendingOrderQueueController.new,
    );
