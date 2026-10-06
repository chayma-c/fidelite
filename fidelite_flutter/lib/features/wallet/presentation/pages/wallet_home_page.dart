import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../../core/theme/theme_mode_menu_button.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../orders/presentation/pages/customer_order_page.dart';
import '../../../rewards/presentation/pages/rewards_catalog_page.dart';
import '../../../scanner/presentation/pages/qr_scanner_page.dart';
import '../../../shop/data/shop_status_providers.dart';
import '../../../shop/presentation/widgets/shop_status_banner.dart';
import '../../data/wallet_providers.dart';
import '../controllers/claim_controller.dart';
import 'points_history_page.dart';
import 'wallet_qr_page.dart';

class WalletHomePage extends ConsumerWidget {
  const WalletHomePage({super.key});

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

    final balanceAsync = ref.watch(balanceProvider);
    final isClaiming = ref.watch(claimControllerProvider) is ClaimInProgress;
    final isShopOpen =
        ref.watch(shopStatusProvider).valueOrNull == ShopOpenStatus.open;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fidélité', overflow: TextOverflow.ellipsis),
        titleSpacing: 0,
        actions: [
          const ThemeModeMenuButton(),
          IconButton(
            icon: const Icon(Icons.card_giftcard),
            tooltip: 'Rewards',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const RewardsCatalogPage(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'History',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const PointsHistoryPage(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ShopStatusBanner(),
            const SizedBox(height: 24),
            Text('Your balance', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            balanceAsync.when(
              data: (balance) => Text(
                balance.asDinars,
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Could not load balance:\n$error'),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: isShopOpen ? () => _orderNow(context) : null,
              icon: const Icon(Icons.restaurant_menu),
              label: Text(
                isShopOpen ? 'Order now' : 'Order now (shop is closed)',
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: isClaiming ? null : () => _scanReceipt(context, ref),
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan receipt to earn cashback'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const WalletQrPage(),
                ),
              ),
              icon: const Icon(Icons.qr_code),
              label: const Text('Show my QR to redeem'),
            ),
          ],
        ),
      ),
    );
  }

  void _orderNow(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const CustomerOrderPage()),
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
