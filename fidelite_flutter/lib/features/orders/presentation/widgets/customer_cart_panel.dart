import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../shop/data/shop_status_providers.dart';
import '../controllers/cart_controller.dart';
import '../controllers/online_order_submission_controller.dart';

/// The customer-facing equivalent of CartPanel -- same look, but wired to
/// OnlineOrderSubmissionController instead of the staff OrderSubmission
/// one, and without a "confirm & print" label since there's no ticket to
/// print on the customer's own device.
///
/// Watches shop status directly (rather than taking it as a parameter) so
/// a shop closing *while the customer is mid-browse* disables the submit
/// button immediately, not just at entry -- the server enforces this too
/// (InvalidOrderExceptionReason.shopNotOpen), but catching it here avoids
/// a pointless round trip for what's already visible on screen.
class CustomerCartPanel extends ConsumerWidget {
  const CustomerCartPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartControllerProvider);
    final submission = ref.watch(onlineOrderSubmissionControllerProvider);
    final isSubmitting = submission is OnlineOrderSubmissionInProgress;
    final isShopOpen =
        ref.watch(shopStatusProvider).valueOrNull == ShopOpenStatus.open;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Your order',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: cart.isEmpty
              ? const Center(
                  child: Text('No items yet — tap the menu to add.'),
                )
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
                        .fold<int>(
                          0,
                          (sum, line) => sum + line.lineTotalMillimes,
                        )
                        .asDinars,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: (cart.isEmpty || isSubmitting || !isShopOpen)
                    ? null
                    : () => ref
                        .read(onlineOrderSubmissionControllerProvider.notifier)
                        .submit(),
                child: isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(isShopOpen ? 'Place order' : 'Shop is closed'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
