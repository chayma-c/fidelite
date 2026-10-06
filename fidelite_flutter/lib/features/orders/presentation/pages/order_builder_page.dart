import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/connectivity/connectivity_provider.dart';
import '../../../../core/connectivity/server_reachability_provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../../core/theme/theme_mode_menu_button.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../menu/data/menu_providers.dart';
import '../../../menu/presentation/pages/menu_management_page.dart';
import '../../../redemption/presentation/start_redemption_flow.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../shop/presentation/pages/shop_status_page.dart';
import '../../data/online_order_providers.dart';
import '../controllers/cart_controller.dart';
import '../controllers/online_order_printing_controller.dart';
import '../controllers/order_submission_controller.dart';
import '../controllers/pending_order_queue_controller.dart';
import '../widgets/cart_panel.dart';
import '../widgets/menu_item_card.dart';
import 'online_orders_page.dart';
import 'pending_orders_page.dart';
import 'sales_history_page.dart';

enum _StaffMenuAction {
  manageMenu,
  pendingOrders,
  salesHistory,
  shopStatus,
  settings,
}

/// Wide-layout breakpoint: side-by-side menu + cart, matching a tablet held
/// in landscape (the staff device). Below this, the cart moves into a
/// bottom sheet so the app stays usable on a phone too.
const _wideLayoutBreakpoint = 700.0;

class OrderBuilderPage extends ConsumerWidget {
  const OrderBuilderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<OrderSubmissionState>(orderSubmissionControllerProvider, (
      previous,
      next,
    ) {
      if (next is OrderSubmissionFailure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message)));
        ref.read(orderSubmissionControllerProvider.notifier).reset();
      } else if (next is OrderSubmissionSuccess || next is OrderSubmissionQueued) {
        context.push(AppRoutes.orderConfirmation);
      }
    });

    // Fast path only: when the OS reports the network is back, check real
    // server reachability right away instead of waiting for the next
    // periodic tick (up to 60s away). The OS signal never drives anything
    // by itself -- see ServerReachabilityController for why an actual
    // answer from the backend is the real signal.
    ref.listen<AsyncValue<bool>>(isOnlineProvider, (previous, next) {
      final wasOffline = previous?.valueOrNull == false;
      final isOnlineNow = next.valueOrNull == true;
      if (wasOffline && isOnlineNow) {
        ref.read(serverReachabilityProvider.notifier).checkNow();
      }
    });

    // Reconnecting no longer auto-syncs queued orders -- staff sync
    // deliberately, with the button in the app bar, once they're ready for
    // that (see the sync button's doc comment for why automatic syncing
    // was actively harmful, not just noisy). This toast is just a status
    // update, not a trigger for anything.
    ref.listen<ServerReachability>(serverReachabilityProvider, (
      previous,
      next,
    ) {
      final isRealTransition =
          previous != null &&
          previous != ServerReachability.unknown &&
          previous != next;
      if (!isRealTransition) return;
      final messenger = ScaffoldMessenger.of(context);
      messenger.clearSnackBars();
      messenger.showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            next == ServerReachability.online
                ? 'Back online'
                : 'Working locally',
          ),
        ),
      );
    });

    // Auto-print: whenever the unhandled-online-orders list changes (new
    // order arrived, or a previous attempt failed and is still sitting
    // there), try to print+handle each one -- but only if staff has
    // actually turned this on in Settings. Printing failures are left
    // alone deliberately (no snackbar spam every 15s) -- a persistently
    // failing order just stays in the queue, visible via the badge, for
    // staff to notice and print manually instead.
    ref.listen<AsyncValue<List<OrderRecord>>>(onlineOrdersProvider, (
      previous,
      next,
    ) async {
      final orders = next.valueOrNull;
      if (orders == null || orders.isEmpty) return;

      final settings = await ref
          .read(serverpodClientProvider)
          .onlineOrderSettings
          .getSettings();
      if (!settings.autoPrintEnabled) return;

      final printing = ref.read(onlineOrderPrintingControllerProvider);
      for (final order in orders) {
        try {
          await printing.printAndMarkHandled(order);
        } catch (_) {
          // Stays in the queue; retried next poll tick.
        }
      }
    });

    final menuAsync = ref.watch(menuProvider);
    final cartCount = ref.watch(
      cartControllerProvider.select((cart) => cart.length),
    );
    final reachability = ref.watch(serverReachabilityProvider);
    final pendingState = ref.watch(pendingOrderQueueControllerProvider);
    final pendingCount =
        pendingState.queued.length + pendingState.readyToPrint.length;
    final onlineOrderCount =
        ref.watch(onlineOrdersProvider).valueOrNull?.length ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fidélité — Order', overflow: TextOverflow.ellipsis),
        titleSpacing: 0,
        actions: [
          _ConnectivityIndicator(reachability: reachability),
          _SyncButton(
            queuedCount: pendingState.queued.length,
            isSyncing: pendingState.isSyncing,
          ),
          IconButton(
            icon: Badge(
              label: Text('$onlineOrderCount'),
              isLabelVisible: onlineOrderCount > 0,
              child: const Icon(Icons.notifications_outlined),
            ),
            tooltip: onlineOrderCount > 0
                ? '$onlineOrderCount online order${onlineOrderCount == 1 ? '' : 's'} waiting'
                : 'Online orders',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const OnlineOrdersPage(),
              ),
            ),
          ),
          const ThemeModeMenuButton(),
          IconButton(
            icon: const Icon(Icons.card_giftcard),
            tooltip: 'Redeem a reward',
            onPressed: () => startRedemptionFlow(context),
          ),
          PopupMenuButton<_StaffMenuAction>(
            tooltip: 'More',
            onSelected: (action) {
              final page = switch (action) {
                _StaffMenuAction.manageMenu => const MenuManagementPage(),
                _StaffMenuAction.pendingOrders => const PendingOrdersPage(),
                _StaffMenuAction.salesHistory => const SalesHistoryPage(),
                _StaffMenuAction.shopStatus => const ShopStatusPage(),
                _StaffMenuAction.settings => const SettingsPage(),
              };
              Navigator.of(
                context,
              ).push(MaterialPageRoute<void>(builder: (context) => page));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: _StaffMenuAction.manageMenu,
                child: ListTile(
                  leading: Icon(Icons.restaurant_menu),
                  title: Text('Manage menu'),
                ),
              ),
              PopupMenuItem(
                value: _StaffMenuAction.pendingOrders,
                child: ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: const Text('Pending orders'),
                  subtitle: pendingCount > 0
                      ? Text('$pendingCount waiting')
                      : null,
                ),
              ),
              const PopupMenuItem(
                value: _StaffMenuAction.salesHistory,
                child: ListTile(
                  leading: Icon(Icons.bar_chart),
                  title: Text('Sales history'),
                ),
              ),
              const PopupMenuItem(
                value: _StaffMenuAction.shopStatus,
                child: ListTile(
                  leading: Icon(Icons.storefront),
                  title: Text('Shop status'),
                ),
              ),
              const PopupMenuItem(
                value: _StaffMenuAction.settings,
                child: ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('Settings'),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
      body: menuAsync.when(
        data: (items) => _Body(items: items),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            'Could not load the menu:\n$error',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      bottomSheet: null,
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= _wideLayoutBreakpoint || cartCount == 0) {
            return const SizedBox.shrink();
          }
          return FloatingActionButton.extended(
            onPressed: () => _showCartSheet(context),
            icon: const Icon(Icons.shopping_cart),
            label: Text('Cart ($cartCount)'),
          );
        },
      ),
    );
  }

  void _showCartSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: const CartPanel(),
      ),
    );
  }
}

/// A small, deliberately calm at-a-glance signal of whether the backend is
/// actually reachable right now -- replaces a persistent red pending-order
/// count, which staff found stressful to look at rather than useful. No
/// color implies urgency; "offline" just means orders are being taken
/// locally and will sync later, which is normal, expected behavior, not a
/// problem to react to.
class _ConnectivityIndicator extends StatelessWidget {
  const _ConnectivityIndicator({required this.reachability});

  final ServerReachability reachability;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final (icon, tooltip) = switch (reachability) {
      ServerReachability.online => (Icons.cloud_done_outlined, 'Connected to server'),
      ServerReachability.offline => (Icons.cloud_off_outlined, 'Working locally -- will sync automatically'),
      ServerReachability.unknown => (Icons.cloud_queue_outlined, 'Checking connection...'),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Tooltip(
        message: tooltip,
        child: Icon(icon, size: 20, color: muted),
      ),
    );
  }
}

/// Staff-initiated sync, on purpose -- an earlier version synced
/// automatically the moment the server became reachable again, which
/// sounds convenient but actually caused real problems: a flaky reconnect
/// could trigger it more than once in quick succession (see
/// PendingOrderQueueController.syncAll's guard against that), and even a
/// single clean auto-sync would fire mid-order, background network
/// activity landing exactly when staff didn't ask for it. Staff now taps
/// this when they're actually ready, e.g. between customers.
class _SyncButton extends ConsumerWidget {
  const _SyncButton({required this.queuedCount, required this.isSyncing});

  final int queuedCount;
  final bool isSyncing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isSyncing) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return IconButton(
      icon: const Icon(Icons.sync),
      tooltip: queuedCount > 0
          ? 'Sync $queuedCount pending order${queuedCount == 1 ? '' : 's'}'
          : 'Nothing to sync',
      onPressed: queuedCount > 0
          ? () => ref.read(pendingOrderQueueControllerProvider.notifier).syncAll()
          : null,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({required this.items});

  final List<MenuItemRecord> items;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  /// One [GlobalKey] per category, used to scroll its section into view
  /// when its nav button is tapped. Kept in a field (not rebuilt from
  /// scratch every build) so the keys -- and therefore the scroll targets --
  /// stay stable across rebuilds; entries for categories that disappear
  /// (e.g. renamed/removed via menu management) are pruned so this can't
  /// grow unbounded.
  final Map<String, GlobalKey> _categoryKeys = {};

  @override
  Widget build(BuildContext context) {
    final byCategory = <String, List<MenuItemRecord>>{};
    for (final item in widget.items) {
      byCategory.putIfAbsent(item.category, () => []).add(item);
    }

    _categoryKeys.removeWhere((category, _) => !byCategory.containsKey(category));
    for (final category in byCategory.keys) {
      _categoryKeys.putIfAbsent(category, () => GlobalKey());
    }

    return Column(
      children: [
        if (byCategory.length > 1)
          _CategoryNavBar(
            categories: byCategory.keys.toList(),
            onSelect: _scrollToCategory,
          ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // During a live window resize, the browser can report a
              // single transient frame with ~0 width before settling on
              // the real size. SliverGrid can't compute a positive column
              // width from that, so skip building the grid for that one
              // degenerate frame rather than letting it assert.
              if (constraints.maxWidth <= 0) {
                return const SizedBox.shrink();
              }

              final menuList = _MenuList(
                byCategory: byCategory,
                categoryKeys: _categoryKeys,
              );
              if (constraints.maxWidth >= _wideLayoutBreakpoint) {
                return Row(
                  children: [
                    Expanded(flex: 3, child: menuList),
                    const VerticalDivider(width: 1),
                    const Expanded(flex: 2, child: CartPanel()),
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 72),
                child: menuList,
              );
            },
          ),
        ),
      ],
    );
  }

  void _scrollToCategory(String category) {
    final sectionContext = _categoryKeys[category]?.currentContext;
    if (sectionContext == null) return;
    Scrollable.ensureVisible(
      sectionContext,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

/// A horizontal row of category buttons above the menu -- lets staff jump
/// straight to a section instead of scrolling. Purely derived from whatever
/// categories are currently in [categories]; there's nothing hardcoded, so
/// editing categories in menu management is immediately reflected here.
class _CategoryNavBar extends StatelessWidget {
  const _CategoryNavBar({required this.categories, required this.onSelect});

  final List<String> categories;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        children: [
          for (final category in categories)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ActionChip(
                label: Text(category),
                onPressed: () => onSelect(category),
              ),
            ),
        ],
      ),
    );
  }
}

class _MenuList extends ConsumerWidget {
  const _MenuList({required this.byCategory, required this.categoryKeys});

  final Map<String, List<MenuItemRecord>> byCategory;
  final Map<String, GlobalKey> categoryKeys;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        for (final entry in byCategory.entries) ...[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: KeyedSubtree(
                key: categoryKeys[entry.key],
                child: Text(
                  entry.key,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                mainAxisExtent: 116,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final menuItem = entry.value[index];
                  return MenuItemCard(
                    menuItem: menuItem,
                    onTap: () => ref
                        .read(cartControllerProvider.notifier)
                        .addItem(menuItem),
                  );
                },
                childCount: entry.value.length,
              ),
            ),
          ),
        ],
        const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
      ],
    );
  }
}
