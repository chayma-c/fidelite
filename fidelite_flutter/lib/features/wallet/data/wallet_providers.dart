import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/local_cache.dart';
import '../../../core/serverpod/serverpod_client_provider.dart';

const _balanceCacheKey = 'cache.wallet.balance';
const _pointsHistoryCacheKey = 'cache.wallet.pointsHistory';

/// Current cashback balance, in millimes. Always the sum of the customer's
/// points ledger entries server-side -- not a cached column -- so this is
/// re-fetched (via [claimControllerProvider]'s invalidation) after every
/// successful claim rather than updated optimistically client-side.
///
/// Cache-through like [menuProvider] -- shows the last-known balance
/// instead of an error when offline. Since claiming/redeeming both require
/// a live connection anyway, a stale balance here can never actually be
/// spent incorrectly; it's read-only display.
final balanceProvider = FutureProvider.autoDispose<int>((ref) async {
  final cache = ref.watch(localCacheProvider);
  try {
    final balance = await ref.watch(serverpodClientProvider).wallet.getBalance();
    await cache.writeValue(_balanceCacheKey, balance);
    return balance;
  } catch (e) {
    final cached = await cache.readValue<int>(
      _balanceCacheKey,
      (json) => json as int,
    );
    if (cached != null) return cached;
    rethrow;
  }
});

final pointsHistoryProvider = FutureProvider.autoDispose<
  List<PointsLedgerEntryRecord>
>((ref) async {
  final cache = ref.watch(localCacheProvider);
  try {
    // The generated client doesn't carry over the server-side default for
    // `limit` -- Serverpod's codegen makes every endpoint parameter
    // required on the client stub regardless of a default on the server
    // method, so this always has to be passed explicitly.
    final history = await ref
        .watch(serverpodClientProvider)
        .wallet
        .getPointsHistory(limit: 50);
    await cache.writeList(
      _pointsHistoryCacheKey,
      history,
      (entry) => entry.toJson(),
    );
    return history;
  } catch (e) {
    final cached = await cache.readList(
      _pointsHistoryCacheKey,
      PointsLedgerEntryRecord.fromJson,
    );
    if (cached != null) return cached;
    rethrow;
  }
});
