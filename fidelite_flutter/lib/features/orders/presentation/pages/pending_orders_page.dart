import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../../core/printing/printing_providers.dart';
import '../../../../core/printing/rawbt_receipt_printer.dart';
import '../../../../core/printing/receipt.dart';
import '../../data/pending_order.dart';
import '../controllers/pending_order_queue_controller.dart';

/// Staff-only: orders that couldn't reach the server at submit time. Shows
/// two groups -- still waiting to sync, and synced-but-not-yet-printed
/// (which now has a real, working cashback QR, unlike the placeholder
/// ticket that may have been printed when the order was first queued).
class PendingOrdersPage extends ConsumerWidget {
  const PendingOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pendingOrderQueueControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending orders'),
        actions: [
          if (state.isSyncing)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.sync),
              tooltip: 'Retry now',
              onPressed: state.queued.isEmpty
                  ? null
                  : () => ref
                        .read(pendingOrderQueueControllerProvider.notifier)
                        .syncAll(),
            ),
        ],
      ),
      body: (state.queued.isEmpty && state.readyToPrint.isEmpty)
          ? const Center(child: Text('No pending orders.'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (state.readyToPrint.isNotEmpty) ...[
                  Text(
                    'Ready to print',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  for (final entry in state.readyToPrint)
                    _ReadyToPrintTile(entry: entry),
                  const SizedBox(height: 24),
                ],
                if (state.queued.isNotEmpty) ...[
                  Text(
                    'Waiting to sync',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  for (final order in state.queued) _QueuedOrderTile(order: order),
                ],
              ],
            ),
    );
  }
}

class _QueuedOrderTile extends StatelessWidget {
  const _QueuedOrderTile({required this.order});

  final PendingOrder order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.cloud_off),
        title: Text(
          'Ticket #${order.ticketNumber} -- ${order.lines.length} item(s) -- '
          '${order.estimatedTotalMillimes.asDinars} (estimated)',
        ),
        subtitle: Text('Queued ${_timeAgo(order.createdAt)}'),
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().toUtc().difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }
}

class _ReadyToPrintTile extends ConsumerWidget {
  const _ReadyToPrintTile({required this.entry});

  final SyncedPendingOrder entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = entry.confirmation.order;
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.check_circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Ticket #${order.ticketNumber} -- ${order.totalMillimes.asDinars}',
        ),
        subtitle: const Text('Synced -- ready to print'),
        trailing: IconButton(
          icon: const Icon(Icons.print),
          tooltip: 'Print ticket',
          onPressed: () => _print(context, ref),
        ),
      ),
    );
  }

  Future<void> _print(BuildContext context, WidgetRef ref) async {
    final order = entry.confirmation.order;
    final receipt = Receipt(
      orderId: order.id!,
      ticketNumber: order.ticketNumber,
      createdAt: order.createdAt,
      totalMillimes: order.totalMillimes,
      claimQrPayload: entry.confirmation.claimQrPayload,
      lines: [
        for (final line in entry.source.lines)
          ReceiptLine(
            category: line.category,
            name: line.name,
            quantity: line.quantity,
            lineTotalMillimes: line.lineTotalMillimes,
          ),
      ],
    );

    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(receiptPrinterProvider).printReceipt(receipt);
      ref
          .read(pendingOrderQueueControllerProvider.notifier)
          .dismissReadyToPrint(entry.source.localId);
    } on ReceiptPrintException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
