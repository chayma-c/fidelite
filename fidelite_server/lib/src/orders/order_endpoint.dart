import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../points/claim_token_util.dart';

/// Order-claim tokens are valid for a week -- generous on purpose. Per the
/// design in OrderClaimTokenRecord, single-use (not short expiry) is what
/// actually prevents a receipt being claimed twice; this window just bounds
/// how long a stale unclaimed row sticks around.
const _claimTokenValidity = Duration(days: 7);

class OrderEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:staff')};

  /// Creates a confirmed order in one atomic call: validates the requested
  /// items, prices them from the *current* menu (never trusting a
  /// client-supplied price), inserts the order + its line items, and
  /// issues a single-use points-claim token whose QR goes on the printed
  /// receipt. The cart itself is client-local state up to this point --
  /// there is no separate "pending order" concept in the schema.
  Future<OrderConfirmation> submitOrder(
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

    final staffUserId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );

    return DatabaseUtil.runInTransactionOrSavepoint(session.db, null, (
      transaction,
    ) async {
      final totalMillimes = items.fold<int>(
        0,
        (sum, item) =>
            sum + menuItemsById[item.menuItemId]!.priceMillimes * item.quantity,
      );

      final order = await OrderRecord.db.insertRow(
        session,
        OrderRecord(
          staffUserId: staffUserId,
          subtotalMillimes: totalMillimes,
          totalMillimes: totalMillimes,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );

      final orderItems = items.map((item) {
        final menuItem = menuItemsById[item.menuItemId]!;
        return OrderItemRecord(
          orderId: order.id!,
          menuItemId: menuItem.id!,
          menuItemNameSnapshot: menuItem.name,
          unitPriceMillimesSnapshot: menuItem.priceMillimes,
          quantity: item.quantity,
          lineTotalMillimes: menuItem.priceMillimes * item.quantity,
        );
      }).toList();

      await OrderItemRecord.db.insert(
        session,
        orderItems,
        transaction: transaction,
      );

      final rawToken = ClaimTokenUtil.generateRawToken();
      await OrderClaimTokenRecord.db.insertRow(
        session,
        OrderClaimTokenRecord(
          orderId: order.id!,
          tokenHash: ClaimTokenUtil.hash(rawToken),
          expiresAt: DateTime.now().toUtc().add(_claimTokenValidity),
        ),
        transaction: transaction,
      );

      return OrderConfirmation(
        order: order,
        claimQrPayload: 'FIDCLAIM1:${order.id}:$rawToken',
      );
    });
  }

  /// Most recent orders first, for a staff reprint/lookup screen.
  Future<List<OrderRecord>> getOrderHistory(
    Session session, {
    int limit = 50,
  }) {
    return OrderRecord.db.find(
      session,
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
    );
  }
}
