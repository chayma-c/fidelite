import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../controllers/wallet_qr_controller.dart';

class WalletQrPage extends ConsumerWidget {
  const WalletQrPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(walletQrControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Your wallet QR')),
      body: Center(
        child: switch (state) {
          WalletQrLoading() => const CircularProgressIndicator(),
          WalletQrError(:final message) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () =>
                      ref.read(walletQrControllerProvider.notifier).refreshNow(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          WalletQrReady(:final payload, :final balanceMillimes) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Balance', style: Theme.of(context).textTheme.titleMedium),
              Text(
                balanceMillimes.asDinars,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              QrImageView(data: payload, size: 220),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Show this to staff to redeem a reward. Refreshes '
                  'automatically, so it always stays valid.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        },
      ),
    );
  }
}
