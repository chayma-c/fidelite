/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;

/// A purchasable item on the restaurant's menu.
abstract class MenuItemRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MenuItemRecord._({
    this.id,
    required this.name,
    this.description,
    required this.priceMillimes,
    required this.category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory MenuItemRecord({
    int? id,
    required String name,
    String? description,
    required int priceMillimes,
    required String category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MenuItemRecordImpl;

  factory MenuItemRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuItemRecord(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      priceMillimes: jsonSerialization['priceMillimes'] as int,
      category: jsonSerialization['category'] as String,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = MenuItemRecordTable();

  static const db = MenuItemRecordRepository._();

  @override
  int? id;

  String name;

  String? description;

  /// Price in millimes (1 Tunisian Dinar = 1000 millimes), matching the
  /// 3-decimal pricing on the physical menu (e.g. "3.000 DT").
  int priceMillimes;

  /// Menu section, e.g. "Chapati", "Sandwich", "Plats". Plain string for
  /// now rather than a separate category table -- the menu is still
  /// settling, and this keeps re-labelling cheap.
  String category;

  /// Soft-disable instead of delete, so historical orders keep valid
  /// references (see OrderItemRecord's name/price snapshot fields).
  bool isActive;

  /// Display order within a category.
  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MenuItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MenuItemRecord copyWith({
    int? id,
    String? name,
    String? description,
    int? priceMillimes,
    String? category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuItemRecord',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'priceMillimes': priceMillimes,
      'category': category,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuItemRecord',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'priceMillimes': priceMillimes,
      'category': category,
      'isActive': isActive,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MenuItemRecordInclude include() {
    return MenuItemRecordInclude._();
  }

  static MenuItemRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<MenuItemRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuItemRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuItemRecordTable>? orderByList,
    MenuItemRecordInclude? include,
  }) {
    return MenuItemRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuItemRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MenuItemRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuItemRecordImpl extends MenuItemRecord {
  _MenuItemRecordImpl({
    int? id,
    required String name,
    String? description,
    required int priceMillimes,
    required String category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         description: description,
         priceMillimes: priceMillimes,
         category: category,
         isActive: isActive,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MenuItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MenuItemRecord copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? priceMillimes,
    String? category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MenuItemRecord(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      priceMillimes: priceMillimes ?? this.priceMillimes,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MenuItemRecordUpdateTable extends _i1.UpdateTable<MenuItemRecordTable> {
  MenuItemRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<int, int> priceMillimes(int value) => _i1.ColumnValue(
    table.priceMillimes,
    value,
  );

  _i1.ColumnValue<String, String> category(String value) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<int, int> sortOrder(int value) => _i1.ColumnValue(
    table.sortOrder,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class MenuItemRecordTable extends _i1.Table<int?> {
  MenuItemRecordTable({super.tableRelation}) : super(tableName: 'menu_item') {
    updateTable = MenuItemRecordUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    priceMillimes = _i1.ColumnInt(
      'priceMillimes',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    sortOrder = _i1.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final MenuItemRecordUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  /// Price in millimes (1 Tunisian Dinar = 1000 millimes), matching the
  /// 3-decimal pricing on the physical menu (e.g. "3.000 DT").
  late final _i1.ColumnInt priceMillimes;

  /// Menu section, e.g. "Chapati", "Sandwich", "Plats". Plain string for
  /// now rather than a separate category table -- the menu is still
  /// settling, and this keeps re-labelling cheap.
  late final _i1.ColumnString category;

  /// Soft-disable instead of delete, so historical orders keep valid
  /// references (see OrderItemRecord's name/price snapshot fields).
  late final _i1.ColumnBool isActive;

  /// Display order within a category.
  late final _i1.ColumnInt sortOrder;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    description,
    priceMillimes,
    category,
    isActive,
    sortOrder,
    createdAt,
    updatedAt,
  ];
}

class MenuItemRecordInclude extends _i1.IncludeObject {
  MenuItemRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MenuItemRecord.t;
}

class MenuItemRecordIncludeList extends _i1.IncludeList {
  MenuItemRecordIncludeList._({
    _i1.WhereExpressionBuilder<MenuItemRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MenuItemRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MenuItemRecord.t;
}

class MenuItemRecordRepository {
  const MenuItemRecordRepository._();

  /// Returns a list of [MenuItemRecord]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<MenuItemRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MenuItemRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuItemRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuItemRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MenuItemRecord>(
      where: where?.call(MenuItemRecord.t),
      orderBy: orderBy?.call(MenuItemRecord.t),
      orderByList: orderByList?.call(MenuItemRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MenuItemRecord] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<MenuItemRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MenuItemRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<MenuItemRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MenuItemRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MenuItemRecord>(
      where: where?.call(MenuItemRecord.t),
      orderBy: orderBy?.call(MenuItemRecord.t),
      orderByList: orderByList?.call(MenuItemRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MenuItemRecord] by its [id] or null if no such row exists.
  Future<MenuItemRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MenuItemRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MenuItemRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [MenuItemRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MenuItemRecord>> insert(
    _i1.DatabaseSession session,
    List<MenuItemRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MenuItemRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MenuItemRecord] and returns the inserted row.
  ///
  /// The returned [MenuItemRecord] will have its `id` field set.
  Future<MenuItemRecord> insertRow(
    _i1.DatabaseSession session,
    MenuItemRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MenuItemRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MenuItemRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MenuItemRecord>> update(
    _i1.DatabaseSession session,
    List<MenuItemRecord> rows, {
    _i1.ColumnSelections<MenuItemRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MenuItemRecord>(
      rows,
      columns: columns?.call(MenuItemRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MenuItemRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MenuItemRecord> updateRow(
    _i1.DatabaseSession session,
    MenuItemRecord row, {
    _i1.ColumnSelections<MenuItemRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MenuItemRecord>(
      row,
      columns: columns?.call(MenuItemRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MenuItemRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MenuItemRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MenuItemRecordUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MenuItemRecord>(
      id,
      columnValues: columnValues(MenuItemRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MenuItemRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MenuItemRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MenuItemRecordUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MenuItemRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MenuItemRecordTable>? orderBy,
    _i1.OrderByListBuilder<MenuItemRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MenuItemRecord>(
      columnValues: columnValues(MenuItemRecord.t.updateTable),
      where: where(MenuItemRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MenuItemRecord.t),
      orderByList: orderByList?.call(MenuItemRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MenuItemRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MenuItemRecord>> delete(
    _i1.DatabaseSession session,
    List<MenuItemRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MenuItemRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MenuItemRecord].
  Future<MenuItemRecord> deleteRow(
    _i1.DatabaseSession session,
    MenuItemRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MenuItemRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MenuItemRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MenuItemRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MenuItemRecord>(
      where: where(MenuItemRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MenuItemRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MenuItemRecord>(
      where: where?.call(MenuItemRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MenuItemRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MenuItemRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MenuItemRecord>(
      where: where(MenuItemRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
