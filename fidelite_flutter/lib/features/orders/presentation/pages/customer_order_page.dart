import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../menu/data/menu_providers.dart';
import '../../../shop/presentation/widgets/shop_status_banner.dart';
import '../controllers/cart_controller.dart';
import '../controllers/online_order_submission_controller.dart';
import '../widgets/customer_cart_panel.dart';
import '../widgets/item_customization_sheet.dart';
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
    final cartTotal = ref.watch(
      cartControllerProvider.select(
        (cart) => cart.fold<int>(0, (sum, line) => sum + line.lineTotalMillimes),
      ),
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
      // A pinned bar rather than a FloatingActionButton -- Scaffold shrinks
      // the body to make room for it automatically, so (unlike the FAB it
      // replaces) nothing needs manual bottom padding to avoid an overlap.
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= _wideLayoutBreakpoint || cartCount == 0) {
            return const SizedBox.shrink();
          }
          return _StickyCartBar(
            itemCount: cartCount,
            totalMillimes: cartTotal,
            onTap: () => _showCartSheet(context),
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

/// A full-width pinned summary replacing the old floating "Cart (N)"
/// button -- always visible once the cart has items, instead of a button
/// that could be missed or sit over content.
class _StickyCartBar extends StatelessWidget {
  const _StickyCartBar({
    required this.itemCount,
    required this.totalMillimes,
    required this.onTap,
  });

  final int itemCount;
  final int totalMillimes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
      color: colorScheme.onInverseSurface,
    );
    return Material(
      color: colorScheme.inverseSurface,
      child: InkWell(
        onTap: onTap,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(Icons.shopping_cart, color: colorScheme.onInverseSurface),
                const SizedBox(width: 10),
                Text(
                  itemCount == 1 ? '1 item' : '$itemCount items',
                  style: textStyle,
                ),
                const Spacer(),
                Text(
                  totalMillimes.asDinars,
                  style: textStyle?.copyWith(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.chevron_right, color: colorScheme.onInverseSurface),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body({required this.items});

  final List<MenuItemRecord> items;

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  final _scrollController = ScrollController();
  final _chipRowKey = GlobalKey();
  final Map<String, GlobalKey> _categoryKeys = {};
  String? _activeCategory;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveCategory);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _updateActiveCategory(),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveCategory);
    _scrollController.dispose();
    super.dispose();
  }

  List<String> _categoriesOf(List<MenuItemRecord> items) {
    final seen = <String>{};
    final categories = <String>[];
    for (final item in items) {
      if (seen.add(item.category)) categories.add(item.category);
    }
    return categories;
  }

  /// Picks the category whose heading has scrolled up past the chip row
  /// as the "active" one, by comparing each heading's current on-screen
  /// position against the chip row's bottom edge. Cheap enough to run on
  /// every scroll tick: a handful of RenderBox lookups for a menu with a
  /// handful of categories.
  void _updateActiveCategory() {
    final chipRowBox =
        _chipRowKey.currentContext?.findRenderObject() as RenderBox?;
    if (chipRowBox == null) return;
    final threshold =
        chipRowBox.localToGlobal(Offset.zero).dy + chipRowBox.size.height;

    final categories = _categoriesOf(widget.items);
    String? current;
    for (final category in categories) {
      final box =
          _categoryKeys[category]?.currentContext?.findRenderObject()
              as RenderBox?;
      if (box == null) continue;
      if (box.localToGlobal(Offset.zero).dy <= threshold + 1) {
        current = category;
      } else {
        break;
      }
    }
    current ??= categories.isEmpty ? null : categories.first;
    if (current != _activeCategory) {
      setState(() => _activeCategory = current);
    }
  }

  void _scrollToCategory(String category) {
    final context = _categoryKeys[category]?.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final byCategory = <String, List<MenuItemRecord>>{};
    for (final item in widget.items) {
      byCategory.putIfAbsent(item.category, () => []).add(item);
      _categoryKeys.putIfAbsent(item.category, GlobalKey.new);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Guards against the single transient ~0-width frame a browser can
        // report mid-resize, which SliverGrid can't lay out from.
        if (constraints.maxWidth <= 0) {
          return const SizedBox.shrink();
        }

        final menuColumn = Column(
          children: [
            _CategoryChipRow(
              key: _chipRowKey,
              categories: byCategory.keys.toList(),
              activeCategory: _activeCategory,
              onSelected: _scrollToCategory,
            ),
            Expanded(
              child: _MenuList(
                byCategory: byCategory,
                categoryKeys: _categoryKeys,
                scrollController: _scrollController,
              ),
            ),
          ],
        );

        if (constraints.maxWidth >= _wideLayoutBreakpoint) {
          return Row(
            children: [
              Expanded(flex: 3, child: menuColumn),
              const VerticalDivider(width: 1),
              const Expanded(flex: 2, child: CustomerCartPanel()),
            ],
          );
        }
        return menuColumn;
      },
    );
  }
}

/// Lets a customer jump straight to a category instead of scrolling past
/// everything ahead of it -- the active chip tracks scroll position so it
/// also works as a "where am I" indicator while browsing normally.
class _CategoryChipRow extends StatelessWidget {
  const _CategoryChipRow({
    required super.key,
    required this.categories,
    required this.activeCategory,
    required this.onSelected,
  });

  final List<String> categories;
  final String? activeCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    if (categories.length <= 1) return const SizedBox.shrink();

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ChoiceChip(
            label: Text(category),
            selected: category == activeCategory,
            onSelected: (_) => onSelected(category),
          );
        },
      ),
    );
  }
}

class _MenuList extends ConsumerWidget {
  const _MenuList({
    required this.byCategory,
    required this.categoryKeys,
    required this.scrollController,
  });

  final Map<String, List<MenuItemRecord>> byCategory;
  final Map<String, GlobalKey> categoryKeys;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        for (final entry in byCategory.entries) ...[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                entry.key,
                key: categoryKeys[entry.key],
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
                    onTap: () => _onItemTap(context, ref, menuItem),
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

  /// A customizable item (sandwich/malfouf/chapati -- see
  /// MenuItemRecord.isCustomizable) opens the "leave out an ingredient /
  /// add a sauce / special request" sheet before adding to the cart;
  /// anything else (plates, suppléments) still just adds directly, same as
  /// before customization existed.
  Future<void> _onItemTap(
    BuildContext context,
    WidgetRef ref,
    MenuItemRecord menuItem,
  ) async {
    if (!menuItem.isCustomizable) {
      ref.read(cartControllerProvider.notifier).addItem(menuItem);
      return;
    }

    final result = await showItemCustomizationSheet(
      context,
      menuItem: menuItem,
    );
    if (result == null) return;

    ref
        .read(cartControllerProvider.notifier)
        .addCustomizedItem(
          menuItem,
          removedIngredients: result.removedIngredients,
          addedSauces: result.addedSauces,
          specialRequest: result.specialRequest,
        );
  }
}
