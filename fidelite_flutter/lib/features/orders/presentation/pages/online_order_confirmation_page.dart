import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../controllers/cart_controller.dart';

/// Shown right after OnlineOrderSubmissionController places an order --
/// unlike the staff OrderConfirmationPage there's no QR to scan: cashback
/// is already credited server-side the moment the order was placed, since
/// the orderer is already a known, authenticated account.
class OnlineOrderConfirmationPage extends StatelessWidget {
  const OnlineOrderConfirmationPage({
    super.key,
    required this.confirmation,
    required this.lines,
  });

  final OnlineOrderConfirmation confirmation;
  final List<CartLine> lines;

  @override
  Widget build(BuildContext context) {
    final order = confirmation.order;

    return Scaffold(
      appBar: AppBar(title: const Text('Order placed')),
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
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Ticket #${order.ticketNumber}',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Show this number at the counter when it\'s ready.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      for (final line in lines)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${line.quantity}x ${line.menuItem.name}',
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
                            'Total',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            order.totalMillimes.asDinars,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '+${confirmation.pointsEarnedMillimes.asDinars} '
                              'cashback earned',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'New balance: '
                              '${confirmation.newBalanceMillimes.asDinars}',
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
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
