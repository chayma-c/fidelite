import 'dart:async';

import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/serverpod/serverpod_client_provider.dart';

/// Online orders still waiting for staff attention -- drives both the
/// Online Orders queue and the notification badge count (its length).
///
/// Network-first with a 15s poll while anything's watching it, same
/// reasoning as shop_status_providers.dart: staleness here directly means
/// a missed order, which matters a lot more than the handful of small
/// requests this costs. Not cache-first like the menu/sales providers.
class OnlineOrdersController
    extends AutoDisposeNotifier<AsyncValue<List<OrderRecord>>> {
  static const _pollInterval = Duration(seconds: 15);
  Timer? _timer;

  @override
  AsyncValue<List<OrderRecord>> build() {
    ref.onDispose(() => _timer?.cancel());
    _timer = Timer.periodic(_pollInterval, (_) => _refresh());
    unawaited(_refresh());
    return const AsyncValue.loading();
  }

  Future<void> _refresh() async {
    try {
      final orders = await ref
          .read(serverpodClientProvider)
          .onlineOrderManagement
          .listUnhandled();
      state = AsyncValue.data(orders);
    } catch (e, stackTrace) {
      if (!state.hasValue) {
        state = AsyncValue.error(e, stackTrace);
      }
      // Otherwise keep showing the last known-good list -- a transient
      // poll failure shouldn't flash an error over a perfectly fine one.
    }
  }

  /// Forces an immediate refresh -- called right after marking an order
  /// handled (manually or via auto-print) so it drops out of the list
  /// straight away instead of waiting for the next poll.
  Future<void> refreshNow() => _refresh();
}

final onlineOrdersProvider =
    AutoDisposeNotifierProvider<OnlineOrdersController, AsyncValue<List<OrderRecord>>>(
      OnlineOrdersController.new,
    );
