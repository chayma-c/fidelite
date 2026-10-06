import 'dart:async';

import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/local_cache.dart';
import '../../../core/serverpod/serverpod_client_provider.dart';

const _shopStatusCacheKey = 'cache.shopStatus';

/// Whether the restaurant is currently open, closed, or on a break --
/// shown to every customer the instant they open the app.
///
/// Unlike the menu/sales providers (cache-first, deliberately minimal
/// server traffic -- see MenuController), this one is network-first and
/// polls every 15s for as long as anything on screen is actually watching
/// it. Staleness here means a customer might walk over to a shop that
/// just closed -- a materially worse outcome than the extra handful of
/// small requests this costs. `autoDispose` means the polling stops the
/// instant nothing needs it anymore.
class ShopStatusController
    extends AutoDisposeNotifier<AsyncValue<ShopOpenStatus>> {
  static const _pollInterval = Duration(seconds: 15);
  Timer? _timer;

  @override
  AsyncValue<ShopOpenStatus> build() {
    ref.onDispose(() => _timer?.cancel());
    _timer = Timer.periodic(_pollInterval, (_) => _refresh());
    unawaited(_refresh());
    return const AsyncValue.loading();
  }

  Future<void> _refresh() async {
    try {
      final record = await ref.read(serverpodClientProvider).shopStatus.getStatus();
      await ref
          .read(localCacheProvider)
          .writeValue(_shopStatusCacheKey, record.status.name);
      state = AsyncValue.data(record.status);
    } catch (e, stackTrace) {
      if (state.hasValue) {
        // Keep showing the last known-good reading rather than flashing
        // an error over it just because one poll failed transiently.
        return;
      }
      final cached = await ref
          .read(localCacheProvider)
          .readValue<String>(_shopStatusCacheKey, (json) => json as String);
      state = cached != null
          ? AsyncValue.data(ShopOpenStatus.values.byName(cached))
          : AsyncValue.error(e, stackTrace);
    }
  }
}

final shopStatusProvider =
    AutoDisposeNotifierProvider<ShopStatusController, AsyncValue<ShopOpenStatus>>(
      ShopStatusController.new,
    );
