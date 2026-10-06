import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../menu/data/menu_providers.dart';
import '../../../shop/presentation/widgets/shop_status_banner.dart';
import '../controllers/cart_controller.dart';
import '../controllers/online_order_submission_controller.dart';
import '../widgets/customer_cart_panel.dart';
import '../widgets/menu_item_card.dart';
import 'online_order_confirmation_page.dart';

/// Wide-layout breakpoint matching OrderBuilderPage's -- below this the
/// cart moves into a bottom sheet instead of sitting beside the menu.
const _wideLayoutBreakpoint = 700.0;

/// Lets a customer browse the menu and place their own order instead of
/// waiting at the counter. Reached from WalletHomePage's "Order now"
/// button, which already only enables when the shop is open -- this page
/// re-watches shop status itself too, so a shop closing while the customer
/// is still browsing is caught here (see CustomerCartPanel) rather than
/// only failing at submit time.
class CustomerOrderPage extends ConsumerWidget {
  const CustomerOrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<OnlineOrderSubmissionState>(
      onlineOrderSubmissionControllerProvider,
      (previous, next) {
        switch (next) {
          case OnlineOrderSubmissionFailure():
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(next.message)));
            ref.read(onlineOrderSubmissionControllerProvider.notifier).reset();
          case OnlineOrderSubmissionSuccess():
            Navigator.of(context)
                .push(
                  MaterialPageRoute<void>(
                    builder: (context) => OnlineOrderConfirmationPage(
                      confirmation: next.confirmation,
                      lines: next.lines,
                    ),
                  ),
                )
                .then((_) {
                  ref
                      .read(onlineOrderSubmissionControllerProvider.notifier)
                      .reset();
                });
          case OnlineOrderSubmissionIdle():
          case OnlineOrderSubmissionInProgress():
            break;
        }
      },
    );

    final menuAsync = ref.watch(menuProvider);
    final cartCount = ref.watch(
      cartControllerProvider.select((cart) => cart.length),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Order')),
      body: Column(
        children: [
          const ShopStatusBanner(),
          Expanded(
            child: menuAsync.when(
              data: (items) => _Body(items: items),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text(
                  'Could not load the menu:\n$error',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
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
        child: const CustomerCartPanel(),
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
        // Guards against the single transient ~0-width frame a browser can
        // report mid-resize, which SliverGrid can't lay out from.
        if (constraints.maxWidth <= 0) {
          return const SizedBox.shrink();
        }

        final menuList = _MenuList(byCategory: byCategory);
        if (constraints.maxWidth >= _wideLayoutBreakpoint) {
          return Row(
            children: [
              Expanded(flex: 3, child: menuList),
              const VerticalDivider(width: 1),
              const Expanded(flex: 2, child: CustomerCartPanel()),
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
