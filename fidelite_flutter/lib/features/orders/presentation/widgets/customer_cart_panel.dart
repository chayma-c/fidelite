import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../shop/data/shop_status_providers.dart';
import '../../../wallet/data/wallet_providers.dart';
import '../../data/online_order_public_settings_providers.dart';
import '../controllers/cart_controller.dart';
import '../controllers/online_order_submission_controller.dart';
import 'item_customization_sheet.dart';

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

  Future<void> _editLine(
    BuildContext context,
    WidgetRef ref,
    CartLine line,
  ) async {
    final result = await showItemCustomizationSheet(
      context,
      menuItem: line.menuItem,
      initial: line,
    );
    if (result == null) return;

    ref
        .read(cartControllerProvider.notifier)
        .replaceLine(
          line,
          CartLine(
            menuItem: line.menuItem,
            quantity: line.quantity,
            removedIngredients: result.removedIngredients,
            addedSauces: result.addedSauces,
            specialRequest: result.specialRequest,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartControllerProvider);
    final submission = ref.watch(onlineOrderSubmissionControllerProvider);
    final isSubmitting = submission is OnlineOrderSubmissionInProgress;
    final isShopOpen =
        ref.watch(shopStatusProvider).valueOrNull == ShopOpenStatus.open;
    final balance = ref.watch(balanceProvider).valueOrNull ?? 0;
    // Fails open while loading/on error -- same reasoning as isShopOpen
    // not existing here at all for that case: the submit button itself
    // (gated on isShopOpen, checked server-side regardless) is the real
    // backstop, not this.
    final deliveryAvailable =
        ref.watch(deliveryAvailableProvider).valueOrNull ?? true;

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
        (!isDelivery || (deliveryAvailable && hasDeliveryDetails)) &&
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
                      InkWell(
                        onTap: line.menuItem.isCustomizable
                            ? () => _editLine(context, ref, line)
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(line.menuItem.name),
                                    if (line.isCustomized)
                                      Text(
                                        describeCartLineCustomization(line),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    Text(
                                      line.lineTotalMillimes.asDinars,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              _QuantityStepper(
                                quantity: line.quantity,
                                onDecrement: () => ref
                                    .read(cartControllerProvider.notifier)
                                    .setLineQuantity(line, line.quantity - 1),
                                onIncrement: () => ref
                                    .read(cartControllerProvider.notifier)
                                    .setLineQuantity(line, line.quantity + 1),
                              ),
                            ],
                          ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SegmentedButton<OrderFulfillmentMethod>(
                        segments: [
                          const ButtonSegment(
                            value: OrderFulfillmentMethod.pickup,
                            label: Text('Pickup'),
                            icon: Icon(Icons.storefront_outlined),
                          ),
                          ButtonSegment(
                            value: OrderFulfillmentMethod.delivery,
                            label: Text(
                              'Delivery (+${_deliveryFeeMillimes.asDinars})',
                            ),
                            icon: const Icon(
                              Icons.delivery_dining_outlined,
                            ),
                            // Disabled rather than hidden -- a customer who
                            // expects delivery to exist should see that it
                            // does, just not right now, rather than wonder
                            // whether the app dropped the option entirely.
                            enabled: deliveryAvailable,
                          ),
                        ],
                        selected: {_fulfillment},
                        onSelectionChanged: (selection) =>
                            setState(() => _fulfillment = selection.first),
                      ),
                    ),
                    if (!deliveryAvailable)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                        child: Text(
                          'Delivery is not available right now.',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                        ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SegmentedButton<OrderPaymentMethod>(
                            segments: [
                              const ButtonSegment(
                                value: OrderPaymentMethod.cashOnSite,
                                label: Text('Cash'),
                                icon: Icon(Icons.payments_outlined),
                              ),
                              ButtonSegment(
                                value: OrderPaymentMethod.points,
                                label: const Text('Points'),
                                icon: const Icon(
                                  Icons.card_giftcard_outlined,
                                ),
                                // Disabled rather than silently
                                // allowed-then-rejected -- the balance is
                                // already known client-side, so there's no
                                // reason to let the customer pick an option
                                // that can only fail at submit time.
                                enabled: canPayWithPoints,
                              ),
                            ],
                            selected: {_payment},
                            onSelectionChanged: (selection) =>
                                setState(() => _payment = selection.first),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              canPayWithPoints
                                  ? 'Points balance: ${balance.asDinars}'
                                  : 'Not enough points (balance: ${balance.asDinars})',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: canPayWithPoints
                                        ? null
                                        : Theme.of(context).colorScheme.error,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
        // Elevated rather than a plain Divider so the total+CTA reads as a
        // pinned bar distinct from the scrolling content above it -- it was
        // already outside the Expanded ListView (so already "sticky"), this
        // just makes that visually obvious.
        Material(
          elevation: 3,
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          child: Padding(
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
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: canSubmit
                      ? () => ref
                            .read(
                              onlineOrderSubmissionControllerProvider.notifier,
                            )
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
        ),
      ],
    );
  }
}

/// A compact -/qty/+ control replacing the previous pair of separately
/// placed icon buttons (decrease vs. delete) -- decrementing to zero still
/// removes the line, same as before, via CartController.setQuantity.
class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          tooltip: 'Decrease quantity',
          visualDensity: VisualDensity.compact,
          onPressed: onDecrement,
        ),
        SizedBox(
          width: 20,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          tooltip: 'Increase quantity',
          visualDensity: VisualDensity.compact,
          onPressed: onIncrement,
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
