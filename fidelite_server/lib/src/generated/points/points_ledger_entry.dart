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
import '../users/app_user.dart' as _i2;
import '../points/points_ledger_reason.dart' as _i3;
import '../orders/order.dart' as _i4;
import '../redemption/redemption.dart' as _i5;
import 'package:fidelite_server/src/generated/protocol.dart' as _i6;

/// An append-only record of a cashback balance change. The running balance
/// is always the sum of every entry for a user -- this table is the
/// source of truth, not a convenience cache alongside a separate mutable
/// balance column, so it's inherently auditable and reconcilable.
abstract class PointsLedgerEntryRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PointsLedgerEntryRecord._({
    this.id,
    required this.userId,
    this.user,
    required this.deltaMillimes,
    required this.reason,
    this.relatedOrderId,
    this.relatedOrder,
    this.relatedRedemptionId,
    this.relatedRedemption,
    required this.balanceAfterMillimes,
    required this.createdByUserId,
    this.createdByUser,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory PointsLedgerEntryRecord({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required int deltaMillimes,
    required _i3.PointsLedgerReason reason,
    int? relatedOrderId,
    _i4.OrderRecord? relatedOrder,
    int? relatedRedemptionId,
    _i5.RedemptionRecord? relatedRedemption,
    required int balanceAfterMillimes,
    required _i1.UuidValue createdByUserId,
    _i2.AppUserRecord? createdByUser,
    DateTime? createdAt,
  }) = _PointsLedgerEntryRecordImpl;

  factory PointsLedgerEntryRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PointsLedgerEntryRecord(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.AppUserRecord>(
              jsonSerialization['user'],
            ),
      deltaMillimes: jsonSerialization['deltaMillimes'] as int,
      reason: _i3.PointsLedgerReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
      relatedOrderId: jsonSerialization['relatedOrderId'] as int?,
      relatedOrder: jsonSerialization['relatedOrder'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.OrderRecord>(
              jsonSerialization['relatedOrder'],
            ),
      relatedRedemptionId: jsonSerialization['relatedRedemptionId'] as int?,
      relatedRedemption: jsonSerialization['relatedRedemption'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.RedemptionRecord>(
              jsonSerialization['relatedRedemption'],
            ),
      balanceAfterMillimes: jsonSerialization['balanceAfterMillimes'] as int,
      createdByUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdByUserId'],
      ),
      createdByUser: jsonSerialization['createdByUser'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.AppUserRecord>(
              jsonSerialization['createdByUser'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PointsLedgerEntryRecordTable();

  static const db = PointsLedgerEntryRecordRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  /// The customer whose balance this entry affects.
  _i2.AppUserRecord? user;

  /// In millimes, the same unit as order prices -- this is cashback, not
  /// an abstract points currency (8% of an order's total, confirmed by
  /// the owner). Positive = earned, negative = spent.
  int deltaMillimes;

  _i3.PointsLedgerReason reason;

  int? relatedOrderId;

  /// Set when [reason] is orderClaim.
  _i4.OrderRecord? relatedOrder;

  int? relatedRedemptionId;

  /// Set when [reason] is redemption.
  _i5.RedemptionRecord? relatedRedemption;

  /// Running balance immediately after this entry, in millimes.
  int balanceAfterMillimes;

  _i1.UuidValue createdByUserId;

  /// Who caused this entry -- the customer themselves for an order claim;
  /// the staff member for a redemption.
  _i2.AppUserRecord? createdByUser;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PointsLedgerEntryRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PointsLedgerEntryRecord copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AppUserRecord? user,
    int? deltaMillimes,
    _i3.PointsLedgerReason? reason,
    int? relatedOrderId,
    _i4.OrderRecord? relatedOrder,
    int? relatedRedemptionId,
    _i5.RedemptionRecord? relatedRedemption,
    int? balanceAfterMillimes,
    _i1.UuidValue? createdByUserId,
    _i2.AppUserRecord? createdByUser,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PointsLedgerEntryRecord',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'deltaMillimes': deltaMillimes,
      'reason': reason.toJson(),
      if (relatedOrderId != null) 'relatedOrderId': relatedOrderId,
      if (relatedOrder != null) 'relatedOrder': relatedOrder?.toJson(),
      if (relatedRedemptionId != null)
        'relatedRedemptionId': relatedRedemptionId,
      if (relatedRedemption != null)
        'relatedRedemption': relatedRedemption?.toJson(),
      'balanceAfterMillimes': balanceAfterMillimes,
      'createdByUserId': createdByUserId.toJson(),
      if (createdByUser != null) 'createdByUser': createdByUser?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PointsLedgerEntryRecord',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'deltaMillimes': deltaMillimes,
      'reason': reason.toJson(),
      if (relatedOrderId != null) 'relatedOrderId': relatedOrderId,
      if (relatedOrder != null)
        'relatedOrder': relatedOrder?.toJsonForProtocol(),
      if (relatedRedemptionId != null)
        'relatedRedemptionId': relatedRedemptionId,
      if (relatedRedemption != null)
        'relatedRedemption': relatedRedemption?.toJsonForProtocol(),
      'balanceAfterMillimes': balanceAfterMillimes,
      'createdByUserId': createdByUserId.toJson(),
      if (createdByUser != null)
        'createdByUser': createdByUser?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static PointsLedgerEntryRecordInclude include({
    _i2.AppUserRecordInclude? user,
    _i4.OrderRecordInclude? relatedOrder,
    _i5.RedemptionRecordInclude? relatedRedemption,
    _i2.AppUserRecordInclude? createdByUser,
  }) {
    return PointsLedgerEntryRecordInclude._(
      user: user,
      relatedOrder: relatedOrder,
      relatedRedemption: relatedRedemption,
      createdByUser: createdByUser,
    );
  }

  static PointsLedgerEntryRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<PointsLedgerEntryRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PointsLedgerEntryRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PointsLedgerEntryRecordTable>? orderByList,
    PointsLedgerEntryRecordInclude? include,
  }) {
    return PointsLedgerEntryRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PointsLedgerEntryRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PointsLedgerEntryRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PointsLedgerEntryRecordImpl extends PointsLedgerEntryRecord {
  _PointsLedgerEntryRecordImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required int deltaMillimes,
    required _i3.PointsLedgerReason reason,
    int? relatedOrderId,
    _i4.OrderRecord? relatedOrder,
    int? relatedRedemptionId,
    _i5.RedemptionRecord? relatedRedemption,
    required int balanceAfterMillimes,
    required _i1.UuidValue createdByUserId,
    _i2.AppUserRecord? createdByUser,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         deltaMillimes: deltaMillimes,
         reason: reason,
         relatedOrderId: relatedOrderId,
         relatedOrder: relatedOrder,
         relatedRedemptionId: relatedRedemptionId,
         relatedRedemption: relatedRedemption,
         balanceAfterMillimes: balanceAfterMillimes,
         createdByUserId: createdByUserId,
         createdByUser: createdByUser,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PointsLedgerEntryRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PointsLedgerEntryRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    int? deltaMillimes,
    _i3.PointsLedgerReason? reason,
    Object? relatedOrderId = _Undefined,
    Object? relatedOrder = _Undefined,
    Object? relatedRedemptionId = _Undefined,
    Object? relatedRedemption = _Undefined,
    int? balanceAfterMillimes,
    _i1.UuidValue? createdByUserId,
    Object? createdByUser = _Undefined,
    DateTime? createdAt,
  }) {
    return PointsLedgerEntryRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AppUserRecord? ? user : this.user?.copyWith(),
      deltaMillimes: deltaMillimes ?? this.deltaMillimes,
      reason: reason ?? this.reason,
      relatedOrderId: relatedOrderId is int?
          ? relatedOrderId
          : this.relatedOrderId,
      relatedOrder: relatedOrder is _i4.OrderRecord?
          ? relatedOrder
          : this.relatedOrder?.copyWith(),
      relatedRedemptionId: relatedRedemptionId is int?
          ? relatedRedemptionId
          : this.relatedRedemptionId,
      relatedRedemption: relatedRedemption is _i5.RedemptionRecord?
          ? relatedRedemption
          : this.relatedRedemption?.copyWith(),
      balanceAfterMillimes: balanceAfterMillimes ?? this.balanceAfterMillimes,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdByUser: createdByUser is _i2.AppUserRecord?
          ? createdByUser
          : this.createdByUser?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PointsLedgerEntryRecordUpdateTable
    extends _i1.UpdateTable<PointsLedgerEntryRecordTable> {
  PointsLedgerEntryRecordUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<int, int> deltaMillimes(int value) => _i1.ColumnValue(
    table.deltaMillimes,
    value,
  );

  _i1.ColumnValue<_i3.PointsLedgerReason, _i3.PointsLedgerReason> reason(
    _i3.PointsLedgerReason value,
  ) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<int, int> relatedOrderId(int? value) => _i1.ColumnValue(
    table.relatedOrderId,
    value,
  );

  _i1.ColumnValue<int, int> relatedRedemptionId(int? value) => _i1.ColumnValue(
    table.relatedRedemptionId,
    value,
  );

  _i1.ColumnValue<int, int> balanceAfterMillimes(int value) => _i1.ColumnValue(
    table.balanceAfterMillimes,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> createdByUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.createdByUserId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class PointsLedgerEntryRecordTable extends _i1.Table<int?> {
  PointsLedgerEntryRecordTable({super.tableRelation})
    : super(tableName: 'points_ledger_entry') {
    updateTable = PointsLedgerEntryRecordUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    deltaMillimes = _i1.ColumnInt(
      'deltaMillimes',
      this,
    );
    reason = _i1.ColumnEnum(
      'reason',
      this,
      _i1.EnumSerialization.byName,
    );
    relatedOrderId = _i1.ColumnInt(
      'relatedOrderId',
      this,
    );
    relatedRedemptionId = _i1.ColumnInt(
      'relatedRedemptionId',
      this,
    );
    balanceAfterMillimes = _i1.ColumnInt(
      'balanceAfterMillimes',
      this,
    );
    createdByUserId = _i1.ColumnUuid(
      'createdByUserId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final PointsLedgerEntryRecordUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  /// The customer whose balance this entry affects.
  _i2.AppUserRecordTable? _user;

  /// In millimes, the same unit as order prices -- this is cashback, not
  /// an abstract points currency (8% of an order's total, confirmed by
  /// the owner). Positive = earned, negative = spent.
  late final _i1.ColumnInt deltaMillimes;

  late final _i1.ColumnEnum<_i3.PointsLedgerReason> reason;

  late final _i1.ColumnInt relatedOrderId;

  /// Set when [reason] is orderClaim.
  _i4.OrderRecordTable? _relatedOrder;

  late final _i1.ColumnInt relatedRedemptionId;

  /// Set when [reason] is redemption.
  _i5.RedemptionRecordTable? _relatedRedemption;

  /// Running balance immediately after this entry, in millimes.
  late final _i1.ColumnInt balanceAfterMillimes;

  late final _i1.ColumnUuid createdByUserId;

  /// Who caused this entry -- the customer themselves for an order claim;
  /// the staff member for a redemption.
  _i2.AppUserRecordTable? _createdByUser;

  late final _i1.ColumnDateTime createdAt;

  _i2.AppUserRecordTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: PointsLedgerEntryRecord.t.userId,
      foreignField: _i2.AppUserRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AppUserRecordTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i4.OrderRecordTable get relatedOrder {
    if (_relatedOrder != null) return _relatedOrder!;
    _relatedOrder = _i1.createRelationTable(
      relationFieldName: 'relatedOrder',
      field: PointsLedgerEntryRecord.t.relatedOrderId,
      foreignField: _i4.OrderRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.OrderRecordTable(tableRelation: foreignTableRelation),
    );
    return _relatedOrder!;
  }

  _i5.RedemptionRecordTable get relatedRedemption {
    if (_relatedRedemption != null) return _relatedRedemption!;
    _relatedRedemption = _i1.createRelationTable(
      relationFieldName: 'relatedRedemption',
      field: PointsLedgerEntryRecord.t.relatedRedemptionId,
      foreignField: _i5.RedemptionRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.RedemptionRecordTable(tableRelation: foreignTableRelation),
    );
    return _relatedRedemption!;
  }

  _i2.AppUserRecordTable get createdByUser {
    if (_createdByUser != null) return _createdByUser!;
    _createdByUser = _i1.createRelationTable(
      relationFieldName: 'createdByUser',
      field: PointsLedgerEntryRecord.t.createdByUserId,
      foreignField: _i2.AppUserRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AppUserRecordTable(tableRelation: foreignTableRelation),
    );
    return _createdByUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    deltaMillimes,
    reason,
    relatedOrderId,
    relatedRedemptionId,
    balanceAfterMillimes,
    createdByUserId,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'relatedOrder') {
      return relatedOrder;
    }
    if (relationField == 'relatedRedemption') {
      return relatedRedemption;
    }
    if (relationField == 'createdByUser') {
      return createdByUser;
    }
    return null;
  }
}

class PointsLedgerEntryRecordInclude extends _i1.IncludeObject {
  PointsLedgerEntryRecordInclude._({
    _i2.AppUserRecordInclude? user,
    _i4.OrderRecordInclude? relatedOrder,
    _i5.RedemptionRecordInclude? relatedRedemption,
    _i2.AppUserRecordInclude? createdByUser,
  }) {
    _user = user;
    _relatedOrder = relatedOrder;
    _relatedRedemption = relatedRedemption;
    _createdByUser = createdByUser;
  }

  _i2.AppUserRecordInclude? _user;

  _i4.OrderRecordInclude? _relatedOrder;

  _i5.RedemptionRecordInclude? _relatedRedemption;

  _i2.AppUserRecordInclude? _createdByUser;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'relatedOrder': _relatedOrder,
    'relatedRedemption': _relatedRedemption,
    'createdByUser': _createdByUser,
  };

  @override
  _i1.Table<int?> get table => PointsLedgerEntryRecord.t;
}

class PointsLedgerEntryRecordIncludeList extends _i1.IncludeList {
  PointsLedgerEntryRecordIncludeList._({
    _i1.WhereExpressionBuilder<PointsLedgerEntryRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PointsLedgerEntryRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PointsLedgerEntryRecord.t;
}

class PointsLedgerEntryRecordRepository {
  const PointsLedgerEntryRecordRepository._();

  final attachRow = const PointsLedgerEntryRecordAttachRowRepository._();

  final detachRow = const PointsLedgerEntryRecordDetachRowRepository._();

  /// Returns a list of [PointsLedgerEntryRecord]s matching the given query parameters.
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
  Future<List<PointsLedgerEntryRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PointsLedgerEntryRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PointsLedgerEntryRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PointsLedgerEntryRecordTable>? orderByList,
    _i1.Transaction? transaction,
    PointsLedgerEntryRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PointsLedgerEntryRecord>(
      where: where?.call(PointsLedgerEntryRecord.t),
      orderBy: orderBy?.call(PointsLedgerEntryRecord.t),
      orderByList: orderByList?.call(PointsLedgerEntryRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PointsLedgerEntryRecord] matching the given query parameters.
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
  Future<PointsLedgerEntryRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PointsLedgerEntryRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<PointsLedgerEntryRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PointsLedgerEntryRecordTable>? orderByList,
    _i1.Transaction? transaction,
    PointsLedgerEntryRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PointsLedgerEntryRecord>(
      where: where?.call(PointsLedgerEntryRecord.t),
      orderBy: orderBy?.call(PointsLedgerEntryRecord.t),
      orderByList: orderByList?.call(PointsLedgerEntryRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PointsLedgerEntryRecord] by its [id] or null if no such row exists.
  Future<PointsLedgerEntryRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    PointsLedgerEntryRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PointsLedgerEntryRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PointsLedgerEntryRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [PointsLedgerEntryRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PointsLedgerEntryRecord>> insert(
    _i1.DatabaseSession session,
    List<PointsLedgerEntryRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PointsLedgerEntryRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PointsLedgerEntryRecord] and returns the inserted row.
  ///
  /// The returned [PointsLedgerEntryRecord] will have its `id` field set.
  Future<PointsLedgerEntryRecord> insertRow(
    _i1.DatabaseSession session,
    PointsLedgerEntryRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PointsLedgerEntryRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PointsLedgerEntryRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PointsLedgerEntryRecord>> update(
    _i1.DatabaseSession session,
    List<PointsLedgerEntryRecord> rows, {
    _i1.ColumnSelections<PointsLedgerEntryRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PointsLedgerEntryRecord>(
      rows,
      columns: columns?.call(PointsLedgerEntryRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PointsLedgerEntryRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PointsLedgerEntryRecord> updateRow(
    _i1.DatabaseSession session,
    PointsLedgerEntryRecord row, {
    _i1.ColumnSelections<PointsLedgerEntryRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PointsLedgerEntryRecord>(
      row,
      columns: columns?.call(PointsLedgerEntryRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PointsLedgerEntryRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PointsLedgerEntryRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PointsLedgerEntryRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PointsLedgerEntryRecord>(
      id,
      columnValues: columnValues(PointsLedgerEntryRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PointsLedgerEntryRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PointsLedgerEntryRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PointsLedgerEntryRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PointsLedgerEntryRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PointsLedgerEntryRecordTable>? orderBy,
    _i1.OrderByListBuilder<PointsLedgerEntryRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PointsLedgerEntryRecord>(
      columnValues: columnValues(PointsLedgerEntryRecord.t.updateTable),
      where: where(PointsLedgerEntryRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PointsLedgerEntryRecord.t),
      orderByList: orderByList?.call(PointsLedgerEntryRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PointsLedgerEntryRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PointsLedgerEntryRecord>> delete(
    _i1.DatabaseSession session,
    List<PointsLedgerEntryRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PointsLedgerEntryRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PointsLedgerEntryRecord].
  Future<PointsLedgerEntryRecord> deleteRow(
    _i1.DatabaseSession session,
    PointsLedgerEntryRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PointsLedgerEntryRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PointsLedgerEntryRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PointsLedgerEntryRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PointsLedgerEntryRecord>(
      where: where(PointsLedgerEntryRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PointsLedgerEntryRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PointsLedgerEntryRecord>(
      where: where?.call(PointsLedgerEntryRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PointsLedgerEntryRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PointsLedgerEntryRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PointsLedgerEntryRecord>(
      where: where(PointsLedgerEntryRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PointsLedgerEntryRecordAttachRowRepository {
  const PointsLedgerEntryRecordAttachRowRepository._();

  /// Creates a relation between the given [PointsLedgerEntryRecord] and [AppUserRecord]
  /// by setting the [PointsLedgerEntryRecord]'s foreign key `userId` to refer to the [AppUserRecord].
  Future<void> user(
    _i1.DatabaseSession session,
    PointsLedgerEntryRecord pointsLedgerEntryRecord,
    _i2.AppUserRecord user, {
    _i1.Transaction? transaction,
  }) async {
    if (pointsLedgerEntryRecord.id == null) {
      throw ArgumentError.notNull('pointsLedgerEntryRecord.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $pointsLedgerEntryRecord = pointsLedgerEntryRecord.copyWith(
      userId: user.id,
    );
    await session.db.updateRow<PointsLedgerEntryRecord>(
      $pointsLedgerEntryRecord,
      columns: [PointsLedgerEntryRecord.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PointsLedgerEntryRecord] and [OrderRecord]
  /// by setting the [PointsLedgerEntryRecord]'s foreign key `relatedOrderId` to refer to the [OrderRecord].
  Future<void> relatedOrder(
    _i1.DatabaseSession session,
    PointsLedgerEntryRecord pointsLedgerEntryRecord,
    _i4.OrderRecord relatedOrder, {
    _i1.Transaction? transaction,
  }) async {
    if (pointsLedgerEntryRecord.id == null) {
      throw ArgumentError.notNull('pointsLedgerEntryRecord.id');
    }
    if (relatedOrder.id == null) {
      throw ArgumentError.notNull('relatedOrder.id');
    }

    var $pointsLedgerEntryRecord = pointsLedgerEntryRecord.copyWith(
      relatedOrderId: relatedOrder.id,
    );
    await session.db.updateRow<PointsLedgerEntryRecord>(
      $pointsLedgerEntryRecord,
      columns: [PointsLedgerEntryRecord.t.relatedOrderId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PointsLedgerEntryRecord] and [RedemptionRecord]
  /// by setting the [PointsLedgerEntryRecord]'s foreign key `relatedRedemptionId` to refer to the [RedemptionRecord].
  Future<void> relatedRedemption(
    _i1.DatabaseSession session,
    PointsLedgerEntryRecord pointsLedgerEntryRecord,
    _i5.RedemptionRecord relatedRedemption, {
    _i1.Transaction? transaction,
  }) async {
    if (pointsLedgerEntryRecord.id == null) {
      throw ArgumentError.notNull('pointsLedgerEntryRecord.id');
    }
    if (relatedRedemption.id == null) {
      throw ArgumentError.notNull('relatedRedemption.id');
    }

    var $pointsLedgerEntryRecord = pointsLedgerEntryRecord.copyWith(
      relatedRedemptionId: relatedRedemption.id,
    );
    await session.db.updateRow<PointsLedgerEntryRecord>(
      $pointsLedgerEntryRecord,
      columns: [PointsLedgerEntryRecord.t.relatedRedemptionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PointsLedgerEntryRecord] and [AppUserRecord]
  /// by setting the [PointsLedgerEntryRecord]'s foreign key `createdByUserId` to refer to the [AppUserRecord].
  Future<void> createdByUser(
    _i1.DatabaseSession session,
    PointsLedgerEntryRecord pointsLedgerEntryRecord,
    _i2.AppUserRecord createdByUser, {
    _i1.Transaction? transaction,
  }) async {
    if (pointsLedgerEntryRecord.id == null) {
      throw ArgumentError.notNull('pointsLedgerEntryRecord.id');
    }
    if (createdByUser.id == null) {
      throw ArgumentError.notNull('createdByUser.id');
    }

    var $pointsLedgerEntryRecord = pointsLedgerEntryRecord.copyWith(
      createdByUserId: createdByUser.id,
    );
    await session.db.updateRow<PointsLedgerEntryRecord>(
      $pointsLedgerEntryRecord,
      columns: [PointsLedgerEntryRecord.t.createdByUserId],
      transaction: transaction,
    );
  }
}

class PointsLedgerEntryRecordDetachRowRepository {
  const PointsLedgerEntryRecordDetachRowRepository._();

  /// Detaches the relation between this [PointsLedgerEntryRecord] and the [OrderRecord] set in `relatedOrder`
  /// by setting the [PointsLedgerEntryRecord]'s foreign key `relatedOrderId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> relatedOrder(
    _i1.DatabaseSession session,
    PointsLedgerEntryRecord pointsLedgerEntryRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (pointsLedgerEntryRecord.id == null) {
      throw ArgumentError.notNull('pointsLedgerEntryRecord.id');
    }

    var $pointsLedgerEntryRecord = pointsLedgerEntryRecord.copyWith(
      relatedOrderId: null,
    );
    await session.db.updateRow<PointsLedgerEntryRecord>(
      $pointsLedgerEntryRecord,
      columns: [PointsLedgerEntryRecord.t.relatedOrderId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [PointsLedgerEntryRecord] and the [RedemptionRecord] set in `relatedRedemption`
  /// by setting the [PointsLedgerEntryRecord]'s foreign key `relatedRedemptionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> relatedRedemption(
    _i1.DatabaseSession session,
    PointsLedgerEntryRecord pointsLedgerEntryRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (pointsLedgerEntryRecord.id == null) {
      throw ArgumentError.notNull('pointsLedgerEntryRecord.id');
    }

    var $pointsLedgerEntryRecord = pointsLedgerEntryRecord.copyWith(
      relatedRedemptionId: null,
    );
    await session.db.updateRow<PointsLedgerEntryRecord>(
      $pointsLedgerEntryRecord,
      columns: [PointsLedgerEntryRecord.t.relatedRedemptionId],
      transaction: transaction,
    );
  }
}
