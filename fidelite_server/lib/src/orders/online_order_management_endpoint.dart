import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../points/claim_token_util.dart';

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

  /// Mints the claim QR for an online order's printed ticket -- called
  /// right before printing (see the client's
  /// OnlineOrderPrintingController), not at order-placement time: printing
  /// is asynchronous, so there's no raw token to hand back yet when
  /// OnlineOrderEndpoint.placeOrder returns (see its own doc comment).
  ///
  /// Refuses an order paid with points -- no cashback is ever earned on
  /// one (see OrderPaymentMethod.points), so there's nothing to claim.
  /// This is the actual enforcement of that rule for online orders:
  /// PointsClaimEndpoint.claimOrderPoints computes its payout from the
  /// order total alone, with no awareness of how the order was paid for,
  /// so the only thing standing between a points-paid order and a
  /// double-dip is simply never minting it a valid token in the first
  /// place.
  ///
  /// If a still-valid token already exists for this order (e.g. this is a
  /// reprint), it's expired before minting a fresh one -- otherwise two
  /// live tickets for the same order could each be scanned and double
  /// -credit cashback. The old row is kept (not deleted) for audit/
  /// history; only [ClaimTokenStatus.pending] ones are touched, so an
  /// already-claimed token's record is untouched either way.
  Future<String> issueClaimToken(Session session, int orderId) async {
    final order = await OrderRecord.db.findById(session, orderId);
    if (order == null) {
      throw StateError('Order $orderId not found.');
    }
    if (order.customerUserId == null) {
      throw StateError(
        'Order $orderId is a counter order -- it already gets its claim '
        'token at submission time (see OrderEndpoint.submitOrder), not '
        'through this endpoint.',
      );
    }
    if (order.paymentMethod == OrderPaymentMethod.points) {
      throw StateError(
        'Order $orderId was paid with points -- no cashback is earned on '
        'it, so it has no claim token to issue.',
      );
    }

    return DatabaseUtil.runInTransactionOrSavepoint(session.db, null, (
      transaction,
    ) async {
      final now = DateTime.now().toUtc();

      await OrderClaimTokenRecord.db.updateWhere(
        session,
        columnValues: (t) => [t.expiresAt(now)],
        where: (t) =>
            t.orderId.equals(orderId) &
            t.status.equals(ClaimTokenStatus.pending),
        transaction: transaction,
      );

      final rawToken = ClaimTokenUtil.generateRawToken();
      await OrderClaimTokenRecord.db.insertRow(
        session,
        OrderClaimTokenRecord(
          orderId: orderId,
          tokenHash: ClaimTokenUtil.hash(rawToken),
          expiresAt: now.add(ClaimTokenUtil.validity),
        ),
        transaction: transaction,
      );

      return 'FIDCLAIM1:$orderId:$rawToken';
    });
  }
}
