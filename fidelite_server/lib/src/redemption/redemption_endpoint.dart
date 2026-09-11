import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../points/claim_token_util.dart';
import '../points/points_balance.dart';

class RedemptionEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:staff')};

  /// Redeems a reward against a customer's wallet QR. Unlike an order
  /// claim, "is this token valid" and "does the redemption succeed" are
  /// separate questions here -- a valid token can still fail on
  /// insufficient balance, and in that case the token must stay usable for
  /// a retry. That's why this locks the token row with `FOR UPDATE`
  /// (read-then-decide) instead of the conditional-UPDATE pattern
  /// PointsClaimEndpoint uses (where consumption itself *is* the success
  /// signal).
  Future<RedemptionResult> redeemReward(
    Session session,
    UuidValue walletUserId,
    String walletToken,
    int rewardItemId,
  ) async {
    final tokenHash = ClaimTokenUtil.hash(walletToken);
    final staffId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );

    return DatabaseUtil.runInTransactionOrSavepoint(session.db, null, (
      transaction,
    ) async {
      final now = DateTime.now().toUtc();

      final tokens = await WalletTokenRecord.db.find(
        session,
        where: (t) =>
            t.userId.equals(walletUserId) &
            t.tokenHash.equals(tokenHash) &
            t.consumedAt.equals(null) &
            (t.expiresAt > now),
        lockMode: LockMode.forUpdate,
        transaction: transaction,
      );
      if (tokens.isEmpty) {
        throw RedemptionException(
          reason: RedemptionExceptionReason.tokenInvalidOrExpired,
        );
      }
      final token = tokens.first;

      final reward = await RewardItemRecord.db.findById(
        session,
        rewardItemId,
        transaction: transaction,
      );
      if (reward == null || !reward.isActive) {
        throw RedemptionException(
          reason: RedemptionExceptionReason.rewardUnavailable,
        );
      }

      // Serializes with any concurrent order claim/redemption for this
      // same customer -- see PointsClaimEndpoint for why this is needed
      // even though the wallet-token lock above already prevents the same
      // QR being redeemed twice.
      await lockPointsBalance(session, walletUserId, transaction);
      final currentBalance = await currentPointsBalance(
        session,
        walletUserId,
        transaction,
      );
      if (currentBalance < reward.pointsCost) {
        // Intentionally not consuming the token: this is a business
        // outcome, not a security failure, so the cashier can immediately
        // retry a cheaper reward against the same still-displayed QR.
        throw RedemptionException(
          reason: RedemptionExceptionReason.insufficientBalance,
        );
      }
      final newBalance = currentBalance - reward.pointsCost;

      final redemption = await RedemptionRecord.db.insertRow(
        session,
        RedemptionRecord(
          customerUserId: walletUserId,
          staffUserId: staffId,
          rewardItemId: reward.id!,
          rewardNameSnapshot: reward.name,
          pointsCostSnapshot: reward.pointsCost,
          createdAt: now,
        ),
        transaction: transaction,
      );

      await WalletTokenRecord.db.updateRow(
        session,
        token.copyWith(consumedAt: now, consumedByRedemptionId: redemption.id),
        transaction: transaction,
      );

      await PointsLedgerEntryRecord.db.insertRow(
        session,
        PointsLedgerEntryRecord(
          userId: walletUserId,
          deltaMillimes: -reward.pointsCost,
          reason: PointsLedgerReason.redemption,
          relatedRedemptionId: redemption.id,
          balanceAfterMillimes: newBalance,
          createdByUserId: staffId,
          createdAt: now,
        ),
        transaction: transaction,
      );

      return RedemptionResult(
        redemption: redemption,
        customerNewBalanceMillimes: newBalance,
      );
    });
  }
}
