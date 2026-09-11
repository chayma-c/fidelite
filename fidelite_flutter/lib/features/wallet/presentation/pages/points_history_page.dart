import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../data/wallet_providers.dart';

class PointsHistoryPage extends ConsumerWidget {
  const PointsHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(pointsHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Points history')),
      body: historyAsync.when(
        data: (entries) => entries.isEmpty
            ? const Center(child: Text('No activity yet.'))
            : ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  final isEarn = entry.deltaMillimes >= 0;
                  return ListTile(
                    leading: Icon(
                      isEarn
                          ? Icons.add_circle_outline
                          : Icons.remove_circle_outline,
                      color: isEarn ? Colors.green : Colors.red,
                    ),
                    title: Text(isEarn ? 'Earned' : 'Spent'),
                    subtitle: Text(_formatDate(entry.createdAt)),
                    trailing: Text(
                      entry.deltaMillimes.asDinars,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Could not load history:\n$error')),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final local = dateTime.toLocal();
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${local.year}-${twoDigits(local.month)}-${twoDigits(local.day)} '
        '${twoDigits(local.hour)}:${twoDigits(local.minute)}';
  }
}
