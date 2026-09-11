import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Inserts the starting A&A menu if the table is empty. Safe to call on
/// every server startup -- it's a no-op once real data exists. Category
/// labels here are placeholders for the two unnamed menu-board columns
/// ("Frites" / "Chawarma & Escalope") pending confirmation from the owner;
/// trivial to relabel later since [MenuItemRecord.category] is just text.
Future<void> ensureMenuSeeded(Session session) async {
  final existingCount = await MenuItemRecord.db.count(session);
  if (existingCount > 0) return;

  var sortOrder = 0;
  final items = <MenuItemRecord>[];

  void add(String category, String name, int priceMillimes) {
    items.add(
      MenuItemRecord(
        name: name,
        category: category,
        priceMillimes: priceMillimes,
        sortOrder: sortOrder++,
      ),
    );
  }

  const frites = 'Frites';
  add(frites, 'Omelette + frites', 3000);
  add(frites, 'Salami + frites', 3500);
  add(frites, 'Fromage + frites', 3500);
  add(frites, 'Jambon + frites', 3700);
  add(frites, 'Thon + frites', 4000);
  add(frites, 'Mozzarella + frites', 4000);

  const chawarmaEscalope = 'Chawarma & Escalope';
  add(chawarmaEscalope, 'Chawarma (frites + mozz)', 6000);
  add(chawarmaEscalope, 'Escalope (frites + mozz)', 6500);
  add(
    chawarmaEscalope,
    'Special Chawarma (omelette + mozz + slice + frites)',
    7000,
  );
  add(
    chawarmaEscalope,
    'Malfouf A&A (escalope + omelette + slice + mozz + frites)',
    8000,
  );

  const chapati = 'Chapati';
  add(chapati, 'Salami + omelette', 2800);
  add(chapati, 'Fromage + omelette', 2800);
  add(chapati, 'Jambon + omelette', 3000);
  add(chapati, 'Thon + omelette', 3500);
  add(chapati, 'Special (jambon, thon, omelette, slice)', 4500);
  add(chapati, 'Chapati A&A (jambon, thon, omelette, slice, mozz)', 5000);

  const sandwich = 'Sandwich';
  add(sandwich, '1/2 baguette kafteji', 3000);
  add(sandwich, '3/4 baguette kafteji', 3500);
  add(sandwich, 'Thon', 4500);
  add(sandwich, 'Escalope', 6500);

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
