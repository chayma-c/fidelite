import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'claim_token_util.dart';
import 'points_balance.dart';

/// The order's total is 8% cashback, confirmed by the owner (a 6.000 DT
/// order earns 0.480 DT). Rounded to the nearest millime.
const _cashbackRate = 0.08;

class PointsClaimEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:customer')};

  /// Redeems a scanned order-ticket QR for cashback. Single-use is
  /// enforced by the conditional [OrderClaimTokenRecord.db.updateWhere]
  /// below succeeding atomically for exactly one caller -- see
  /// order_claim_token.spy.yaml for why this is safe under concurrent
  /// scans of the same receipt.
  Future<ClaimResult> claimOrderPoints(
    Session session,
    int orderId,
    String token,
  ) async {
    final tokenHash = ClaimTokenUtil.hash(token);
    final callerId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );

    return DatabaseUtil.runInTransactionOrSavepoint(session.db, null, (
      transaction,
    ) async {
      final now = DateTime.now().toUtc();
      final updated = await OrderClaimTokenRecord.db.updateWhere(
        session,
        columnValues: (t) => [
          t.status(ClaimTokenStatus.claimed),
          t.claimedAt(now),
          t.claimedByUserId(callerId),
        ],
        where: (t) =>
            t.orderId.equals(orderId) &
            t.tokenHash.equals(tokenHash) &
            t.status.equals(ClaimTokenStatus.pending) &
            (t.expiresAt > now),
        transaction: transaction,
      );

      if (updated.isEmpty) {
        throw OrderClaimException(
          reason: await _reasonForFailedClaim(
            session,
            orderId,
            tokenHash,
            transaction,
          ),
        );
      }

      final order = await OrderRecord.db.findById(
        session,
        orderId,
        transaction: transaction,
      );
      if (order == null) {
        throw OrderClaimException(
          reason: OrderClaimExceptionReason.invalidToken,
        );
      }

      final pointsEarned = (order.totalMillimes * _cashbackRate).round();

      // Serializes every balance-affecting operation for this customer
      // (this claim, and any future redemption/adjustment) so two
      // concurrent writes can't both read the same starting balance.
      await lockPointsBalance(session, callerId, transaction);
      final currentBalance = await currentPointsBalance(
        session,
        callerId,
        transaction,
      );
      final newBalance = currentBalance + pointsEarned;

      await PointsLedgerEntryRecord.db.insertRow(
        session,
        PointsLedgerEntryRecord(
          userId: callerId,
          deltaMillimes: pointsEarned,
          reason: PointsLedgerReason.orderClaim,
          relatedOrderId: orderId,
          balanceAfterMillimes: newBalance,
          createdByUserId: callerId,
          createdAt: now,
        ),
        transaction: transaction,
      );

      return ClaimResult(
        pointsEarnedMillimes: pointsEarned,
        newBalanceMillimes: newBalance,
      );
    });
  }

  /// Best-effort, more specific error message -- the atomic update above
  /// already decided the claim failed; this just explains why.
  Future<OrderClaimExceptionReason> _reasonForFailedClaim(
    Session session,
    int orderId,
    String tokenHash,
    Transaction transaction,
  ) async {
    final existing = await OrderClaimTokenRecord.db.find(
      session,
      where: (t) => t.orderId.equals(orderId) & t.tokenHash.equals(tokenHash),
      transaction: transaction,
    );
    if (existing.isEmpty) return OrderClaimExceptionReason.invalidToken;
    if (existing.first.status == ClaimTokenStatus.claimed) {
      return OrderClaimExceptionReason.alreadyClaimed;
    }
    return OrderClaimExceptionReason.expired;
  }
}
