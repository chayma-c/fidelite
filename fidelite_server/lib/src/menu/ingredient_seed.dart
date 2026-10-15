import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Seeds the customization options offered on a sandwich/malfouf/chapati
/// item (see MenuItemRecord.isCustomizable) if the table is empty -- the
/// owner's starting list for the base recipe (removable -- "menghir") and
/// the sauces (addable). Plain editable catalog data rather than hardcoded
/// in the app; there's no staff tooling to edit it yet (direct DB edit in
/// the meantime), same situation rewards_seed.dart was in before
/// RewardsEndpoint existed.
Future<void> ensureIngredientsSeeded(Session session) async {
  final existingCount = await IngredientRecord.db.count(session);
  if (existingCount > 0) return;

  var sortOrder = 0;
  final ingredients = <IngredientRecord>[];

  void add(String name, IngredientKind kind) {
    ingredients.add(
      IngredientRecord(name: name, kind: kind, sortOrder: sortOrder++),
    );
  }

  // The base recipe shared by essentially every sandwich/malfouf/chapati --
  // what the customer can ask to leave out.
  add('Harissa', IngredientKind.base);
  add('Mayonnaise', IngredientKind.base);
  add('Slata mechwia', IngredientKind.base);
  add('Khas (Slata khadhra)', IngredientKind.base);
  add('Onion', IngredientKind.base);
  add('Tmatem', IngredientKind.base);
  add('Zitoun', IngredientKind.base);

  // Optional sauces the customer can add on top -- note "Mayonnaise"
  // appears in both lists on purpose: removing the base one and adding
  // extra as a sauce are two different requests.
  add('Barbecue', IngredientKind.sauce);
  add('Ketchup', IngredientKind.sauce);
  add('Mayonnaise', IngredientKind.sauce);

  await IngredientRecord.db.insert(session, ingredients);
  session.log('Seeded ${ingredients.length} ingredient options.');
}
