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

/// A catalog item redeemable for cashback. Deliberately a separate catalog
/// from the cash menu (not "spend balance as a discount on any menu item")
/// -- confirmed as the desired model up front -- currently seeded as a
/// mirror of the menu at its normal prices, but independent going forward:
/// editing a reward here never affects menu pricing or vice versa.
abstract class RewardItemRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RewardItemRecord._({
    this.id,
    required this.name,
    this.description,
    required this.pointsCost,
    bool? isActive,
    this.stock,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory RewardItemRecord({
    int? id,
    required String name,
    String? description,
    required int pointsCost,
    bool? isActive,
    int? stock,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RewardItemRecordImpl;

  factory RewardItemRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardItemRecord(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      pointsCost: jsonSerialization['pointsCost'] as int,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      stock: jsonSerialization['stock'] as int?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = RewardItemRecordTable();

  static const db = RewardItemRecordRepository._();

  @override
  int? id;

  String name;

  String? description;

  /// In millimes, same unit as the cashback balance itself.
  int pointsCost;

  /// Soft-disable instead of delete, so historical redemptions keep valid
  /// references (see RedemptionRecord's name/cost snapshot fields).
  bool isActive;

  /// Remaining redemptions available, or null for unlimited. Nothing
  /// decrements this yet -- reserved for a future limited-reward feature.
  int? stock;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RewardItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RewardItemRecord copyWith({
    int? id,
    String? name,
    String? description,
    int? pointsCost,
    bool? isActive,
    int? stock,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardItemRecord',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'pointsCost': pointsCost,
      'isActive': isActive,
      if (stock != null) 'stock': stock,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RewardItemRecord',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'pointsCost': pointsCost,
      'isActive': isActive,
      if (stock != null) 'stock': stock,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static RewardItemRecordInclude include() {
    return RewardItemRecordInclude._();
  }

  static RewardItemRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<RewardItemRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RewardItemRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RewardItemRecordTable>? orderByList,
    RewardItemRecordInclude? include,
  }) {
    return RewardItemRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardItemRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RewardItemRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardItemRecordImpl extends RewardItemRecord {
  _RewardItemRecordImpl({
    int? id,
    required String name,
    String? description,
    required int pointsCost,
    bool? isActive,
    int? stock,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         description: description,
         pointsCost: pointsCost,
         isActive: isActive,
         stock: stock,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RewardItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RewardItemRecord copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? pointsCost,
    bool? isActive,
    Object? stock = _Undefined,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RewardItemRecord(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      pointsCost: pointsCost ?? this.pointsCost,
      isActive: isActive ?? this.isActive,
      stock: stock is int? ? stock : this.stock,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class RewardItemRecordUpdateTable
    extends _i1.UpdateTable<RewardItemRecordTable> {
  RewardItemRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<int, int> pointsCost(int value) => _i1.ColumnValue(
    table.pointsCost,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<int, int> stock(int? value) => _i1.ColumnValue(
    table.stock,
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

class RewardItemRecordTable extends _i1.Table<int?> {
  RewardItemRecordTable({super.tableRelation})
    : super(tableName: 'reward_item') {
    updateTable = RewardItemRecordUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    pointsCost = _i1.ColumnInt(
      'pointsCost',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
    );
    stock = _i1.ColumnInt(
      'stock',
      this,
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

  late final RewardItemRecordUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  /// In millimes, same unit as the cashback balance itself.
  late final _i1.ColumnInt pointsCost;

  /// Soft-disable instead of delete, so historical redemptions keep valid
  /// references (see RedemptionRecord's name/cost snapshot fields).
  late final _i1.ColumnBool isActive;

  /// Remaining redemptions available, or null for unlimited. Nothing
  /// decrements this yet -- reserved for a future limited-reward feature.
  late final _i1.ColumnInt stock;

  late final _i1.ColumnInt sortOrder;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    description,
    pointsCost,
    isActive,
    stock,
    sortOrder,
    createdAt,
    updatedAt,
  ];
}

class RewardItemRecordInclude extends _i1.IncludeObject {
  RewardItemRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RewardItemRecord.t;
}

class RewardItemRecordIncludeList extends _i1.IncludeList {
  RewardItemRecordIncludeList._({
    _i1.WhereExpressionBuilder<RewardItemRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RewardItemRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RewardItemRecord.t;
}

class RewardItemRecordRepository {
  const RewardItemRecordRepository._();

  /// Returns a list of [RewardItemRecord]s matching the given query parameters.
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
  Future<List<RewardItemRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RewardItemRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RewardItemRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RewardItemRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RewardItemRecord>(
      where: where?.call(RewardItemRecord.t),
      orderBy: orderBy?.call(RewardItemRecord.t),
      orderByList: orderByList?.call(RewardItemRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RewardItemRecord] matching the given query parameters.
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
  Future<RewardItemRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RewardItemRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<RewardItemRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RewardItemRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RewardItemRecord>(
      where: where?.call(RewardItemRecord.t),
      orderBy: orderBy?.call(RewardItemRecord.t),
      orderByList: orderByList?.call(RewardItemRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RewardItemRecord] by its [id] or null if no such row exists.
  Future<RewardItemRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RewardItemRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RewardItemRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [RewardItemRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RewardItemRecord>> insert(
    _i1.DatabaseSession session,
    List<RewardItemRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RewardItemRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RewardItemRecord] and returns the inserted row.
  ///
  /// The returned [RewardItemRecord] will have its `id` field set.
  Future<RewardItemRecord> insertRow(
    _i1.DatabaseSession session,
    RewardItemRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RewardItemRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RewardItemRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RewardItemRecord>> update(
    _i1.DatabaseSession session,
    List<RewardItemRecord> rows, {
    _i1.ColumnSelections<RewardItemRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RewardItemRecord>(
      rows,
      columns: columns?.call(RewardItemRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardItemRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RewardItemRecord> updateRow(
    _i1.DatabaseSession session,
    RewardItemRecord row, {
    _i1.ColumnSelections<RewardItemRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RewardItemRecord>(
      row,
      columns: columns?.call(RewardItemRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RewardItemRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RewardItemRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RewardItemRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RewardItemRecord>(
      id,
      columnValues: columnValues(RewardItemRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RewardItemRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RewardItemRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RewardItemRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<RewardItemRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RewardItemRecordTable>? orderBy,
    _i1.OrderByListBuilder<RewardItemRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RewardItemRecord>(
      columnValues: columnValues(RewardItemRecord.t.updateTable),
      where: where(RewardItemRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RewardItemRecord.t),
      orderByList: orderByList?.call(RewardItemRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RewardItemRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RewardItemRecord>> delete(
    _i1.DatabaseSession session,
    List<RewardItemRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RewardItemRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RewardItemRecord].
  Future<RewardItemRecord> deleteRow(
    _i1.DatabaseSession session,
    RewardItemRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RewardItemRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RewardItemRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RewardItemRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RewardItemRecord>(
      where: where(RewardItemRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RewardItemRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RewardItemRecord>(
      where: where?.call(RewardItemRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RewardItemRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RewardItemRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RewardItemRecord>(
      where: where(RewardItemRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
