import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../shop/data/shop_status_providers.dart';
import '../../../wallet/data/wallet_providers.dart';
import '../controllers/cart_controller.dart';
import '../controllers/online_order_submission_controller.dart';

/// Mirrors OnlineOrderEndpoint's `flatDeliveryFeeMillimes` for display only
/// -- the server is the one that actually computes and charges the real
/// total, this just lets the total update live as the customer toggles
/// fulfillment method, same way cart line prices are shown from the
/// locally cached menu before the server re-validates them at submit time.
const _deliveryFeeMillimes = 2000;

/// The customer-facing equivalent of CartPanel -- same cart list, but also
/// collects the two choices an online order needs that a counter order
/// never did (a staff member standing right there made both moot): how to
/// receive it, and how to pay for it. Wired to
/// OnlineOrderSubmissionController instead of the staff OrderSubmission
/// one.
///
/// Watches shop status directly (rather than taking it as a parameter) so
/// a shop closing *while the customer is mid-browse* disables the submit
/// button immediately, not just at entry -- the server enforces this too
/// (InvalidOrderExceptionReason.shopNotOpen), but catching it here avoids
/// a pointless round trip for what's already visible on screen.
class CustomerCartPanel extends ConsumerStatefulWidget {
  const CustomerCartPanel({super.key});

  @override
  ConsumerState<CustomerCartPanel> createState() => _CustomerCartPanelState();
}

class _CustomerCartPanelState extends ConsumerState<CustomerCartPanel> {
  OrderFulfillmentMethod _fulfillment = OrderFulfillmentMethod.pickup;
  OrderPaymentMethod _payment = OrderPaymentMethod.cashOnSite;
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartControllerProvider);
    final submission = ref.watch(onlineOrderSubmissionControllerProvider);
    final isSubmitting = submission is OnlineOrderSubmissionInProgress;
    final isShopOpen =
        ref.watch(shopStatusProvider).valueOrNull == ShopOpenStatus.open;
    final balance = ref.watch(balanceProvider).valueOrNull ?? 0;

    final subtotal = cart.fold<int>(
      0,
      (sum, line) => sum + line.lineTotalMillimes,
    );
    final isDelivery = _fulfillment == OrderFulfillmentMethod.delivery;
    final deliveryFee = isDelivery ? _deliveryFeeMillimes : 0;
    final total = subtotal + deliveryFee;

    final hasDeliveryDetails =
        _addressController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty;
    final canPayWithPoints = balance >= total;

    final canSubmit =
        cart.isNotEmpty &&
        !isSubmitting &&
        isShopOpen &&
        (!isDelivery || hasDeliveryDetails) &&
        (_payment != OrderPaymentMethod.points || canPayWithPoints);

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
              : ListView(
                  children: [
                    for (final line in cart)
                      ListTile(
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
                      ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                      child: Text(
                        'How do you want it?',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    RadioListTile<OrderFulfillmentMethod>(
                      dense: true,
                      title: const Text('Pickup at the counter'),
                      value: OrderFulfillmentMethod.pickup,
                      groupValue: _fulfillment,
                      onChanged: (value) =>
                          setState(() => _fulfillment = value!),
                    ),
                    RadioListTile<OrderFulfillmentMethod>(
                      dense: true,
                      title: const Text('Delivery (+2.000 DT)'),
                      value: OrderFulfillmentMethod.delivery,
                      groupValue: _fulfillment,
                      onChanged: (value) =>
                          setState(() => _fulfillment = value!),
                    ),
                    if (isDelivery)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                        child: Column(
                          children: [
                            TextField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                labelText: 'Delivery address',
                                isDense: true,
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone number',
                                isDense: true,
                              ),
                              keyboardType: TextInputType.phone,
                              onChanged: (_) => setState(() {}),
                            ),
                          ],
                        ),
                      ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                      child: Text(
                        'How do you want to pay?',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    RadioListTile<OrderPaymentMethod>(
                      dense: true,
                      title: const Text('Cash on pickup/delivery'),
                      value: OrderPaymentMethod.cashOnSite,
                      groupValue: _payment,
                      onChanged: (value) => setState(() => _payment = value!),
                    ),
                    RadioListTile<OrderPaymentMethod>(
                      dense: true,
                      title: const Text('Pay with Fidélité points'),
                      subtitle: Text(
                        canPayWithPoints
                            ? 'Balance: ${balance.asDinars}'
                            : 'Not enough points (balance: ${balance.asDinars})',
                      ),
                      value: OrderPaymentMethod.points,
                      groupValue: _payment,
                      // Disabled rather than silently allowed-then-rejected
                      // -- the balance is already known client-side, so
                      // there's no reason to let the customer pick an
                      // option that can only fail at submit time.
                      onChanged: canPayWithPoints
                          ? (value) => setState(() => _payment = value!)
                          : null,
                    ),
                  ],
                ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isDelivery) ...[
                _SummaryRow(label: 'Subtotal', valueMillimes: subtotal),
                _SummaryRow(
                  label: 'Delivery fee',
                  valueMillimes: deliveryFee,
                ),
                const SizedBox(height: 4),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    total.asDinars,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: canSubmit
                    ? () => ref
                          .read(onlineOrderSubmissionControllerProvider.notifier)
                          .submit(
                            fulfillmentMethod: _fulfillment,
                            paymentMethod: _payment,
                            deliveryAddress: isDelivery
                                ? _addressController.text.trim()
                                : null,
                            deliveryPhone: isDelivery
                                ? _phoneController.text.trim()
                                : null,
                          )
                    : null,
                child: isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(!isShopOpen ? 'Shop is closed' : 'Place order'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.valueMillimes});

  final String label;
  final int valueMillimes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(valueMillimes.asDinars)],
      ),
    );
  }
}
