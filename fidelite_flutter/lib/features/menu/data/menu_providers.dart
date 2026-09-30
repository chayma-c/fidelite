import 'dart:async';

import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/local_cache.dart';
import '../../../core/connectivity/server_reachability_provider.dart';
import '../../../core/serverpod/serverpod_client_provider.dart';

const _menuCacheKey = 'cache.menu';

/// The active menu, grouped/sorted server-side by category then
/// [MenuItemRecord.sortOrder]. Uses the generated [MenuItemRecord] directly
/// as the domain type here -- Serverpod's protocol classes already are the
/// shared model between client and server, so a parallel wrapper entity
/// would just duplicate it.
///
/// Cache-first, not cache-through: whatever's on disk is shown immediately
/// -- no waiting on the network on every screen visit -- and a fresh copy
/// is only fetched in the background, opportunistically (once at startup,
/// and again whenever [serverReachabilityProvider] flips from offline back
/// to online). This is deliberately not on its own polling timer; the
/// reachability check is the only thing that runs on a clock, and this
/// just rides along with it, which is what keeps total server traffic
/// down. Only ever waits on the network if there's truly nothing cached
/// yet (the very first launch).
class MenuController extends AutoDisposeNotifier<AsyncValue<List<MenuItemRecord>>> {
  @override
  AsyncValue<List<MenuItemRecord>> build() {
    ref.listen(serverReachabilityProvider, (previous, next) {
      if (previous == ServerReachability.offline &&
          next == ServerReachability.online) {
        unawaited(_refresh());
      }
    });

    unawaited(_loadInitial());
    return const AsyncValue.loading();
  }

  /// Forces an immediate real refresh, bypassing the cached value --
  /// staff editing an item in Manage Menu expects to see the change land
  /// right away, not the pre-edit cache replayed first. Call this (not
  /// `ref.invalidate`) after a successful menu edit.
  Future<void> refreshNow() => _refresh();

  Future<void> _loadInitial() async {
    final cached = await ref
        .read(localCacheProvider)
        .readList(_menuCacheKey, MenuItemRecord.fromJson);
    if (cached != null) {
      state = AsyncValue.data(cached);
      unawaited(_refresh());
      return;
    }
    await _refresh();
  }

  Future<void> _refresh() async {
    try {
      final items = await ref.read(serverpodClientProvider).menu.getMenu();
      await ref
          .read(localCacheProvider)
          .writeList(_menuCacheKey, items, (item) => item.toJson());
      state = AsyncValue.data(items);
    } catch (e, stackTrace) {
      // Keep showing whatever's already on screen; the connectivity
      // indicator already communicates the problem. Only surface the
      // error if there's genuinely nothing to show at all.
      if (!state.hasValue) {
        state = AsyncValue.error(e, stackTrace);
      }
    }
  }
}

final menuProvider =
    AutoDisposeNotifierProvider<MenuController, AsyncValue<List<MenuItemRecord>>>(
      MenuController.new,
    );

/// Every menu item, active or not -- for the staff management list. Kept
/// separate from [menuProvider] (which only ever shows what customers/staff
/// can currently order) since the management screen also needs to show and
/// restore deactivated items.
final menuManagementProvider = FutureProvider.autoDispose<List<MenuItemRecord>>((
  ref,
) {
  return ref.watch(serverpodClientProvider).menuManagement.listAllMenuItems();
});

/// Distinct categories currently in use, for the add/edit form's category
/// picker.
final menuCategoriesProvider = FutureProvider.autoDispose<List<String>>((ref) {
  return ref.watch(serverpodClientProvider).menuManagement.getCategories();
});
