import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../controllers/cart_controller.dart';
import '../controllers/order_submission_controller.dart';

class CartPanel extends ConsumerWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartControllerProvider);
    final submission = ref.watch(orderSubmissionControllerProvider);
    final isSubmitting = submission is OrderSubmissionInProgress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text('Order', style: Theme.of(context).textTheme.titleLarge),
        ),
        Expanded(
          child: cart.isEmpty
              ? const Center(child: Text('No items yet — tap the menu to add.'))
              : ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final line = cart[index];
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(child: Text(line.menuItem.name)),
                          Text('x${line.quantity}'),
                        ],
                      ),
                      subtitle: Text(line.lineTotalMillimes.asDinars),
                      leading: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        tooltip: 'Decrease quantity',
                        onPressed: () => ref
                            .read(cartControllerProvider.notifier)
                            .setQuantity(
                              line.menuItem.id!,
                              line.quantity - 1,
                            ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        tooltip: 'Remove',
                        onPressed: () => ref
                            .read(cartControllerProvider.notifier)
                            .removeItem(line.menuItem.id!),
                      ),
                    );
                  },
                ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    cart
                        .fold<int>(0, (sum, line) => sum + line.lineTotalMillimes)
                        .asDinars,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: (cart.isEmpty || isSubmitting)
                    ? null
                    : () => ref
                        .read(orderSubmissionControllerProvider.notifier)
                        .submit(),
                child: isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Confirm & print'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
