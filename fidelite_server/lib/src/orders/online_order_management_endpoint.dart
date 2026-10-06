import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Staff-only view of online orders that still need attention -- what
/// backs both the Online Orders queue and the staff notification badge
/// count (its length).
class OnlineOrderManagementEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:staff')};

  /// Oldest first -- staff should work through them in the order
  /// customers actually placed them. `handledAt` alone is enough to scope
  /// this to online orders: a counter order is marked handled the instant
  /// it's created (see OrderEndpoint.submitOrder) since staff creating it
  /// in person *is* handling it, so it never shows up here.
  Future<List<OrderRecord>> listUnhandled(Session session) {
    return OrderRecord.db.find(
      session,
      where: (t) => t.handledAt.equals(null),
      orderBy: (t) => t.createdAt,
    );
  }

  /// Also returns the order's line items, since the Online Orders screen
  /// needs them to build a printable ticket.
  Future<List<OrderItemRecord>> getItemsForOrder(
    Session session,
    int orderId,
  ) {
    return OrderItemRecord.db.find(
      session,
      where: (t) => t.orderId.equals(orderId),
    );
  }

  Future<OrderRecord> markHandled(Session session, int orderId) async {
    final order = await OrderRecord.db.findById(session, orderId);
    if (order == null) {
      throw StateError('Order $orderId not found.');
    }
    return OrderRecord.db.updateRow(
      session,
      order.copyWith(handledAt: DateTime.now().toUtc()),
    );
  }
}
