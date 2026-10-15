import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/local_cache.dart';
import '../../../core/serverpod/serverpod_client_provider.dart';

const _ingredientsCacheKey = 'cache.ingredients';

/// The customization catalog shown when ordering a customizable item (see
/// [MenuItemRecord.isCustomizable]) -- both base ingredients ("menghir") and
/// sauces together; split by [IngredientRecord.kind] on the consuming side.
/// Cache-through like [rewardsCatalogProvider] -- small, mostly-static
/// catalog data, not worth the more involved cache-first/reachability-
/// triggered refresh [menuProvider] uses.
final ingredientsProvider = FutureProvider.autoDispose<List<IngredientRecord>>((
  ref,
) async {
  final cache = ref.watch(localCacheProvider);
  try {
    final items = await ref.watch(serverpodClientProvider).menu.getIngredients();
    await cache.writeList(
      _ingredientsCacheKey,
      items,
      (item) => item.toJson(),
    );
    return items;
  } catch (e) {
    final cached = await cache.readList(
      _ingredientsCacheKey,
      IngredientRecord.fromJson,
    );
    if (cached != null) return cached;
    rethrow;
  }
});
