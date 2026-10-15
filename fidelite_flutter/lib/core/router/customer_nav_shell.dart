import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/scanner/presentation/pages/qr_scanner_page.dart';
import '../../features/wallet/presentation/controllers/claim_controller.dart';
import '../money/millimes_formatting.dart';
import '../theme/app_theme.dart';

/// The customer-facing bottom navigation chrome: Home / Order / Rewards /
/// Activity, with "scan a receipt to earn cashback" as a raised, docked
/// button in the middle -- it's a one-off action, not a browsable section,
/// so it isn't a fifth tab/branch; it's reachable from wherever the
/// customer currently is instead of only from Home.
///
/// Wired up via `StatefulShellRoute.indexedStack` in app_router.dart,
/// which gives each of the four real tabs its own independent navigation
/// stack -- pushing a modal screen (the cart sheet, the QR scanner) from
/// one tab doesn't disturb the others, and switching away and back
/// preserves whatever that tab was doing.
class CustomerNavShell extends ConsumerWidget {
  const CustomerNavShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ClaimState>(claimControllerProvider, (previous, next) {
      switch (next) {
        case ClaimFailure():
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.message)));
          ref.read(claimControllerProvider.notifier).reset();
        case ClaimSuccess():
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Cashback earned!'),
              content: Text(
                '+${next.result.pointsEarnedMillimes.asDinars}\n\n'
                'New balance: ${next.result.newBalanceMillimes.asDinars}',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          ref.read(claimControllerProvider.notifier).reset();
        case ClaimIdle():
        case ClaimInProgress():
          break;
      }
    });

    final isClaiming = ref.watch(claimControllerProvider) is ClaimInProgress;

    return Scaffold(
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: isClaiming ? null : () => _scanReceipt(context, ref),
        tooltip: 'Scan receipt to earn cashback',
        child: isClaiming
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.ink,
                ),
              )
            : const Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          children: [
            _BottomBarItem(
              icon: Icons.storefront_outlined,
              selectedIcon: Icons.storefront,
              label: 'Home',
              selected: navigationShell.currentIndex == 0,
              onTap: () => _goBranch(0),
            ),
            _BottomBarItem(
              icon: Icons.restaurant_menu_outlined,
              selectedIcon: Icons.restaurant_menu,
              label: 'Order',
              selected: navigationShell.currentIndex == 1,
              onTap: () => _goBranch(1),
            ),
            // Reserves the gap the docked FAB sits in.
            const SizedBox(width: 48),
            _BottomBarItem(
              icon: Icons.card_giftcard_outlined,
              selectedIcon: Icons.card_giftcard,
              label: 'Rewards',
              selected: navigationShell.currentIndex == 2,
              onTap: () => _goBranch(2),
            ),
            _BottomBarItem(
              icon: Icons.history_outlined,
              selectedIcon: Icons.history,
              label: 'Activity',
              selected: navigationShell.currentIndex == 3,
              onTap: () => _goBranch(3),
            ),
          ],
        ),
      ),
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // Tapping the tab you're already on pops it back to its root --
      // the same "tap again to go home" behavior most tabbed apps use.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Future<void> _scanReceipt(BuildContext context, WidgetRef ref) async {
    final scanned = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => const QrScannerPage(title: 'Scan your receipt'),
      ),
    );
    if (scanned != null) {
      await ref.read(claimControllerProvider.notifier).claim(scanned);
    }
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = selected ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        // FittedBox rather than a fixed padding budget -- BottomAppBar's
        // actual content height (once its own internal padding and the
        // docked-FAB notch allowance are accounted for) isn't something
        // this widget can predict precisely, so scale to whatever's
        // actually available instead of risking another overflow.
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(selected ? selectedIcon : icon, color: color),
              const SizedBox(height: 2),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
