import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'shop_status_util.dart';

/// Read-only and deliberately public -- a customer deciding whether to
/// walk over needs to see this the moment they open the app, logged in or
/// not. Writing the status is a separate, staff-only endpoint (see
/// ShopStatusManagementEndpoint), the same public-read/staff-write split
/// already used for the menu (MenuEndpoint vs MenuManagementEndpoint).
class ShopStatusEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<ShopStatusRecord> getStatus(Session session) {
    return currentShopStatusOrDefault(session);
  }
}
