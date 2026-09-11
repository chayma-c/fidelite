import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'points_balance.dart';

class WalletEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:customer')};

  Future<int> getBalance(Session session) {
    final userId = UuidValue.fromString(session.authenticated!.userIdentifier);
    return currentPointsBalance(session, userId, null);
  }

  /// Most recent entries first, bank-statement style.
  Future<List<PointsLedgerEntryRecord>> getPointsHistory(
    Session session, {
    int limit = 50,
  }) {
    final userId = UuidValue.fromString(session.authenticated!.userIdentifier);
    return PointsLedgerEntryRecord.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: limit,
    );
  }
}
