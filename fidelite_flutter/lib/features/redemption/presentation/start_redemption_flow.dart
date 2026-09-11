import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';

import '../../scanner/presentation/pages/qr_scanner_page.dart';
import 'pages/reward_picker_page.dart';

/// Opens the shared scanner for a customer's wallet QR, parses the
/// `FIDWALLET1:<userId>:<token>` payload (produced by WalletQrController on
/// the customer's side), and pushes the reward picker. Kept as a plain
/// function rather than a dedicated "scan" page/controller -- there's no
/// state here worth a Riverpod provider, just scan-then-navigate.
Future<void> startRedemptionFlow(BuildContext context) async {
  final scanned = await Navigator.of(context).push<String>(
    MaterialPageRoute(
      builder: (context) =>
          const QrScannerPage(title: 'Scan customer wallet QR'),
    ),
  );
  if (scanned == null) return;

  final parsed = _parseWalletQr(scanned);
  if (parsed == null) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('That QR code is not a valid A&A wallet code.'),
        ),
      );
    }
    return;
  }

  if (context.mounted) {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RewardPickerPage(
          walletUserId: parsed.walletUserId,
          walletToken: parsed.walletToken,
        ),
      ),
    );
  }
}

({UuidValue walletUserId, String walletToken})? _parseWalletQr(
  String payload,
) {
  final parts = payload.split(':');
  if (parts.length != 3 || parts[0] != 'FIDWALLET1') return null;
  return (walletUserId: UuidValue.fromString(parts[1]), walletToken: parts[2]);
}
