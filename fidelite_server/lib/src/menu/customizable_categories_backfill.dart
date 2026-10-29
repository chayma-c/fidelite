import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Sandwich/malfouf/chapati items get the "leave out a base ingredient /
/// add a sauce / special request" customization flow (see
/// MenuItemRecord.isCustomizable) -- plates and suppléments don't. Mirrors
/// the category list menu_seed.dart marks customizable for a brand-new
/// database.
const _customizableCategories = {'Sandwich', 'Malfouf', 'Chapati'};

/// One-time backfill, made idempotent/safe to run on every boot rather
/// than a one-off manual command: marks every existing item in
/// [_customizableCategories] as customizable.
///
/// MenuItemRecord.isCustomizable was added to an already-populated table
/// (every environment's menu predates the flag -- see
/// menu_item.spy.yaml's migration), so the column-add migration alone
/// left every existing row at its default (false). menu_seed.dart's own
/// `isCustomizable: true` calls only apply to a *fresh* seed of an empty
/// table, which never re-runs once a menu exists -- so without this, only
/// a database that happened to get the exact manual `UPDATE` run against
/// it directly (true of local dev, not production) would ever have the
/// flag set correctly. This closes that gap for every environment,
/// automatically, on deploy.
Future<void> ensureCustomizableCategoriesBackfilled(Session session) async {
  final updated = await MenuItemRecord.db.updateWhere(
    session,
    columnValues: (t) => [t.isCustomizable(true)],
    where: (t) =>
        t.category.inSet(_customizableCategories) &
        t.isCustomizable.equals(false),
  );
  if (updated.isNotEmpty) {
    session.log(
      'Backfilled isCustomizable=true on ${updated.length} existing menu '
      'item(s).',
    );
  }
}
