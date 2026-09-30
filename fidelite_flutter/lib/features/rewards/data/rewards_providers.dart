import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/local_cache.dart';
import '../../../core/serverpod/serverpod_client_provider.dart';

const _rewardsCacheKey = 'cache.rewards';

/// The active reward catalog, shared by the customer's browsing page and
/// staff's redemption reward-picker. Cache-through like [menuProvider] --
/// see that provider's doc comment for why.
final rewardsCatalogProvider = FutureProvider.autoDispose<
  List<RewardItemRecord>
>((ref) async {
  final cache = ref.watch(localCacheProvider);
  try {
    final items = await ref.watch(serverpodClientProvider).rewards.getCatalog();
    await cache.writeList(_rewardsCacheKey, items, (item) => item.toJson());
    return items;
  } catch (e) {
    final cached = await cache.readList(
      _rewardsCacheKey,
      RewardItemRecord.fromJson,
    );
    if (cached != null) return cached;
    rethrow;
  }
});
