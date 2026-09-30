import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../data/order_history_providers.dart';
import '../../data/pending_order.dart';
import '../controllers/pending_order_queue_controller.dart';

/// Staff-only: the restaurant's sales for a given day -- total revenue,
/// order count, and the individual orders. Defaults to today; prev/next
/// arrows browse other days (can't go past today).
class SalesHistoryPage extends ConsumerStatefulWidget {
  const SalesHistoryPage({super.key});

  @override
  ConsumerState<SalesHistoryPage> createState() => _SalesHistoryPageState();
}

class _SalesHistoryPageState extends ConsumerState<SalesHistoryPage> {
  late DateTime _selectedDay = _today();

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  bool get _isToday => _isSameDay(_selectedDay, _today());

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(ordersForDayProvider(_selectedDay));
    // Orders still sitting in the local queue (placed offline, not yet
    // synced) only ever belong to *today* -- see PendingOrder.createdAt,
    // always "now" at the moment of queueing. Merging them in here is what
    // makes today's total calculable entirely from on-device data: it
    // never has to wait on -- or fail because of -- a server round trip.
    final queuedToday = _isToday
        ? ref.watch(pendingOrderQueueControllerProvider.select((s) => s.queued))
        : const <PendingOrder>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Sales history')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  tooltip: 'Previous day',
                  onPressed: () => setState(
                    () => _selectedDay = _selectedDay.subtract(
                      const Duration(days: 1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: Text(
                    _label(_selectedDay),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  tooltip: 'Next day',
                  onPressed: _isToday
                      ? null
                      : () => setState(
                          () => _selectedDay = _selectedDay.add(
                            const Duration(days: 1),
                          ),
                        ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ordersAsync.when(
              data: (orders) => _DayView(orders: orders, queued: queuedToday),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text(
                  'Could not load sales for this day:\n$error',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _label(DateTime day) {
    final today = _today();
    if (_isSameDay(day, today)) return 'Today';
    if (_isSameDay(day, today.subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    }
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(day.day)}/${two(day.month)}/${day.year}';
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

/// One row in the day's list -- either a server-confirmed [OrderRecord] or
/// a still-queued [PendingOrder], normalized to a common shape so the two
/// can be sorted and displayed together instead of as two disconnected
/// lists.
class _HistoryEntry {
  const _HistoryEntry({
    required this.ticketNumber,
    required this.createdAt,
    required this.totalMillimes,
    required this.isSynced,
  });

  factory _HistoryEntry.fromOrder(OrderRecord order) => _HistoryEntry(
    ticketNumber: order.ticketNumber,
    createdAt: order.createdAt,
    totalMillimes: order.totalMillimes,
    isSynced: true,
  );

  factory _HistoryEntry.fromQueued(PendingOrder order) => _HistoryEntry(
    ticketNumber: order.ticketNumber,
    createdAt: order.createdAt,
    totalMillimes: order.estimatedTotalMillimes,
    isSynced: false,
  );

  final int ticketNumber;
  final DateTime createdAt;
  final int totalMillimes;
  final bool isSynced;
}

class _DayView extends StatelessWidget {
  const _DayView({required this.orders, required this.queued});

  final List<OrderRecord> orders;
  final List<PendingOrder> queued;

  @override
  Widget build(BuildContext context) {
    final entries =
        [
          for (final order in orders) _HistoryEntry.fromOrder(order),
          for (final order in queued) _HistoryEntry.fromQueued(order),
        ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final totalMillimes = entries.fold<int>(
      0,
      (sum, entry) => sum + entry.totalMillimes,
    );

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Stat(label: 'Total sales', value: totalMillimes.asDinars),
                _Stat(label: 'Orders', value: '${entries.length}'),
              ],
            ),
          ),
        ),
        Expanded(
          child: entries.isEmpty
              ? const Center(child: Text('No orders on this day.'))
              : ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return ListTile(
                      leading: Icon(
                        entry.isSynced ? Icons.receipt_long : Icons.cloud_off,
                      ),
                      title: Text('Ticket #${entry.ticketNumber}'),
                      subtitle: Text(
                        entry.isSynced
                            ? _formatTime(entry.createdAt)
                            : 'Not yet synced',
                      ),
                      trailing: Text(
                        entry.isSynced
                            ? entry.totalMillimes.asDinars
                            : '${entry.totalMillimes.asDinars} (est.)',
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dt) {
    final local = dt.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(local.hour)}:${two(local.minute)}';
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
