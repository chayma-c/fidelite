import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// One validated, priced line -- a snapshot of the menu item at submit
/// time, before the order itself (and therefore its id) exists. The
/// caller fills in `orderId` when building the real [OrderItemRecord]s
/// after inserting the order.
class ValidatedOrderItem {
  const ValidatedOrderItem({
    required this.menuItemId,
    required this.menuItemNameSnapshot,
    required this.unitPriceMillimesSnapshot,
    required this.quantity,
  });

  final int menuItemId;
  final String menuItemNameSnapshot;
  final int unitPriceMillimesSnapshot;
  final int quantity;

  int get lineTotalMillimes => unitPriceMillimesSnapshot * quantity;
}

class PricedOrder {
  const PricedOrder({required this.items, required this.totalMillimes});

  final List<ValidatedOrderItem> items;
  final int totalMillimes;
}

/// Validates [items] against the *current* menu and prices them -- never
/// trusting a client-supplied price. Shared by the staff (OrderEndpoint)
/// and customer (OnlineOrderEndpoint) submission paths so this logic (and
/// the bugs that come with it) only exists once.
Future<PricedOrder> validateAndPriceOrder(
  Session session,
  List<OrderItemInput> items,
) async {
  if (items.isEmpty) {
    throw InvalidOrderException(
      reason: InvalidOrderExceptionReason.emptyCart,
    );
  }
  if (items.any((item) => item.quantity < 1)) {
    throw InvalidOrderException(
      reason: InvalidOrderExceptionReason.invalidQuantity,
    );
  }

  final menuItemIds = items.map((item) => item.menuItemId).toSet();
  final menuItems = await MenuItemRecord.db.find(
    session,
    where: (t) => t.id.inSet(menuItemIds) & t.isActive.equals(true),
  );
  final menuItemsById = {
    for (final menuItem in menuItems) menuItem.id!: menuItem,
  };

  for (final item in items) {
    if (!menuItemsById.containsKey(item.menuItemId)) {
      throw InvalidOrderException(
        reason: InvalidOrderExceptionReason.menuItemUnavailable,
        menuItemId: item.menuItemId,
      );
    }
  }

  final validated = items.map((item) {
    final menuItem = menuItemsById[item.menuItemId]!;
    return ValidatedOrderItem(
      menuItemId: menuItem.id!,
      menuItemNameSnapshot: menuItem.name,
      unitPriceMillimesSnapshot: menuItem.priceMillimes,
      quantity: item.quantity,
    );
  }).toList();

  final totalMillimes = validated.fold<int>(
    0,
    (sum, item) => sum + item.lineTotalMillimes,
  );

  return PricedOrder(items: validated, totalMillimes: totalMillimes);
}

/// Builds the real [OrderItemRecord] rows once the order (and therefore
/// its id) exists.
List<OrderItemRecord> buildOrderItemRecords(int orderId, PricedOrder priced) {
  return priced.items
      .map(
        (item) => OrderItemRecord(
          orderId: orderId,
          menuItemId: item.menuItemId,
          menuItemNameSnapshot: item.menuItemNameSnapshot,
          unitPriceMillimesSnapshot: item.unitPriceMillimesSnapshot,
          quantity: item.quantity,
          lineTotalMillimes: item.lineTotalMillimes,
        ),
      )
      .toList();
}
