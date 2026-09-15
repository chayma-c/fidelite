import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme_mode_menu_button.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../menu/data/menu_providers.dart';
import '../../../redemption/presentation/start_redemption_flow.dart';
import '../controllers/cart_controller.dart';
import '../controllers/order_submission_controller.dart';
import '../widgets/cart_panel.dart';
import '../widgets/menu_item_card.dart';

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
      } else if (next is OrderSubmissionSuccess) {
        context.push(AppRoutes.orderConfirmation);
      }
    });

    final menuAsync = ref.watch(menuProvider);
    final cartCount = ref.watch(
      cartControllerProvider.select((cart) => cart.length),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fidélité — Order', overflow: TextOverflow.ellipsis),
        titleSpacing: 0,
        actions: [
          const ThemeModeMenuButton(),
          IconButton(
            icon: const Icon(Icons.card_giftcard),
            tooltip: 'Redeem a reward',
            onPressed: () => startRedemptionFlow(context),
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

class _Body extends StatelessWidget {
  const _Body({required this.items});

  final List<MenuItemRecord> items;

  @override
  Widget build(BuildContext context) {
    final byCategory = <String, List<MenuItemRecord>>{};
    for (final item in items) {
      byCategory.putIfAbsent(item.category, () => []).add(item);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // During a live window resize, the browser can report a single
        // transient frame with ~0 width before settling on the real size.
        // SliverGrid can't compute a positive column width from that, so
        // skip building the grid for that one degenerate frame rather than
        // letting it assert.
        if (constraints.maxWidth <= 0) {
          return const SizedBox.shrink();
        }

        final menuList = _MenuList(byCategory: byCategory);
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
    );
  }
}

class _MenuList extends ConsumerWidget {
  const _MenuList({required this.byCategory});

  final Map<String, List<MenuItemRecord>> byCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        for (final entry in byCategory.entries) ...[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                entry.key,
                style: Theme.of(context).textTheme.titleMedium,
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
