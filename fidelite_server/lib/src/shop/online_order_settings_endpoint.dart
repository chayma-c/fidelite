import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'online_order_settings_util.dart';

/// Staff-internal only -- unlike ShopStatusEndpoint, nothing here is ever
/// customer-visible.
class OnlineOrderSettingsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:staff')};

  Future<OnlineOrderSettingsRecord> getSettings(Session session) {
    return currentOnlineOrderSettingsOrDefault(session);
  }

  Future<OnlineOrderSettingsRecord> setAutoPrint(
    Session session,
    bool enabled,
  ) async {
    final current = await currentOnlineOrderSettingsOrDefault(session);
    return OnlineOrderSettingsRecord.db.updateRow(
      session,
      current.copyWith(
        autoPrintEnabled: enabled,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
