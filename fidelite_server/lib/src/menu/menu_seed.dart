import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Inserts the starting A&A menu if the table is empty -- a one-time
/// bootstrap for a fresh database only. Safe to call on every server
/// startup, since it's a no-op once real data exists; day-to-day menu
/// changes go through MenuManagementEndpoint (staff-only, in the app) from
/// here on, not this file. Category labels here are placeholders for the
/// two unnamed menu-board columns ("Frites" / "Chawarma & Escalope")
/// pending confirmation from the owner; trivial to relabel later since
/// [MenuItemRecord.category] is just text.
Future<void> ensureMenuSeeded(Session session) async {
  final existingCount = await MenuItemRecord.db.count(session);
  if (existingCount > 0) return;

  var sortOrder = 0;
  final items = <MenuItemRecord>[];

  void add(
    String category,
    String name,
    int priceMillimes, {
    bool isCustomizable = false,
  }) {
    items.add(
      MenuItemRecord(
        name: name,
        category: category,
        priceMillimes: priceMillimes,
        isCustomizable: isCustomizable,
        sortOrder: sortOrder++,
      ),
    );
  }

  // Sandwich/malfouf/chapati items get the "leave out a base ingredient /
  // add a sauce / special request" customization flow (see
  // MenuItemRecord.isCustomizable) -- plates and suppléments don't.
  const frites = 'Frites';
  add(frites, 'Omelette + frites', 3000, isCustomizable: true);
  add(frites, 'Salami + frites', 3500, isCustomizable: true);
  add(frites, 'Fromage + frites', 3500, isCustomizable: true);
  add(frites, 'Jambon + frites', 3700, isCustomizable: true);
  add(frites, 'Thon + frites', 4000, isCustomizable: true);
  add(frites, 'Mozzarella + frites', 4000, isCustomizable: true);

  const chawarmaEscalope = 'Chawarma & Escalope';
  add(
    chawarmaEscalope,
    'Chawarma (frites + mozz)',
    6000,
    isCustomizable: true,
  );
  add(
    chawarmaEscalope,
    'Escalope (frites + mozz)',
    6500,
    isCustomizable: true,
  );
  add(
    chawarmaEscalope,
    'Special Chawarma (omelette + mozz + slice + frites)',
    7000,
    isCustomizable: true,
  );
  add(
    chawarmaEscalope,
    'Malfouf A&A (escalope + omelette + slice + mozz + frites)',
    8000,
    isCustomizable: true,
  );

  const chapati = 'Chapati';
  add(chapati, 'Salami + omelette', 2800, isCustomizable: true);
  add(chapati, 'Fromage + omelette', 2800, isCustomizable: true);
  add(chapati, 'Jambon + omelette', 3000, isCustomizable: true);
  add(chapati, 'Thon + omelette', 3500, isCustomizable: true);
  add(
    chapati,
    'Special (jambon, thon, omelette, slice)',
    4500,
    isCustomizable: true,
  );
  add(
    chapati,
    'Chapati A&A (jambon, thon, omelette, slice, mozz)',
    5000,
    isCustomizable: true,
  );

  const sandwich = 'Sandwich';
  add(sandwich, '1/2 baguette kafteji', 3000, isCustomizable: true);
  add(sandwich, '3/4 baguette kafteji', 3500, isCustomizable: true);
  add(sandwich, 'Thon', 4500, isCustomizable: true);
  add(sandwich, 'Escalope', 6500, isCustomizable: true);

  const plats = 'Plats';
  add(plats, 'Kafteji', 5000);
  add(plats, 'Escalope', 10000);
  add(plats, '1/4 Djej', 10000);

  const supplements = 'Suppléments';
  add(supplements, 'Frites', 1500);
  add(supplements, 'Omelette', 600);
  add(supplements, 'Slice', 600);
  add(supplements, 'Pâté', 1000);
  add(supplements, 'Jambon/Salami', 1000);
  add(supplements, 'Mozzarella (arabie)', 2000);

  await MenuItemRecord.db.insert(session, items);
  session.log('Seeded ${items.length} menu items.');
}
