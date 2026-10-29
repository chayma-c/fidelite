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

/// Singleton row (see online_order_settings_util.dart for the same
/// lazy-create pattern as ShopStatusRecord) holding staff-controlled
/// operational settings for online orders. Written only through the
/// staff-only OnlineOrderSettingsEndpoint; most of it (e.g.
/// [autoPrintEnabled]) is never read back by a customer, except
/// [deliveryEnabled], exposed read-only through the separate public
/// OnlineOrderPublicSettingsEndpoint -- same public-read/staff-write split
/// already used for the menu and shop status.
abstract class OnlineOrderSettingsRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OnlineOrderSettingsRecord._({
    this.id,
    bool? autoPrintEnabled,
    bool? deliveryEnabled,
    DateTime? updatedAt,
  }) : autoPrintEnabled = autoPrintEnabled ?? false,
       deliveryEnabled = deliveryEnabled ?? true,
       updatedAt = updatedAt ?? DateTime.now();

  factory OnlineOrderSettingsRecord({
    int? id,
    bool? autoPrintEnabled,
    bool? deliveryEnabled,
    DateTime? updatedAt,
  }) = _OnlineOrderSettingsRecordImpl;

  factory OnlineOrderSettingsRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OnlineOrderSettingsRecord(
      id: jsonSerialization['id'] as int?,
      autoPrintEnabled: jsonSerialization['autoPrintEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['autoPrintEnabled'],
            ),
      deliveryEnabled: jsonSerialization['deliveryEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['deliveryEnabled'],
            ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = OnlineOrderSettingsRecordTable();

  static const db = OnlineOrderSettingsRecordRepository._();

  @override
  int? id;

  /// Whether a new online order should print automatically the moment
  /// staff's device notices it, instead of sitting in the Online Orders
  /// queue for a manual tap. Off by default -- auto-printing everything
  /// unconditionally is exactly what caused problems when staff were
  /// already busy taking counter orders.
  bool autoPrintEnabled;

  /// Whether a customer can choose delivery as a fulfillment method right
  /// now. On by default; staff turn it off when delivery genuinely can't
  /// be fulfilled (no one available to drive, etc.) rather than leaving
  /// customers to find out only after placing an order. Customer-visible
  /// -- see OnlineOrderPublicSettingsEndpoint, the one exception to this
  /// record otherwise being staff-internal only.
  bool deliveryEnabled;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OnlineOrderSettingsRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OnlineOrderSettingsRecord copyWith({
    int? id,
    bool? autoPrintEnabled,
    bool? deliveryEnabled,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OnlineOrderSettingsRecord',
      if (id != null) 'id': id,
      'autoPrintEnabled': autoPrintEnabled,
      'deliveryEnabled': deliveryEnabled,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OnlineOrderSettingsRecord',
      if (id != null) 'id': id,
      'autoPrintEnabled': autoPrintEnabled,
      'deliveryEnabled': deliveryEnabled,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static OnlineOrderSettingsRecordInclude include() {
    return OnlineOrderSettingsRecordInclude._();
  }

  static OnlineOrderSettingsRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<OnlineOrderSettingsRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OnlineOrderSettingsRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OnlineOrderSettingsRecordTable>? orderByList,
    OnlineOrderSettingsRecordInclude? include,
  }) {
    return OnlineOrderSettingsRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OnlineOrderSettingsRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OnlineOrderSettingsRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OnlineOrderSettingsRecordImpl extends OnlineOrderSettingsRecord {
  _OnlineOrderSettingsRecordImpl({
    int? id,
    bool? autoPrintEnabled,
    bool? deliveryEnabled,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         autoPrintEnabled: autoPrintEnabled,
         deliveryEnabled: deliveryEnabled,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [OnlineOrderSettingsRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OnlineOrderSettingsRecord copyWith({
    Object? id = _Undefined,
    bool? autoPrintEnabled,
    bool? deliveryEnabled,
    DateTime? updatedAt,
  }) {
    return OnlineOrderSettingsRecord(
      id: id is int? ? id : this.id,
      autoPrintEnabled: autoPrintEnabled ?? this.autoPrintEnabled,
      deliveryEnabled: deliveryEnabled ?? this.deliveryEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OnlineOrderSettingsRecordUpdateTable
    extends _i1.UpdateTable<OnlineOrderSettingsRecordTable> {
  OnlineOrderSettingsRecordUpdateTable(super.table);

  _i1.ColumnValue<bool, bool> autoPrintEnabled(bool value) => _i1.ColumnValue(
    table.autoPrintEnabled,
    value,
  );

  _i1.ColumnValue<bool, bool> deliveryEnabled(bool value) => _i1.ColumnValue(
    table.deliveryEnabled,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class OnlineOrderSettingsRecordTable extends _i1.Table<int?> {
  OnlineOrderSettingsRecordTable({super.tableRelation})
    : super(tableName: 'online_order_settings') {
    updateTable = OnlineOrderSettingsRecordUpdateTable(this);
    autoPrintEnabled = _i1.ColumnBool(
      'autoPrintEnabled',
      this,
      hasDefault: true,
    );
    deliveryEnabled = _i1.ColumnBool(
      'deliveryEnabled',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final OnlineOrderSettingsRecordUpdateTable updateTable;

  /// Whether a new online order should print automatically the moment
  /// staff's device notices it, instead of sitting in the Online Orders
  /// queue for a manual tap. Off by default -- auto-printing everything
  /// unconditionally is exactly what caused problems when staff were
  /// already busy taking counter orders.
  late final _i1.ColumnBool autoPrintEnabled;

  /// Whether a customer can choose delivery as a fulfillment method right
  /// now. On by default; staff turn it off when delivery genuinely can't
  /// be fulfilled (no one available to drive, etc.) rather than leaving
  /// customers to find out only after placing an order. Customer-visible
  /// -- see OnlineOrderPublicSettingsEndpoint, the one exception to this
  /// record otherwise being staff-internal only.
  late final _i1.ColumnBool deliveryEnabled;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    autoPrintEnabled,
    deliveryEnabled,
    updatedAt,
  ];
}

class OnlineOrderSettingsRecordInclude extends _i1.IncludeObject {
  OnlineOrderSettingsRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OnlineOrderSettingsRecord.t;
}

class OnlineOrderSettingsRecordIncludeList extends _i1.IncludeList {
  OnlineOrderSettingsRecordIncludeList._({
    _i1.WhereExpressionBuilder<OnlineOrderSettingsRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OnlineOrderSettingsRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OnlineOrderSettingsRecord.t;
}

class OnlineOrderSettingsRecordRepository {
  const OnlineOrderSettingsRecordRepository._();

  /// Returns a list of [OnlineOrderSettingsRecord]s matching the given query parameters.
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
  Future<List<OnlineOrderSettingsRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OnlineOrderSettingsRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OnlineOrderSettingsRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OnlineOrderSettingsRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OnlineOrderSettingsRecord>(
      where: where?.call(OnlineOrderSettingsRecord.t),
      orderBy: orderBy?.call(OnlineOrderSettingsRecord.t),
      orderByList: orderByList?.call(OnlineOrderSettingsRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OnlineOrderSettingsRecord] matching the given query parameters.
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
  Future<OnlineOrderSettingsRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OnlineOrderSettingsRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<OnlineOrderSettingsRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OnlineOrderSettingsRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OnlineOrderSettingsRecord>(
      where: where?.call(OnlineOrderSettingsRecord.t),
      orderBy: orderBy?.call(OnlineOrderSettingsRecord.t),
      orderByList: orderByList?.call(OnlineOrderSettingsRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OnlineOrderSettingsRecord] by its [id] or null if no such row exists.
  Future<OnlineOrderSettingsRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OnlineOrderSettingsRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OnlineOrderSettingsRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [OnlineOrderSettingsRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OnlineOrderSettingsRecord>> insert(
    _i1.DatabaseSession session,
    List<OnlineOrderSettingsRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OnlineOrderSettingsRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OnlineOrderSettingsRecord] and returns the inserted row.
  ///
  /// The returned [OnlineOrderSettingsRecord] will have its `id` field set.
  Future<OnlineOrderSettingsRecord> insertRow(
    _i1.DatabaseSession session,
    OnlineOrderSettingsRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OnlineOrderSettingsRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OnlineOrderSettingsRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OnlineOrderSettingsRecord>> update(
    _i1.DatabaseSession session,
    List<OnlineOrderSettingsRecord> rows, {
    _i1.ColumnSelections<OnlineOrderSettingsRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OnlineOrderSettingsRecord>(
      rows,
      columns: columns?.call(OnlineOrderSettingsRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OnlineOrderSettingsRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OnlineOrderSettingsRecord> updateRow(
    _i1.DatabaseSession session,
    OnlineOrderSettingsRecord row, {
    _i1.ColumnSelections<OnlineOrderSettingsRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OnlineOrderSettingsRecord>(
      row,
      columns: columns?.call(OnlineOrderSettingsRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OnlineOrderSettingsRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OnlineOrderSettingsRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OnlineOrderSettingsRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OnlineOrderSettingsRecord>(
      id,
      columnValues: columnValues(OnlineOrderSettingsRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OnlineOrderSettingsRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OnlineOrderSettingsRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OnlineOrderSettingsRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<OnlineOrderSettingsRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OnlineOrderSettingsRecordTable>? orderBy,
    _i1.OrderByListBuilder<OnlineOrderSettingsRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OnlineOrderSettingsRecord>(
      columnValues: columnValues(OnlineOrderSettingsRecord.t.updateTable),
      where: where(OnlineOrderSettingsRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OnlineOrderSettingsRecord.t),
      orderByList: orderByList?.call(OnlineOrderSettingsRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OnlineOrderSettingsRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OnlineOrderSettingsRecord>> delete(
    _i1.DatabaseSession session,
    List<OnlineOrderSettingsRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OnlineOrderSettingsRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OnlineOrderSettingsRecord].
  Future<OnlineOrderSettingsRecord> deleteRow(
    _i1.DatabaseSession session,
    OnlineOrderSettingsRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OnlineOrderSettingsRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OnlineOrderSettingsRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OnlineOrderSettingsRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OnlineOrderSettingsRecord>(
      where: where(OnlineOrderSettingsRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OnlineOrderSettingsRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OnlineOrderSettingsRecord>(
      where: where?.call(OnlineOrderSettingsRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OnlineOrderSettingsRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OnlineOrderSettingsRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OnlineOrderSettingsRecord>(
      where: where(OnlineOrderSettingsRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
