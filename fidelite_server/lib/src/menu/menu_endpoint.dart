import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class MenuEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Active menu items, grouped for display by ordering on category then
  /// [MenuItemRecord.sortOrder].
  Future<List<MenuItemRecord>> getMenu(Session session) {
    return MenuItemRecord.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderByList: (t) => [
        Order(column: t.category),
        Order(column: t.sortOrder),
      ],
    );
  }
}
