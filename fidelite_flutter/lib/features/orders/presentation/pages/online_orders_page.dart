import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../../core/printing/rawbt_receipt_printer.dart';
import '../../data/online_order_providers.dart';
import '../controllers/online_order_printing_controller.dart';

/// Staff-only: online orders still waiting to be printed/handled. Reached
/// from OrderBuilderPage's notification bell, not a quick-access button --
/// the queue itself (not this screen) is what drives the badge count.
class OnlineOrdersPage extends ConsumerWidget {
  const OnlineOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(onlineOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Online orders')),
      body: ordersAsync.when(
        data: (orders) => orders.isEmpty
            ? const Center(child: Text('No online orders waiting.'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) =>
                    _OnlineOrderTile(order: orders[index]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            'Could not load online orders:\n$error',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _OnlineOrderTile extends ConsumerStatefulWidget {
  const _OnlineOrderTile({required this.order});

  final OrderRecord order;

  @override
  ConsumerState<_OnlineOrderTile> createState() => _OnlineOrderTileState();
}

class _OnlineOrderTileState extends ConsumerState<_OnlineOrderTile> {
  bool _isPrinting = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.shopping_bag_outlined),
        title: Text('Ticket #${order.ticketNumber} -- ${order.totalMillimes.asDinars}'),
        subtitle: Text(_timeAgo(order.createdAt)),
        trailing: _isPrinting
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : IconButton(
                icon: const Icon(Icons.print),
                tooltip: 'Print ticket',
                onPressed: _print,
              ),
      ),
    );
  }

  Future<void> _print() async {
    setState(() => _isPrinting = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(onlineOrderPrintingControllerProvider)
          .printAndMarkHandled(widget.order);
    } on ReceiptPrintException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isPrinting = false);
    }
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().toUtc().difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }
}
