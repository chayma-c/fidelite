import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'online_order_settings_util.dart';

/// Read-only and deliberately public -- same reasoning as ShopStatusEndpoint:
/// a customer deciding how to receive their order needs to see this before
/// (and while) building their cart. Projects just [deliveryEnabled] off the
/// staff-internal OnlineOrderSettingsRecord (see
/// OnlineOrderSettingsEndpoint for the staff-only read/write of the full
/// record) rather than exposing it directly.
class OnlineOrderPublicSettingsEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<OnlineOrderPublicSettings> getSettings(Session session) async {
    final settings = await currentOnlineOrderSettingsOrDefault(session);
    return OnlineOrderPublicSettings(
      deliveryEnabled: settings.deliveryEnabled,
    );
  }
}
