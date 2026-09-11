import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class RewardsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Any authenticated user: customers browse what they could redeem,
  /// staff need the same list mid-redemption.
  Future<List<RewardItemRecord>> getCatalog(Session session) {
    return RewardItemRecord.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderBy: (t) => t.sortOrder,
    );
  }
}
