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
// ignore_for_file: unnecessary_null_comparison

import 'package:serverpod/serverpod.dart' as _i1;
import '../orders/order_status.dart' as _i2;
import '../users/app_user.dart' as _i3;
import 'package:fidelite_server/src/generated/protocol.dart' as _i4;

/// A confirmed counter order. Created already-confirmed in one atomic call
/// (OrderEndpoint.submitOrder) -- the cart is client-local state until that
/// single "confirm" tap, so there's no separate "pending" order concept in
/// the schema. Named `fidelite_order`/`OrderRecord` (not `order`/`Order`)
/// since "order" is a reserved SQL keyword and collides with Serverpod's
/// own `Order` (see database/concepts/order.dart) used for query sorting.
abstract class OrderRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrderRecord._({
    this.id,
    required this.staffUserId,
    this.staffUser,
    _i2.OrderStatus? status,
    required this.subtotalMillimes,
    required this.totalMillimes,
    DateTime? createdAt,
  }) : status = status ?? _i2.OrderStatus.confirmed,
       createdAt = createdAt ?? DateTime.now();

  factory OrderRecord({
    int? id,
    required _i1.UuidValue staffUserId,
    _i3.AppUserRecord? staffUser,
    _i2.OrderStatus? status,
    required int subtotalMillimes,
    required int totalMillimes,
    DateTime? createdAt,
  }) = _OrderRecordImpl;

  factory OrderRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderRecord(
      id: jsonSerialization['id'] as int?,
      staffUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['staffUserId'],
      ),
      staffUser: jsonSerialization['staffUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['staffUser'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.OrderStatus.fromJson((jsonSerialization['status'] as String)),
      subtotalMillimes: jsonSerialization['subtotalMillimes'] as int,
      totalMillimes: jsonSerialization['totalMillimes'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = OrderRecordTable();

  static const db = OrderRecordRepository._();

  @override
  int? id;

  _i1.UuidValue staffUserId;

  /// The staff member who took this order.
  _i3.AppUserRecord? staffUser;

  _i2.OrderStatus status;

  /// Split from totalMillimes now so a discount/tax line can be introduced
  /// later without a schema change; currently always equal.
  int subtotalMillimes;

  int totalMillimes;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrderRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderRecord copyWith({
    int? id,
    _i1.UuidValue? staffUserId,
    _i3.AppUserRecord? staffUser,
    _i2.OrderStatus? status,
    int? subtotalMillimes,
    int? totalMillimes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderRecord',
      if (id != null) 'id': id,
      'staffUserId': staffUserId.toJson(),
      if (staffUser != null) 'staffUser': staffUser?.toJson(),
      'status': status.toJson(),
      'subtotalMillimes': subtotalMillimes,
      'totalMillimes': totalMillimes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderRecord',
      if (id != null) 'id': id,
      'staffUserId': staffUserId.toJson(),
      if (staffUser != null) 'staffUser': staffUser?.toJsonForProtocol(),
      'status': status.toJson(),
      'subtotalMillimes': subtotalMillimes,
      'totalMillimes': totalMillimes,
      'createdAt': createdAt.toJson(),
    };
  }

  static OrderRecordInclude include({_i3.AppUserRecordInclude? staffUser}) {
    return OrderRecordInclude._(staffUser: staffUser);
  }

  static OrderRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderRecordTable>? orderByList,
    OrderRecordInclude? include,
  }) {
    return OrderRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrderRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderRecordImpl extends OrderRecord {
  _OrderRecordImpl({
    int? id,
    required _i1.UuidValue staffUserId,
    _i3.AppUserRecord? staffUser,
    _i2.OrderStatus? status,
    required int subtotalMillimes,
    required int totalMillimes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         staffUserId: staffUserId,
         staffUser: staffUser,
         status: status,
         subtotalMillimes: subtotalMillimes,
         totalMillimes: totalMillimes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OrderRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? staffUserId,
    Object? staffUser = _Undefined,
    _i2.OrderStatus? status,
    int? subtotalMillimes,
    int? totalMillimes,
    DateTime? createdAt,
  }) {
    return OrderRecord(
      id: id is int? ? id : this.id,
      staffUserId: staffUserId ?? this.staffUserId,
      staffUser: staffUser is _i3.AppUserRecord?
          ? staffUser
          : this.staffUser?.copyWith(),
      status: status ?? this.status,
      subtotalMillimes: subtotalMillimes ?? this.subtotalMillimes,
      totalMillimes: totalMillimes ?? this.totalMillimes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OrderRecordUpdateTable extends _i1.UpdateTable<OrderRecordTable> {
  OrderRecordUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> staffUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.staffUserId,
    value,
  );

  _i1.ColumnValue<_i2.OrderStatus, _i2.OrderStatus> status(
    _i2.OrderStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> subtotalMillimes(int value) => _i1.ColumnValue(
    table.subtotalMillimes,
    value,
  );

  _i1.ColumnValue<int, int> totalMillimes(int value) => _i1.ColumnValue(
    table.totalMillimes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class OrderRecordTable extends _i1.Table<int?> {
  OrderRecordTable({super.tableRelation}) : super(tableName: 'fidelite_order') {
    updateTable = OrderRecordUpdateTable(this);
    staffUserId = _i1.ColumnUuid(
      'staffUserId',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    subtotalMillimes = _i1.ColumnInt(
      'subtotalMillimes',
      this,
    );
    totalMillimes = _i1.ColumnInt(
      'totalMillimes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final OrderRecordUpdateTable updateTable;

  late final _i1.ColumnUuid staffUserId;

  /// The staff member who took this order.
  _i3.AppUserRecordTable? _staffUser;

  late final _i1.ColumnEnum<_i2.OrderStatus> status;

  /// Split from totalMillimes now so a discount/tax line can be introduced
  /// later without a schema change; currently always equal.
  late final _i1.ColumnInt subtotalMillimes;

  late final _i1.ColumnInt totalMillimes;

  late final _i1.ColumnDateTime createdAt;

  _i3.AppUserRecordTable get staffUser {
    if (_staffUser != null) return _staffUser!;
    _staffUser = _i1.createRelationTable(
      relationFieldName: 'staffUser',
      field: OrderRecord.t.staffUserId,
      foreignField: _i3.AppUserRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AppUserRecordTable(tableRelation: foreignTableRelation),
    );
    return _staffUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    staffUserId,
    status,
    subtotalMillimes,
    totalMillimes,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'staffUser') {
      return staffUser;
    }
    return null;
  }
}

class OrderRecordInclude extends _i1.IncludeObject {
  OrderRecordInclude._({_i3.AppUserRecordInclude? staffUser}) {
    _staffUser = staffUser;
  }

  _i3.AppUserRecordInclude? _staffUser;

  @override
  Map<String, _i1.Include?> get includes => {'staffUser': _staffUser};

  @override
  _i1.Table<int?> get table => OrderRecord.t;
}

class OrderRecordIncludeList extends _i1.IncludeList {
  OrderRecordIncludeList._({
    _i1.WhereExpressionBuilder<OrderRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrderRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrderRecord.t;
}

class OrderRecordRepository {
  const OrderRecordRepository._();

  final attachRow = const OrderRecordAttachRowRepository._();

  /// Returns a list of [OrderRecord]s matching the given query parameters.
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
  Future<List<OrderRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderRecordTable>? orderByList,
    _i1.Transaction? transaction,
    OrderRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OrderRecord>(
      where: where?.call(OrderRecord.t),
      orderBy: orderBy?.call(OrderRecord.t),
      orderByList: orderByList?.call(OrderRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OrderRecord] matching the given query parameters.
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
  Future<OrderRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderRecordTable>? orderByList,
    _i1.Transaction? transaction,
    OrderRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OrderRecord>(
      where: where?.call(OrderRecord.t),
      orderBy: orderBy?.call(OrderRecord.t),
      orderByList: orderByList?.call(OrderRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OrderRecord] by its [id] or null if no such row exists.
  Future<OrderRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    OrderRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OrderRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OrderRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [OrderRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OrderRecord>> insert(
    _i1.DatabaseSession session,
    List<OrderRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OrderRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OrderRecord] and returns the inserted row.
  ///
  /// The returned [OrderRecord] will have its `id` field set.
  Future<OrderRecord> insertRow(
    _i1.DatabaseSession session,
    OrderRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrderRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrderRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrderRecord>> update(
    _i1.DatabaseSession session,
    List<OrderRecord> rows, {
    _i1.ColumnSelections<OrderRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrderRecord>(
      rows,
      columns: columns?.call(OrderRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrderRecord> updateRow(
    _i1.DatabaseSession session,
    OrderRecord row, {
    _i1.ColumnSelections<OrderRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrderRecord>(
      row,
      columns: columns?.call(OrderRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrderRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderRecordUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OrderRecord>(
      id,
      columnValues: columnValues(OrderRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrderRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OrderRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OrderRecordUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OrderRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderRecordTable>? orderBy,
    _i1.OrderByListBuilder<OrderRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OrderRecord>(
      columnValues: columnValues(OrderRecord.t.updateTable),
      where: where(OrderRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderRecord.t),
      orderByList: orderByList?.call(OrderRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OrderRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrderRecord>> delete(
    _i1.DatabaseSession session,
    List<OrderRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrderRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrderRecord].
  Future<OrderRecord> deleteRow(
    _i1.DatabaseSession session,
    OrderRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrderRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrderRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrderRecord>(
      where: where(OrderRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrderRecord>(
      where: where?.call(OrderRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OrderRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OrderRecord>(
      where: where(OrderRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class OrderRecordAttachRowRepository {
  const OrderRecordAttachRowRepository._();

  /// Creates a relation between the given [OrderRecord] and [AppUserRecord]
  /// by setting the [OrderRecord]'s foreign key `staffUserId` to refer to the [AppUserRecord].
  Future<void> staffUser(
    _i1.DatabaseSession session,
    OrderRecord orderRecord,
    _i3.AppUserRecord staffUser, {
    _i1.Transaction? transaction,
  }) async {
    if (orderRecord.id == null) {
      throw ArgumentError.notNull('orderRecord.id');
    }
    if (staffUser.id == null) {
      throw ArgumentError.notNull('staffUser.id');
    }

    var $orderRecord = orderRecord.copyWith(staffUserId: staffUser.id);
    await session.db.updateRow<OrderRecord>(
      $orderRecord,
      columns: [OrderRecord.t.staffUserId],
      transaction: transaction,
    );
  }
}
