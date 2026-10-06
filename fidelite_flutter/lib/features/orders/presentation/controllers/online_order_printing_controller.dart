import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/printing/printing_providers.dart';
import '../../../../core/printing/receipt.dart';
import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/online_order_providers.dart';

/// What "handling" an online order actually means -- shared by the manual
/// Print button on OnlineOrdersPage and the auto-print listener on
/// OrderBuilderPage, so there's exactly one definition of it.
class OnlineOrderPrintingController {
  OnlineOrderPrintingController(this.ref);

  final Ref ref;

  /// Builds a ticket for [order], prints it, and only then marks it
  /// handled -- if printing throws (no printer configured, RawBT
  /// unreachable), the order deliberately stays in the queue so it can be
  /// retried instead of silently disappearing unprinted.
  ///
  /// No claim QR on this ticket: unlike a counter order, cashback for an
  /// online order was already credited the moment it was placed (see
  /// OnlineOrderEndpoint) -- there's nothing left to scan.
  Future<void> printAndMarkHandled(OrderRecord order) async {
    final client = ref.read(serverpodClientProvider);
    final items = await client.onlineOrderManagement.getItemsForOrder(
      order.id!,
    );

    // OrderItemRecord only snapshots name/price, not category (the same
    // is true for a counter order -- see order_confirmation_page.dart,
    // which gets it from the live menu item while building the cart,
    // before submission). Here the order already exists, so it's resolved
    // from the current menu instead. menuManagement (not menuProvider) is
    // used specifically because it includes deactivated items too -- a
    // since-deactivated item must still resolve correctly on an older order.
    final allMenuItems = await client.menuManagement.listAllMenuItems();
    final categoryByMenuItemId = {
      for (final menuItem in allMenuItems) menuItem.id!: menuItem.category,
    };

    final receipt = Receipt(
      orderId: order.id,
      ticketNumber: order.ticketNumber,
      createdAt: order.createdAt,
      totalMillimes: order.totalMillimes,
      lines: [
        for (final item in items)
          ReceiptLine(
            category: categoryByMenuItemId[item.menuItemId] ?? 'Item',
            name: item.menuItemNameSnapshot,
            quantity: item.quantity,
            lineTotalMillimes: item.lineTotalMillimes,
          ),
      ],
    );

    await ref.read(receiptPrinterProvider).printReceipt(receipt);
    await client.onlineOrderManagement.markHandled(order.id!);
    await ref.read(onlineOrdersProvider.notifier).refreshNow();
  }
}

final onlineOrderPrintingControllerProvider =
    Provider<OnlineOrderPrintingController>(
      (ref) => OnlineOrderPrintingController(ref),
    );
