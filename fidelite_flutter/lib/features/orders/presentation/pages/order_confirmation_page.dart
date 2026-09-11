import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../../core/printing/printing_providers.dart';
import '../../../../core/printing/receipt.dart';
import '../controllers/order_submission_controller.dart';

/// Shown right after a successful [OrderSubmissionController.submit] call.
/// Reads the result straight from the controller's state rather than via
/// route parameters -- the state already holds everything needed and stays
/// valid for exactly as long as this page is relevant.
class OrderConfirmationPage extends ConsumerWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submission = ref.watch(orderSubmissionControllerProvider);

    if (submission is! OrderSubmissionSuccess) {
      // Reached directly (e.g. browser back/forward) without a live result.
      return Scaffold(
        appBar: AppBar(title: const Text('Order')),
        body: Center(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back to order screen'),
          ),
        ),
      );
    }

    final order = submission.confirmation.order;
    final receipt = Receipt(
      orderId: order.id!,
      createdAt: order.createdAt,
      totalMillimes: order.totalMillimes,
      claimQrPayload: submission.confirmation.claimQrPayload,
      lines: [
        for (final line in submission.lines)
          ReceiptLine(
            name: line.menuItem.name,
            quantity: line.quantity,
            lineTotalMillimes: line.lineTotalMillimes,
          ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: Text('Order #${receipt.orderId}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              'Order confirmed',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      for (final line in receipt.lines)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('${line.quantity}x ${line.name}'),
                              ),
                              Text(line.lineTotalMillimes.asDinars),
                            ],
                          ),
                        ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            receipt.totalMillimes.asDinars,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Column(
                          children: [
                            QrImageView(
                              data: receipt.claimQrPayload,
                              size: 160,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Customer scans this to earn cashback',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('New order'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () async {
                      await ref
                          .read(receiptPrinterProvider)
                          .printReceipt(receipt);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'No printer configured yet — receipt shown above only.',
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.print),
                    label: const Text('Print ticket'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
