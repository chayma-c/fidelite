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
    this.failureReasons = const {},
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

  /// Why each currently-queued order (keyed by [PendingOrder.localId])
  /// failed on its *most recent* sync attempt -- only set when the server
  /// was actually reached and rejected the order outright (a stale app
  /// build sending a request shape the server no longer accepts, a
  /// since-deactivated menu item, etc.), never for a plain "couldn't reach
  /// the server" failure, which is the normal/expected case while offline
  /// and shouldn't read as broken. Recomputed fresh on every [syncAll]
  /// call -- not persisted, since it's just "what happened last attempt."
  final Map<String, String> failureReasons;

  PendingOrdersState copyWith({
    List<PendingOrder>? queued,
    List<SyncedPendingOrder>? readyToPrint,
    bool? isSyncing,
    Map<String, String>? failureReasons,
  }) => PendingOrdersState(
    queued: queued ?? this.queued,
    readyToPrint: readyToPrint ?? this.readyToPrint,
    isSyncing: isSyncing ?? this.isSyncing,
    failureReasons: failureReasons ?? this.failureReasons,
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
  /// placed. An order that keeps failing stays queued for the next attempt
  /// either way, but *why* it failed is recorded in
  /// [PendingOrdersState.failureReasons] when the server was actually
  /// reached and rejected it outright -- a since-deactivated menu item, or
  /// (the case that prompted this) a stale app build sending a request
  /// shape the server no longer accepts after a protocol change, which
  /// would otherwise fail every single sync attempt forever while looking
  /// indistinguishable from "just still offline." A genuine connection
  /// failure (statusCode -1 -- the server was never reached at all) gets
  /// no reason recorded; that's the normal, expected case while offline
  /// and retrying silently is correct for it.
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
      final failureReasons = <String, String>{};

      for (final order in state.queued) {
        try {
          final confirmation = await client.order.submitOrder(
            order.lines
                .map(
                  (line) => OrderItemInput(
                    menuItemId: line.menuItemId,
                    quantity: line.quantity,
                    // A queued counter order never carries customization --
                    // PendingOrderLine (unlike CartLine) has nowhere to
                    // have stored it even if it did, since it's built from
                    // the staff order builder, which doesn't offer it.
                    removedIngredients: const [],
                    addedSauces: const [],
                    specialRequest: null,
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
        } on InvalidOrderException catch (e) {
          stillQueued.add(order);
          failureReasons[order.localId] = _messageFor(e.reason);
        } on ServerpodClientException catch (e) {
          stillQueued.add(order);
          // statusCode -1 means the request never actually reached the
          // server (see ServerpodClientException's throw sites in the
          // serverpod_client package) -- a plain connection failure, left
          // without a reason so it doesn't read as broken. Any other
          // status code means the server *did* respond, just with a
          // rejection -- most notably a 400 if this app build is sending
          // a request shape (e.g. a field the current protocol requires)
          // that predates a server-side schema change.
          if (e.statusCode != -1) {
            failureReasons[order.localId] =
                'The server rejected this order (code ${e.statusCode}). '
                'This usually means the app needs an update -- check for '
                'a newer version.';
          }
        } catch (_) {
          stillQueued.add(order);
        }
      }

      state = state.copyWith(
        queued: stillQueued,
        readyToPrint: [...state.readyToPrint, ...newlySynced],
        isSyncing: false,
        failureReasons: failureReasons,
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

  /// Unlike a live counter-order submission (OrderSubmissionController),
  /// where the shop being closed or the balance running short just can't
  /// happen, a *queued* order replaying here genuinely can hit several of
  /// these for real -- it could have sat offline long enough for the shop
  /// to have since closed, or for one of its items to have been
  /// deactivated in the meantime.
  String _messageFor(InvalidOrderExceptionReason reason) => switch (reason) {
    InvalidOrderExceptionReason.emptyCart => 'The cart was empty.',
    InvalidOrderExceptionReason.invalidQuantity =>
      'One of the quantities was invalid.',
    InvalidOrderExceptionReason.menuItemUnavailable =>
      'One of the items is no longer on the menu.',
    InvalidOrderExceptionReason.shopNotOpen =>
      "The shop wasn't open when this synced.",
    InvalidOrderExceptionReason.insufficientPointsBalance =>
      'Something went wrong syncing this order.',
    InvalidOrderExceptionReason.missingDeliveryDetails =>
      'Something went wrong syncing this order.',
    InvalidOrderExceptionReason.invalidCustomization =>
      'Something went wrong syncing this order.',
    InvalidOrderExceptionReason.unknown =>
      'Something went wrong syncing this order.',
  };

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
