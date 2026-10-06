import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// 8% cashback, confirmed by the owner (a 6.000 DT order earns 0.480 DT).
/// Shared by both ways a customer earns it -- scanning a counter order's
/// receipt QR (PointsClaimEndpoint) and placing an online order themselves
/// (OnlineOrderEndpoint) -- so the rate only ever lives in one place.
const cashbackRate = 0.08;

/// Serializes every balance-affecting operation for [userId] (an order
/// claim, and later a redemption/adjustment) so two concurrent writes for
/// the same customer can't both read the same starting balance and race
/// each other computing [PointsLedgerEntryRecord.balanceAfterMillimes].
/// Released automatically when [transaction] commits.
Future<void> lockPointsBalance(
  Session session,
  UuidValue userId,
  Transaction transaction,
) async {
  await session.db.unsafeQuery(
    'SELECT pg_advisory_xact_lock(hashtext(@userId)::bigint)',
    parameters: QueryParameters.named({'userId': userId.uuid}),
    transaction: transaction,
  );
}

/// The customer's current cashback balance, in millimes: the running total
/// is always the sum of every ledger entry, not a cached column, so this
/// is the source of truth (see points_ledger_entry.spy.yaml).
Future<int> currentPointsBalance(
  Session session,
  UuidValue userId,
  Transaction? transaction,
) async {
  final latest = await PointsLedgerEntryRecord.db.find(
    session,
    where: (t) => t.userId.equals(userId),
    orderBy: (t) => t.id,
    orderDescending: true,
    limit: 1,
    transaction: transaction,
  );
  return latest.firstOrNull?.balanceAfterMillimes ?? 0;
}
