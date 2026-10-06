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

/// A confirmed order, placed either by staff at the counter or by a
/// customer ordering themselves (see OnlineOrderEndpoint). Created
/// already-confirmed in one atomic call -- the cart is client-local state
/// until that single "confirm"/"place order" tap, so there's no separate
/// "draft" order concept in the schema. Named `fidelite_order`/
/// `OrderRecord` (not `order`/`Order`) since "order" is a reserved SQL
/// keyword and collides with Serverpod's own `Order` (see
/// database/concepts/order.dart) used for query sorting.
abstract class OrderRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrderRecord._({
    this.id,
    this.staffUserId,
    this.staffUser,
    this.customerUserId,
    this.customerUser,
    this.handledAt,
    _i2.OrderStatus? status,
    int? ticketNumber,
    required this.subtotalMillimes,
    required this.totalMillimes,
    DateTime? createdAt,
  }) : status = status ?? _i2.OrderStatus.confirmed,
       ticketNumber = ticketNumber ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory OrderRecord({
    int? id,
    _i1.UuidValue? staffUserId,
    _i3.AppUserRecord? staffUser,
    _i1.UuidValue? customerUserId,
    _i3.AppUserRecord? customerUser,
    DateTime? handledAt,
    _i2.OrderStatus? status,
    int? ticketNumber,
    required int subtotalMillimes,
    required int totalMillimes,
    DateTime? createdAt,
  }) = _OrderRecordImpl;

  factory OrderRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderRecord(
      id: jsonSerialization['id'] as int?,
      staffUserId: jsonSerialization['staffUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['staffUserId'],
            ),
      staffUser: jsonSerialization['staffUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['staffUser'],
            ),
      customerUserId: jsonSerialization['customerUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['customerUserId'],
            ),
      customerUser: jsonSerialization['customerUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['customerUser'],
            ),
      handledAt: jsonSerialization['handledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['handledAt']),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.OrderStatus.fromJson((jsonSerialization['status'] as String)),
      ticketNumber: jsonSerialization['ticketNumber'] as int?,
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

  _i1.UuidValue? staffUserId;

  /// The staff member who took this order at the counter. Null for an
  /// online order -- see [customerUser].
  _i3.AppUserRecord? staffUser;

  _i1.UuidValue? customerUserId;

  /// The customer who placed this order themselves, if it's an online
  /// order. This (not a separate "source" flag) is what distinguishes an
  /// online order from a counter one -- exactly one of [staffUser]/
  /// [customerUser] is ever set.
  _i3.AppUserRecord? customerUser;

  /// When staff became aware of/processed this order. Set to [createdAt]
  /// itself for a counter order -- staff creating it in person *is*
  /// handling it -- so only an online order is ever actually null here,
  /// which is what makes a plain `handledAt == null` filter enough to
  /// drive both the staff notification badge and the Online Orders queue
  /// (see OnlineOrderManagementEndpoint.listUnhandled).
  DateTime? handledAt;

  _i2.OrderStatus status;

  /// A short, printable customer-facing sequence -- 1..100, wrapping back
  /// to 1 -- resetting every restaurant-local day. Distinct from `id`
  /// (which never resets and just keeps growing): this is what's called
  /// out to a customer and printed large on the ticket. See
  /// ticket_numbering.dart for how it's assigned.
  int ticketNumber;

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
    _i1.UuidValue? customerUserId,
    _i3.AppUserRecord? customerUser,
    DateTime? handledAt,
    _i2.OrderStatus? status,
    int? ticketNumber,
    int? subtotalMillimes,
    int? totalMillimes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderRecord',
      if (id != null) 'id': id,
      if (staffUserId != null) 'staffUserId': staffUserId?.toJson(),
      if (staffUser != null) 'staffUser': staffUser?.toJson(),
      if (customerUserId != null) 'customerUserId': customerUserId?.toJson(),
      if (customerUser != null) 'customerUser': customerUser?.toJson(),
      if (handledAt != null) 'handledAt': handledAt?.toJson(),
      'status': status.toJson(),
      'ticketNumber': ticketNumber,
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
      if (staffUserId != null) 'staffUserId': staffUserId?.toJson(),
      if (staffUser != null) 'staffUser': staffUser?.toJsonForProtocol(),
      if (customerUserId != null) 'customerUserId': customerUserId?.toJson(),
      if (customerUser != null)
        'customerUser': customerUser?.toJsonForProtocol(),
      if (handledAt != null) 'handledAt': handledAt?.toJson(),
      'status': status.toJson(),
      'ticketNumber': ticketNumber,
      'subtotalMillimes': subtotalMillimes,
      'totalMillimes': totalMillimes,
      'createdAt': createdAt.toJson(),
    };
  }

  static OrderRecordInclude include({
    _i3.AppUserRecordInclude? staffUser,
    _i3.AppUserRecordInclude? customerUser,
  }) {
    return OrderRecordInclude._(
      staffUser: staffUser,
      customerUser: customerUser,
    );
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
    _i1.UuidValue? staffUserId,
    _i3.AppUserRecord? staffUser,
    _i1.UuidValue? customerUserId,
    _i3.AppUserRecord? customerUser,
    DateTime? handledAt,
    _i2.OrderStatus? status,
    int? ticketNumber,
    required int subtotalMillimes,
    required int totalMillimes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         staffUserId: staffUserId,
         staffUser: staffUser,
         customerUserId: customerUserId,
         customerUser: customerUser,
         handledAt: handledAt,
         status: status,
         ticketNumber: ticketNumber,
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
    Object? staffUserId = _Undefined,
    Object? staffUser = _Undefined,
    Object? customerUserId = _Undefined,
    Object? customerUser = _Undefined,
    Object? handledAt = _Undefined,
    _i2.OrderStatus? status,
    int? ticketNumber,
    int? subtotalMillimes,
    int? totalMillimes,
    DateTime? createdAt,
  }) {
    return OrderRecord(
      id: id is int? ? id : this.id,
      staffUserId: staffUserId is _i1.UuidValue?
          ? staffUserId
          : this.staffUserId,
      staffUser: staffUser is _i3.AppUserRecord?
          ? staffUser
          : this.staffUser?.copyWith(),
      customerUserId: customerUserId is _i1.UuidValue?
          ? customerUserId
          : this.customerUserId,
      customerUser: customerUser is _i3.AppUserRecord?
          ? customerUser
          : this.customerUser?.copyWith(),
      handledAt: handledAt is DateTime? ? handledAt : this.handledAt,
      status: status ?? this.status,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      subtotalMillimes: subtotalMillimes ?? this.subtotalMillimes,
      totalMillimes: totalMillimes ?? this.totalMillimes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OrderRecordUpdateTable extends _i1.UpdateTable<OrderRecordTable> {
  OrderRecordUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> staffUserId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.staffUserId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> customerUserId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.customerUserId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> handledAt(DateTime? value) =>
      _i1.ColumnValue(
        table.handledAt,
        value,
      );

  _i1.ColumnValue<_i2.OrderStatus, _i2.OrderStatus> status(
    _i2.OrderStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> ticketNumber(int value) => _i1.ColumnValue(
    table.ticketNumber,
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
    customerUserId = _i1.ColumnUuid(
      'customerUserId',
      this,
    );
    handledAt = _i1.ColumnDateTime(
      'handledAt',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    ticketNumber = _i1.ColumnInt(
      'ticketNumber',
      this,
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

  /// The staff member who took this order at the counter. Null for an
  /// online order -- see [customerUser].
  _i3.AppUserRecordTable? _staffUser;

  late final _i1.ColumnUuid customerUserId;

  /// The customer who placed this order themselves, if it's an online
  /// order. This (not a separate "source" flag) is what distinguishes an
  /// online order from a counter one -- exactly one of [staffUser]/
  /// [customerUser] is ever set.
  _i3.AppUserRecordTable? _customerUser;

  /// When staff became aware of/processed this order. Set to [createdAt]
  /// itself for a counter order -- staff creating it in person *is*
  /// handling it -- so only an online order is ever actually null here,
  /// which is what makes a plain `handledAt == null` filter enough to
  /// drive both the staff notification badge and the Online Orders queue
  /// (see OnlineOrderManagementEndpoint.listUnhandled).
  late final _i1.ColumnDateTime handledAt;

  late final _i1.ColumnEnum<_i2.OrderStatus> status;

  /// A short, printable customer-facing sequence -- 1..100, wrapping back
  /// to 1 -- resetting every restaurant-local day. Distinct from `id`
  /// (which never resets and just keeps growing): this is what's called
  /// out to a customer and printed large on the ticket. See
  /// ticket_numbering.dart for how it's assigned.
  late final _i1.ColumnInt ticketNumber;

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

  _i3.AppUserRecordTable get customerUser {
    if (_customerUser != null) return _customerUser!;
    _customerUser = _i1.createRelationTable(
      relationFieldName: 'customerUser',
      field: OrderRecord.t.customerUserId,
      foreignField: _i3.AppUserRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AppUserRecordTable(tableRelation: foreignTableRelation),
    );
    return _customerUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    staffUserId,
    customerUserId,
    handledAt,
    status,
    ticketNumber,
    subtotalMillimes,
    totalMillimes,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'staffUser') {
      return staffUser;
    }
    if (relationField == 'customerUser') {
      return customerUser;
    }
    return null;
  }
}

class OrderRecordInclude extends _i1.IncludeObject {
  OrderRecordInclude._({
    _i3.AppUserRecordInclude? staffUser,
    _i3.AppUserRecordInclude? customerUser,
  }) {
    _staffUser = staffUser;
    _customerUser = customerUser;
  }

  _i3.AppUserRecordInclude? _staffUser;

  _i3.AppUserRecordInclude? _customerUser;

  @override
  Map<String, _i1.Include?> get includes => {
    'staffUser': _staffUser,
    'customerUser': _customerUser,
  };

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

  final detachRow = const OrderRecordDetachRowRepository._();

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

  /// Creates a relation between the given [OrderRecord] and [AppUserRecord]
  /// by setting the [OrderRecord]'s foreign key `customerUserId` to refer to the [AppUserRecord].
  Future<void> customerUser(
    _i1.DatabaseSession session,
    OrderRecord orderRecord,
    _i3.AppUserRecord customerUser, {
    _i1.Transaction? transaction,
  }) async {
    if (orderRecord.id == null) {
      throw ArgumentError.notNull('orderRecord.id');
    }
    if (customerUser.id == null) {
      throw ArgumentError.notNull('customerUser.id');
    }

    var $orderRecord = orderRecord.copyWith(customerUserId: customerUser.id);
    await session.db.updateRow<OrderRecord>(
      $orderRecord,
      columns: [OrderRecord.t.customerUserId],
      transaction: transaction,
    );
  }
}

class OrderRecordDetachRowRepository {
  const OrderRecordDetachRowRepository._();

  /// Detaches the relation between this [OrderRecord] and the [AppUserRecord] set in `staffUser`
  /// by setting the [OrderRecord]'s foreign key `staffUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> staffUser(
    _i1.DatabaseSession session,
    OrderRecord orderRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (orderRecord.id == null) {
      throw ArgumentError.notNull('orderRecord.id');
    }

    var $orderRecord = orderRecord.copyWith(staffUserId: null);
    await session.db.updateRow<OrderRecord>(
      $orderRecord,
      columns: [OrderRecord.t.staffUserId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [OrderRecord] and the [AppUserRecord] set in `customerUser`
  /// by setting the [OrderRecord]'s foreign key `customerUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> customerUser(
    _i1.DatabaseSession session,
    OrderRecord orderRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (orderRecord.id == null) {
      throw ArgumentError.notNull('orderRecord.id');
    }

    var $orderRecord = orderRecord.copyWith(customerUserId: null);
    await session.db.updateRow<OrderRecord>(
      $orderRecord,
      columns: [OrderRecord.t.customerUserId],
      transaction: transaction,
    );
  }
}
