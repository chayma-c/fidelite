import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'shop_status_util.dart';

/// Staff-only. No locking needed for a single-row toggle like this --
/// two staff changing it at the same moment is harmless, whichever write
/// lands last is simply what the sign shows, which is the correct
/// behavior here (unlike e.g. a balance, there's no invariant to protect).
class ShopStatusManagementEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:staff')};

  Future<ShopStatusRecord> setStatus(Session session, ShopOpenStatus status) async {
    final current = await currentShopStatusOrDefault(session);
    return ShopStatusRecord.db.updateRow(
      session,
      current.copyWith(status: status, updatedAt: DateTime.now().toUtc()),
    );
  }
}
