import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Seeds the reward catalog as a mirror of the current menu (same names,
/// same DT cost) if the table is empty -- confirmed as the starting point
/// while the owner hasn't settled on a distinct reward list yet. Safe to
/// call on every server startup; a no-op once real data exists. Call after
/// [ensureMenuSeeded] so there's a menu to mirror.
Future<void> ensureRewardsSeeded(Session session) async {
  final existingCount = await RewardItemRecord.db.count(session);
  if (existingCount > 0) return;

  final menuItems = await MenuItemRecord.db.find(
    session,
    where: (t) => t.isActive.equals(true),
    orderByList: (t) => [Order(column: t.category), Order(column: t.sortOrder)],
  );

  final rewards = [
    for (var i = 0; i < menuItems.length; i++)
      RewardItemRecord(
        name: menuItems[i].name,
        pointsCost: menuItems[i].priceMillimes,
        sortOrder: i,
      ),
  ];

  await RewardItemRecord.db.insert(session, rewards);
  session.log('Seeded ${rewards.length} reward items (mirrored from menu).');
}
