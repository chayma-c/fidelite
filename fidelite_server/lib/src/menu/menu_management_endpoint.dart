import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Staff-only menu administration: create/edit items and toggle their
/// availability. `MenuEndpoint.getMenu` stays the "what can currently be
/// ordered" view shared by both roles; this is the separate management
/// surface behind it.
class MenuManagementEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:staff')};

  /// Every item, active or not, for the management list.
  Future<List<MenuItemRecord>> listAllMenuItems(Session session) {
    return MenuItemRecord.db.find(
      session,
      orderByList: (t) => [
        Order(column: t.category),
        Order(column: t.sortOrder),
        Order(column: t.name),
      ],
    );
  }

  /// Distinct categories currently in use, for the add/edit form's picker --
  /// steers staff toward reusing an existing category instead of typo'ing a
  /// near-duplicate, without needing a separate category table.
  Future<List<String>> getCategories(Session session) async {
    final items = await MenuItemRecord.db.find(session);
    final categories = items.map((item) => item.category).toSet().toList();
    categories.sort();
    return categories;
  }

  Future<MenuItemRecord> createMenuItem(
    Session session, {
    required String name,
    required String? description,
    required String category,
    required int priceMillimes,
  }) async {
    final cleanName = name.trim();
    final cleanCategory = category.trim();
    final cleanDescription = _cleanOrNull(description);
    _validate(cleanName, cleanCategory, priceMillimes);
    await _ensureNoDuplicate(
      session,
      name: cleanName,
      category: cleanCategory,
      excludingId: null,
    );

    final now = DateTime.now().toUtc();
    return MenuItemRecord.db.insertRow(
      session,
      MenuItemRecord(
        name: cleanName,
        description: cleanDescription,
        category: cleanCategory,
        priceMillimes: priceMillimes,
        // Appended to the end of its category; staff don't currently have a
        // way to reorder items within a category.
        sortOrder: await _nextSortOrder(session, cleanCategory),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<MenuItemRecord> updateMenuItem(
    Session session, {
    required int id,
    required String name,
    required String? description,
    required String category,
    required int priceMillimes,
  }) async {
    final existing = await MenuItemRecord.db.findById(session, id);
    if (existing == null) {
      throw MenuItemValidationException(
        reason: MenuItemValidationExceptionReason.notFound,
      );
    }

    final cleanName = name.trim();
    final cleanCategory = category.trim();
    final cleanDescription = _cleanOrNull(description);
    _validate(cleanName, cleanCategory, priceMillimes);
    await _ensureNoDuplicate(
      session,
      name: cleanName,
      category: cleanCategory,
      excludingId: id,
    );

    return MenuItemRecord.db.updateRow(
      session,
      existing.copyWith(
        name: cleanName,
        description: cleanDescription,
        category: cleanCategory,
        priceMillimes: priceMillimes,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  /// "Delete"/restore, in effect: see [MenuItemRecord.isActive]'s doc
  /// comment for why this is a soft toggle rather than a real row delete
  /// (order history depends on the row still existing).
  Future<MenuItemRecord> setMenuItemActive(
    Session session, {
    required int id,
    required bool isActive,
  }) async {
    final existing = await MenuItemRecord.db.findById(session, id);
    if (existing == null) {
      throw MenuItemValidationException(
        reason: MenuItemValidationExceptionReason.notFound,
      );
    }
    return MenuItemRecord.db.updateRow(
      session,
      existing.copyWith(
        isActive: isActive,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  String? _cleanOrNull(String? value) {
    final trimmed = value?.trim();
    return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }

  void _validate(String name, String category, int priceMillimes) {
    if (name.isEmpty) {
      throw MenuItemValidationException(
        reason: MenuItemValidationExceptionReason.nameRequired,
      );
    }
    if (category.isEmpty) {
      throw MenuItemValidationException(
        reason: MenuItemValidationExceptionReason.categoryRequired,
      );
    }
    if (priceMillimes <= 0) {
      throw MenuItemValidationException(
        reason: MenuItemValidationExceptionReason.invalidPrice,
      );
    }
  }

  /// Scoped to active items only, so re-adding an item under a name that
  /// only a *deactivated* item currently holds is allowed.
  Future<void> _ensureNoDuplicate(
    Session session, {
    required String name,
    required String category,
    required int? excludingId,
  }) async {
    final matches = await MenuItemRecord.db.find(
      session,
      where: (t) => t.category.equals(category) & t.isActive.equals(true),
    );
    final duplicate = matches.any(
      (item) =>
          item.id != excludingId &&
          item.name.toLowerCase() == name.toLowerCase(),
    );
    if (duplicate) {
      throw MenuItemValidationException(
        reason: MenuItemValidationExceptionReason.duplicateName,
      );
    }
  }

  Future<int> _nextSortOrder(Session session, String category) async {
    final items = await MenuItemRecord.db.find(
      session,
      where: (t) => t.category.equals(category),
    );
    if (items.isEmpty) return 0;
    return items.map((item) => item.sortOrder).reduce((a, b) => a > b ? a : b) +
        1;
  }
}
