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
import '../points/claim_token_status.dart' as _i2;
import '../orders/order.dart' as _i3;
import '../users/app_user.dart' as _i4;
import 'package:fidelite_server/src/generated/protocol.dart' as _i5;

/// A single-use claim token for an order's points-earning QR. The raw
/// token is only ever returned once (at issuance, from
/// OrderEndpoint.submitOrder) -- only its hash is persisted here, so a
/// full DB dump can't be used to forge a claim. Single-use is enforced via
/// an atomic conditional UPDATE (see PointsClaimEndpoint.claimOrderPoints),
/// not by short expiry -- the generous [expiresAt] window below is just a
/// cleanup horizon, not the real defense.
abstract class OrderClaimTokenRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrderClaimTokenRecord._({
    this.id,
    required this.orderId,
    this.order,
    required this.tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    required this.expiresAt,
    this.claimedAt,
    this.claimedByUserId,
    this.claimedByUser,
  }) : status = status ?? _i2.ClaimTokenStatus.pending,
       issuedAt = issuedAt ?? DateTime.now();

  factory OrderClaimTokenRecord({
    int? id,
    required int orderId,
    _i3.OrderRecord? order,
    required String tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    required DateTime expiresAt,
    DateTime? claimedAt,
    _i1.UuidValue? claimedByUserId,
    _i4.AppUserRecord? claimedByUser,
  }) = _OrderClaimTokenRecordImpl;

  factory OrderClaimTokenRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OrderClaimTokenRecord(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      order: jsonSerialization['order'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.OrderRecord>(
              jsonSerialization['order'],
            ),
      tokenHash: jsonSerialization['tokenHash'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.ClaimTokenStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      issuedAt: jsonSerialization['issuedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['issuedAt']),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      claimedAt: jsonSerialization['claimedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['claimedAt']),
      claimedByUserId: jsonSerialization['claimedByUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['claimedByUserId'],
            ),
      claimedByUser: jsonSerialization['claimedByUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.AppUserRecord>(
              jsonSerialization['claimedByUser'],
            ),
    );
  }

  static final t = OrderClaimTokenRecordTable();

  static const db = OrderClaimTokenRecordRepository._();

  @override
  int? id;

  int orderId;

  _i3.OrderRecord? order;

  String tokenHash;

  _i2.ClaimTokenStatus status;

  DateTime issuedAt;

  DateTime expiresAt;

  DateTime? claimedAt;

  _i1.UuidValue? claimedByUserId;

  _i4.AppUserRecord? claimedByUser;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrderClaimTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderClaimTokenRecord copyWith({
    int? id,
    int? orderId,
    _i3.OrderRecord? order,
    String? tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    DateTime? expiresAt,
    DateTime? claimedAt,
    _i1.UuidValue? claimedByUserId,
    _i4.AppUserRecord? claimedByUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderClaimTokenRecord',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (order != null) 'order': order?.toJson(),
      'tokenHash': tokenHash,
      'status': status.toJson(),
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (claimedAt != null) 'claimedAt': claimedAt?.toJson(),
      if (claimedByUserId != null) 'claimedByUserId': claimedByUserId?.toJson(),
      if (claimedByUser != null) 'claimedByUser': claimedByUser?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderClaimTokenRecord',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (order != null) 'order': order?.toJsonForProtocol(),
      'tokenHash': tokenHash,
      'status': status.toJson(),
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (claimedAt != null) 'claimedAt': claimedAt?.toJson(),
      if (claimedByUserId != null) 'claimedByUserId': claimedByUserId?.toJson(),
      if (claimedByUser != null)
        'claimedByUser': claimedByUser?.toJsonForProtocol(),
    };
  }

  static OrderClaimTokenRecordInclude include({
    _i3.OrderRecordInclude? order,
    _i4.AppUserRecordInclude? claimedByUser,
  }) {
    return OrderClaimTokenRecordInclude._(
      order: order,
      claimedByUser: claimedByUser,
    );
  }

  static OrderClaimTokenRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderClaimTokenRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderClaimTokenRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderClaimTokenRecordTable>? orderByList,
    OrderClaimTokenRecordInclude? include,
  }) {
    return OrderClaimTokenRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderClaimTokenRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrderClaimTokenRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderClaimTokenRecordImpl extends OrderClaimTokenRecord {
  _OrderClaimTokenRecordImpl({
    int? id,
    required int orderId,
    _i3.OrderRecord? order,
    required String tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    required DateTime expiresAt,
    DateTime? claimedAt,
    _i1.UuidValue? claimedByUserId,
    _i4.AppUserRecord? claimedByUser,
  }) : super._(
         id: id,
         orderId: orderId,
         order: order,
         tokenHash: tokenHash,
         status: status,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         claimedAt: claimedAt,
         claimedByUserId: claimedByUserId,
         claimedByUser: claimedByUser,
       );

  /// Returns a shallow copy of this [OrderClaimTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderClaimTokenRecord copyWith({
    Object? id = _Undefined,
    int? orderId,
    Object? order = _Undefined,
    String? tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    DateTime? expiresAt,
    Object? claimedAt = _Undefined,
    Object? claimedByUserId = _Undefined,
    Object? claimedByUser = _Undefined,
  }) {
    return OrderClaimTokenRecord(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      order: order is _i3.OrderRecord? ? order : this.order?.copyWith(),
      tokenHash: tokenHash ?? this.tokenHash,
      status: status ?? this.status,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      claimedAt: claimedAt is DateTime? ? claimedAt : this.claimedAt,
      claimedByUserId: claimedByUserId is _i1.UuidValue?
          ? claimedByUserId
          : this.claimedByUserId,
      claimedByUser: claimedByUser is _i4.AppUserRecord?
          ? claimedByUser
          : this.claimedByUser?.copyWith(),
    );
  }
}

class OrderClaimTokenRecordUpdateTable
    extends _i1.UpdateTable<OrderClaimTokenRecordTable> {
  OrderClaimTokenRecordUpdateTable(super.table);

  _i1.ColumnValue<int, int> orderId(int value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<String, String> tokenHash(String value) => _i1.ColumnValue(
    table.tokenHash,
    value,
  );

  _i1.ColumnValue<_i2.ClaimTokenStatus, _i2.ClaimTokenStatus> status(
    _i2.ClaimTokenStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> issuedAt(DateTime value) =>
      _i1.ColumnValue(
        table.issuedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> claimedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.claimedAt,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> claimedByUserId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.claimedByUserId,
    value,
  );
}

class OrderClaimTokenRecordTable extends _i1.Table<int?> {
  OrderClaimTokenRecordTable({super.tableRelation})
    : super(tableName: 'order_claim_token') {
    updateTable = OrderClaimTokenRecordUpdateTable(this);
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    tokenHash = _i1.ColumnString(
      'tokenHash',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    issuedAt = _i1.ColumnDateTime(
      'issuedAt',
      this,
      hasDefault: true,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    claimedAt = _i1.ColumnDateTime(
      'claimedAt',
      this,
    );
    claimedByUserId = _i1.ColumnUuid(
      'claimedByUserId',
      this,
    );
  }

  late final OrderClaimTokenRecordUpdateTable updateTable;

  late final _i1.ColumnInt orderId;

  _i3.OrderRecordTable? _order;

  late final _i1.ColumnString tokenHash;

  late final _i1.ColumnEnum<_i2.ClaimTokenStatus> status;

  late final _i1.ColumnDateTime issuedAt;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnDateTime claimedAt;

  late final _i1.ColumnUuid claimedByUserId;

  _i4.AppUserRecordTable? _claimedByUser;

  _i3.OrderRecordTable get order {
    if (_order != null) return _order!;
    _order = _i1.createRelationTable(
      relationFieldName: 'order',
      field: OrderClaimTokenRecord.t.orderId,
      foreignField: _i3.OrderRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.OrderRecordTable(tableRelation: foreignTableRelation),
    );
    return _order!;
  }

  _i4.AppUserRecordTable get claimedByUser {
    if (_claimedByUser != null) return _claimedByUser!;
    _claimedByUser = _i1.createRelationTable(
      relationFieldName: 'claimedByUser',
      field: OrderClaimTokenRecord.t.claimedByUserId,
      foreignField: _i4.AppUserRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.AppUserRecordTable(tableRelation: foreignTableRelation),
    );
    return _claimedByUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    tokenHash,
    status,
    issuedAt,
    expiresAt,
    claimedAt,
    claimedByUserId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'order') {
      return order;
    }
    if (relationField == 'claimedByUser') {
      return claimedByUser;
    }
    return null;
  }
}

class OrderClaimTokenRecordInclude extends _i1.IncludeObject {
  OrderClaimTokenRecordInclude._({
    _i3.OrderRecordInclude? order,
    _i4.AppUserRecordInclude? claimedByUser,
  }) {
    _order = order;
    _claimedByUser = claimedByUser;
  }

  _i3.OrderRecordInclude? _order;

  _i4.AppUserRecordInclude? _claimedByUser;

  @override
  Map<String, _i1.Include?> get includes => {
    'order': _order,
    'claimedByUser': _claimedByUser,
  };

  @override
  _i1.Table<int?> get table => OrderClaimTokenRecord.t;
}

class OrderClaimTokenRecordIncludeList extends _i1.IncludeList {
  OrderClaimTokenRecordIncludeList._({
    _i1.WhereExpressionBuilder<OrderClaimTokenRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrderClaimTokenRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrderClaimTokenRecord.t;
}

class OrderClaimTokenRecordRepository {
  const OrderClaimTokenRecordRepository._();

  final attachRow = const OrderClaimTokenRecordAttachRowRepository._();

  final detachRow = const OrderClaimTokenRecordDetachRowRepository._();

  /// Returns a list of [OrderClaimTokenRecord]s matching the given query parameters.
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
  Future<List<OrderClaimTokenRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderClaimTokenRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderClaimTokenRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderClaimTokenRecordTable>? orderByList,
    _i1.Transaction? transaction,
    OrderClaimTokenRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OrderClaimTokenRecord>(
      where: where?.call(OrderClaimTokenRecord.t),
      orderBy: orderBy?.call(OrderClaimTokenRecord.t),
      orderByList: orderByList?.call(OrderClaimTokenRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OrderClaimTokenRecord] matching the given query parameters.
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
  Future<OrderClaimTokenRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderClaimTokenRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderClaimTokenRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderClaimTokenRecordTable>? orderByList,
    _i1.Transaction? transaction,
    OrderClaimTokenRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OrderClaimTokenRecord>(
      where: where?.call(OrderClaimTokenRecord.t),
      orderBy: orderBy?.call(OrderClaimTokenRecord.t),
      orderByList: orderByList?.call(OrderClaimTokenRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OrderClaimTokenRecord] by its [id] or null if no such row exists.
  Future<OrderClaimTokenRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    OrderClaimTokenRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OrderClaimTokenRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OrderClaimTokenRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [OrderClaimTokenRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OrderClaimTokenRecord>> insert(
    _i1.DatabaseSession session,
    List<OrderClaimTokenRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OrderClaimTokenRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OrderClaimTokenRecord] and returns the inserted row.
  ///
  /// The returned [OrderClaimTokenRecord] will have its `id` field set.
  Future<OrderClaimTokenRecord> insertRow(
    _i1.DatabaseSession session,
    OrderClaimTokenRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrderClaimTokenRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrderClaimTokenRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrderClaimTokenRecord>> update(
    _i1.DatabaseSession session,
    List<OrderClaimTokenRecord> rows, {
    _i1.ColumnSelections<OrderClaimTokenRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrderClaimTokenRecord>(
      rows,
      columns: columns?.call(OrderClaimTokenRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderClaimTokenRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrderClaimTokenRecord> updateRow(
    _i1.DatabaseSession session,
    OrderClaimTokenRecord row, {
    _i1.ColumnSelections<OrderClaimTokenRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrderClaimTokenRecord>(
      row,
      columns: columns?.call(OrderClaimTokenRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderClaimTokenRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrderClaimTokenRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderClaimTokenRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OrderClaimTokenRecord>(
      id,
      columnValues: columnValues(OrderClaimTokenRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrderClaimTokenRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OrderClaimTokenRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OrderClaimTokenRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<OrderClaimTokenRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderClaimTokenRecordTable>? orderBy,
    _i1.OrderByListBuilder<OrderClaimTokenRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OrderClaimTokenRecord>(
      columnValues: columnValues(OrderClaimTokenRecord.t.updateTable),
      where: where(OrderClaimTokenRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderClaimTokenRecord.t),
      orderByList: orderByList?.call(OrderClaimTokenRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OrderClaimTokenRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrderClaimTokenRecord>> delete(
    _i1.DatabaseSession session,
    List<OrderClaimTokenRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrderClaimTokenRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrderClaimTokenRecord].
  Future<OrderClaimTokenRecord> deleteRow(
    _i1.DatabaseSession session,
    OrderClaimTokenRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrderClaimTokenRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrderClaimTokenRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderClaimTokenRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrderClaimTokenRecord>(
      where: where(OrderClaimTokenRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderClaimTokenRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrderClaimTokenRecord>(
      where: where?.call(OrderClaimTokenRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OrderClaimTokenRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderClaimTokenRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OrderClaimTokenRecord>(
      where: where(OrderClaimTokenRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class OrderClaimTokenRecordAttachRowRepository {
  const OrderClaimTokenRecordAttachRowRepository._();

  /// Creates a relation between the given [OrderClaimTokenRecord] and [OrderRecord]
  /// by setting the [OrderClaimTokenRecord]'s foreign key `orderId` to refer to the [OrderRecord].
  Future<void> order(
    _i1.DatabaseSession session,
    OrderClaimTokenRecord orderClaimTokenRecord,
    _i3.OrderRecord order, {
    _i1.Transaction? transaction,
  }) async {
    if (orderClaimTokenRecord.id == null) {
      throw ArgumentError.notNull('orderClaimTokenRecord.id');
    }
    if (order.id == null) {
      throw ArgumentError.notNull('order.id');
    }

    var $orderClaimTokenRecord = orderClaimTokenRecord.copyWith(
      orderId: order.id,
    );
    await session.db.updateRow<OrderClaimTokenRecord>(
      $orderClaimTokenRecord,
      columns: [OrderClaimTokenRecord.t.orderId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [OrderClaimTokenRecord] and [AppUserRecord]
  /// by setting the [OrderClaimTokenRecord]'s foreign key `claimedByUserId` to refer to the [AppUserRecord].
  Future<void> claimedByUser(
    _i1.DatabaseSession session,
    OrderClaimTokenRecord orderClaimTokenRecord,
    _i4.AppUserRecord claimedByUser, {
    _i1.Transaction? transaction,
  }) async {
    if (orderClaimTokenRecord.id == null) {
      throw ArgumentError.notNull('orderClaimTokenRecord.id');
    }
    if (claimedByUser.id == null) {
      throw ArgumentError.notNull('claimedByUser.id');
    }

    var $orderClaimTokenRecord = orderClaimTokenRecord.copyWith(
      claimedByUserId: claimedByUser.id,
    );
    await session.db.updateRow<OrderClaimTokenRecord>(
      $orderClaimTokenRecord,
      columns: [OrderClaimTokenRecord.t.claimedByUserId],
      transaction: transaction,
    );
  }
}

class OrderClaimTokenRecordDetachRowRepository {
  const OrderClaimTokenRecordDetachRowRepository._();

  /// Detaches the relation between this [OrderClaimTokenRecord] and the [AppUserRecord] set in `claimedByUser`
  /// by setting the [OrderClaimTokenRecord]'s foreign key `claimedByUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> claimedByUser(
    _i1.DatabaseSession session,
    OrderClaimTokenRecord orderClaimTokenRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (orderClaimTokenRecord.id == null) {
      throw ArgumentError.notNull('orderClaimTokenRecord.id');
    }

    var $orderClaimTokenRecord = orderClaimTokenRecord.copyWith(
      claimedByUserId: null,
    );
    await session.db.updateRow<OrderClaimTokenRecord>(
      $orderClaimTokenRecord,
      columns: [OrderClaimTokenRecord.t.claimedByUserId],
      transaction: transaction,
    );
  }
}
