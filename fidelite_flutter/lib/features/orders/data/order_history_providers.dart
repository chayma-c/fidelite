import 'dart:async';

import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/local_cache.dart';
import '../../../core/connectivity/server_reachability_provider.dart';
import '../../../core/serverpod/serverpod_client_provider.dart';

/// Orders for [day]'s local calendar date (midnight to midnight, in this
/// device's own timezone), most recent first -- backs the staff sales
/// history screen.
///
/// Cache-first, not cache-through: a day staff has already opened shows
/// instantly from disk on every later visit, with a background refresh
/// (not a blocking one) only when the backend just became reachable again
/// -- see [MenuController] for why this rides on [serverReachabilityProvider]
/// instead of polling on its own clock. A past day's data never actually
/// changes, so refreshing it again is harmless; today's does change as
/// orders come in, which is exactly the case this background refresh
/// covers.
///
/// Only ever holds server-confirmed orders -- orders still sitting in the
/// local pending-order queue (placed offline, not yet synced) aren't in
/// here at all, since the server doesn't know about them yet. That merge
/// happens in SalesHistoryPage, not here, which is also why a connection
/// failure with nothing cached yet resolves to an empty list rather than
/// an error: today's total should never be blocked on this succeeding.
class OrdersForDayController
    extends AutoDisposeFamilyNotifier<AsyncValue<List<OrderRecord>>, DateTime> {
  late final DateTime _start;
  late final DateTime _end;
  late final String _cacheKey;

  @override
  AsyncValue<List<OrderRecord>> build(DateTime day) {
    _start = DateTime(day.year, day.month, day.day);
    _end = _start.add(const Duration(days: 1));
    _cacheKey = 'cache.orders.${_start.toIso8601String().substring(0, 10)}';

    ref.listen(serverReachabilityProvider, (previous, next) {
      if (previous == ServerReachability.offline &&
          next == ServerReachability.online) {
        unawaited(_refresh());
      }
    });

    unawaited(_loadInitial());
    return const AsyncValue.loading();
  }

  /// Forces an immediate real refresh, bypassing the cached value -- called
  /// right after a sync so today's total reflects newly-confirmed orders
  /// straight away instead of waiting for the next reachability-triggered
  /// background refresh. See [MenuController.refreshNow] for the same
  /// reasoning applied to the menu.
  Future<void> refreshNow() => _refresh();

  Future<void> _loadInitial() async {
    final cached = await ref
        .read(localCacheProvider)
        .readList(_cacheKey, OrderRecord.fromJson);
    if (cached != null) {
      state = AsyncValue.data(cached);
      unawaited(_refresh());
      return;
    }
    await _refresh();
  }

  Future<void> _refresh() async {
    try {
      final orders = await ref
          .read(serverpodClientProvider)
          .order
          .getOrdersInRange(start: _start, end: _end);
      await ref
          .read(localCacheProvider)
          .writeList(_cacheKey, orders, (order) => order.toJson());
      state = AsyncValue.data(orders);
    } catch (_) {
      // No server-confirmed orders known yet for this day (offline with
      // nothing cached, e.g. the first-ever launch of the day happened
      // with no connection) -- an empty list, not an error. Today's real
      // total is never solely this provider's job anyway: SalesHistoryPage
      // merges it with whatever's sitting in the local pending-order
      // queue, which is what makes today's total always computable purely
      // from on-device data, connection or not.
      if (!state.hasValue) {
        state = const AsyncValue.data([]);
      }
    }
  }
}

final ordersForDayProvider = AutoDisposeNotifierProviderFamily<
  OrdersForDayController,
  AsyncValue<List<OrderRecord>>,
  DateTime
>(OrdersForDayController.new);
