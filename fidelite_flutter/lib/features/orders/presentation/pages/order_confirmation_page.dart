import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../../core/printing/printing_providers.dart';
import '../../../../core/printing/rawbt_receipt_printer.dart';
import '../../../../core/printing/receipt.dart';
import '../controllers/order_submission_controller.dart';

/// Shown right after a successful or queued [OrderSubmissionController.
/// submit] call. Reads the result straight from the controller's state
/// rather than via route parameters -- the state already holds everything
/// needed and stays valid for exactly as long as this page is relevant.
class OrderConfirmationPage extends ConsumerWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submission = ref.watch(orderSubmissionControllerProvider);

    final Receipt receipt;
    final bool isQueued;
    switch (submission) {
      case OrderSubmissionSuccess():
        final order = submission.confirmation.order;
        receipt = Receipt(
          orderId: order.id!,
          ticketNumber: order.ticketNumber,
          createdAt: order.createdAt,
          totalMillimes: order.totalMillimes,
          claimQrPayload: submission.confirmation.claimQrPayload,
          lines: [
            for (final line in submission.lines)
              ReceiptLine(
                category: line.menuItem.category,
                name: line.menuItem.name,
                quantity: line.quantity,
                lineTotalMillimes: line.lineTotalMillimes,
              ),
          ],
        );
        isQueued = false;
      case OrderSubmissionQueued():
        final order = submission.order;
        receipt = Receipt(
          ticketNumber: order.ticketNumber,
          createdAt: order.createdAt,
          totalMillimes: order.estimatedTotalMillimes,
          lines: [
            for (final line in order.lines)
              ReceiptLine(
                category: line.category,
                name: line.name,
                quantity: line.quantity,
                lineTotalMillimes: line.lineTotalMillimes,
              ),
          ],
        );
        isQueued = true;
      default:
        // Reached directly (e.g. browser back/forward) without a live
        // result.
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          receipt.orderId == null ? 'Order queued' : 'Order #${receipt.orderId}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              isQueued ? Icons.cloud_off : Icons.check_circle,
              color: isQueued
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              isQueued
                  ? 'Order queued -- will sync automatically'
                  : 'Order confirmed',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Ticket #${receipt.ticketNumber}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
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
                                child: Text(
                                  '${line.quantity}x ${line.category}: ${line.name}',
                                ),
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
                            isQueued ? 'Estimated total' : 'Total',
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
                        child: switch (receipt.claimQrPayload) {
                          final payload? => Column(
                            children: [
                              QrImageView(data: payload, size: 160),
                              const SizedBox(height: 4),
                              Text(
                                'Customer scans this to earn cashback',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          null => Column(
                            children: [
                              Icon(
                                Icons.qr_code_2,
                                size: 64,
                                color: Theme.of(context).disabledColor,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Cashback QR pending -- available once this '
                                'order syncs',
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        },
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
                    onPressed: () => _print(context, ref, receipt),
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

  Future<void> _print(
    BuildContext context,
    WidgetRef ref,
    Receipt receipt,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(receiptPrinterProvider).printReceipt(receipt);
    } on ReceiptPrintException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
