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
import '../menu/ingredient_kind.dart' as _i2;

/// A customization option offered when ordering a sandwich/malfouf/chapati
/// item -- either part of the fixed base recipe the customer can ask to
/// leave out ("menghir"/without, in the local dialect), or an optional
/// sauce they can add on top. Plain editable catalog data rather than
/// hardcoded in the app, so the base recipe or sauce list can change
/// without a code change.
abstract class IngredientRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  IngredientRecord._({
    this.id,
    required this.name,
    required this.kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory IngredientRecord({
    int? id,
    required String name,
    required _i2.IngredientKind kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _IngredientRecordImpl;

  factory IngredientRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngredientRecord(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      kind: _i2.IngredientKind.fromJson((jsonSerialization['kind'] as String)),
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

  static final t = IngredientRecordTable();

  static const db = IngredientRecordRepository._();

  @override
  int? id;

  String name;

  _i2.IngredientKind kind;

  /// Soft-disable instead of delete, so a historical order's snapshotted
  /// ingredient names (see OrderItemRecord) stay meaningful even after an
  /// ingredient is retired from the catalog.
  bool isActive;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [IngredientRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  IngredientRecord copyWith({
    int? id,
    String? name,
    _i2.IngredientKind? kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngredientRecord',
      if (id != null) 'id': id,
      'name': name,
      'kind': kind.toJson(),
      'isActive': isActive,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IngredientRecord',
      if (id != null) 'id': id,
      'name': name,
      'kind': kind.toJson(),
      'isActive': isActive,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static IngredientRecordInclude include() {
    return IngredientRecordInclude._();
  }

  static IngredientRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<IngredientRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IngredientRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IngredientRecordTable>? orderByList,
    IngredientRecordInclude? include,
  }) {
    return IngredientRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IngredientRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(IngredientRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IngredientRecordImpl extends IngredientRecord {
  _IngredientRecordImpl({
    int? id,
    required String name,
    required _i2.IngredientKind kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         kind: kind,
         isActive: isActive,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [IngredientRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  IngredientRecord copyWith({
    Object? id = _Undefined,
    String? name,
    _i2.IngredientKind? kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IngredientRecord(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class IngredientRecordUpdateTable
    extends _i1.UpdateTable<IngredientRecordTable> {
  IngredientRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<_i2.IngredientKind, _i2.IngredientKind> kind(
    _i2.IngredientKind value,
  ) => _i1.ColumnValue(
    table.kind,
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

class IngredientRecordTable extends _i1.Table<int?> {
  IngredientRecordTable({super.tableRelation})
    : super(tableName: 'ingredient') {
    updateTable = IngredientRecordUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    kind = _i1.ColumnEnum(
      'kind',
      this,
      _i1.EnumSerialization.byName,
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

  late final IngredientRecordUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnEnum<_i2.IngredientKind> kind;

  /// Soft-disable instead of delete, so a historical order's snapshotted
  /// ingredient names (see OrderItemRecord) stay meaningful even after an
  /// ingredient is retired from the catalog.
  late final _i1.ColumnBool isActive;

  late final _i1.ColumnInt sortOrder;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    kind,
    isActive,
    sortOrder,
    createdAt,
    updatedAt,
  ];
}

class IngredientRecordInclude extends _i1.IncludeObject {
  IngredientRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => IngredientRecord.t;
}

class IngredientRecordIncludeList extends _i1.IncludeList {
  IngredientRecordIncludeList._({
    _i1.WhereExpressionBuilder<IngredientRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IngredientRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => IngredientRecord.t;
}

class IngredientRecordRepository {
  const IngredientRecordRepository._();

  /// Returns a list of [IngredientRecord]s matching the given query parameters.
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
  Future<List<IngredientRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<IngredientRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IngredientRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IngredientRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IngredientRecord>(
      where: where?.call(IngredientRecord.t),
      orderBy: orderBy?.call(IngredientRecord.t),
      orderByList: orderByList?.call(IngredientRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IngredientRecord] matching the given query parameters.
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
  Future<IngredientRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<IngredientRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<IngredientRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IngredientRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IngredientRecord>(
      where: where?.call(IngredientRecord.t),
      orderBy: orderBy?.call(IngredientRecord.t),
      orderByList: orderByList?.call(IngredientRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IngredientRecord] by its [id] or null if no such row exists.
  Future<IngredientRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IngredientRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IngredientRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [IngredientRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<IngredientRecord>> insert(
    _i1.DatabaseSession session,
    List<IngredientRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<IngredientRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [IngredientRecord] and returns the inserted row.
  ///
  /// The returned [IngredientRecord] will have its `id` field set.
  Future<IngredientRecord> insertRow(
    _i1.DatabaseSession session,
    IngredientRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<IngredientRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [IngredientRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<IngredientRecord>> update(
    _i1.DatabaseSession session,
    List<IngredientRecord> rows, {
    _i1.ColumnSelections<IngredientRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<IngredientRecord>(
      rows,
      columns: columns?.call(IngredientRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IngredientRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IngredientRecord> updateRow(
    _i1.DatabaseSession session,
    IngredientRecord row, {
    _i1.ColumnSelections<IngredientRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<IngredientRecord>(
      row,
      columns: columns?.call(IngredientRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IngredientRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IngredientRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<IngredientRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<IngredientRecord>(
      id,
      columnValues: columnValues(IngredientRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IngredientRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<IngredientRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<IngredientRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<IngredientRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IngredientRecordTable>? orderBy,
    _i1.OrderByListBuilder<IngredientRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<IngredientRecord>(
      columnValues: columnValues(IngredientRecord.t.updateTable),
      where: where(IngredientRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IngredientRecord.t),
      orderByList: orderByList?.call(IngredientRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [IngredientRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<IngredientRecord>> delete(
    _i1.DatabaseSession session,
    List<IngredientRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<IngredientRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [IngredientRecord].
  Future<IngredientRecord> deleteRow(
    _i1.DatabaseSession session,
    IngredientRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IngredientRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<IngredientRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<IngredientRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<IngredientRecord>(
      where: where(IngredientRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<IngredientRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<IngredientRecord>(
      where: where?.call(IngredientRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IngredientRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<IngredientRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IngredientRecord>(
      where: where(IngredientRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
