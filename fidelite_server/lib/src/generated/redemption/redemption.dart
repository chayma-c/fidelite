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
import '../redemption/redemption_status.dart' as _i2;
import '../users/app_user.dart' as _i3;
import '../rewards/reward_item.dart' as _i4;
import 'package:fidelite_server/src/generated/protocol.dart' as _i5;

/// A completed reward redemption: [pointsCostSnapshot] was deducted from
/// [customerUser]'s cashback balance by [staffUser] scanning their wallet
/// QR. Snapshots the reward's name/cost at time of redemption so later
/// catalog edits never corrupt history.
abstract class RedemptionRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RedemptionRecord._({
    this.id,
    required this.customerUserId,
    this.customerUser,
    required this.staffUserId,
    this.staffUser,
    required this.rewardItemId,
    this.rewardItem,
    required this.rewardNameSnapshot,
    required this.pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  }) : status = status ?? _i2.RedemptionStatus.completed,
       createdAt = createdAt ?? DateTime.now();

  factory RedemptionRecord({
    int? id,
    required _i1.UuidValue customerUserId,
    _i3.AppUserRecord? customerUser,
    required _i1.UuidValue staffUserId,
    _i3.AppUserRecord? staffUser,
    required int rewardItemId,
    _i4.RewardItemRecord? rewardItem,
    required String rewardNameSnapshot,
    required int pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  }) = _RedemptionRecordImpl;

  factory RedemptionRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return RedemptionRecord(
      id: jsonSerialization['id'] as int?,
      customerUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['customerUserId'],
      ),
      customerUser: jsonSerialization['customerUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['customerUser'],
            ),
      staffUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['staffUserId'],
      ),
      staffUser: jsonSerialization['staffUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['staffUser'],
            ),
      rewardItemId: jsonSerialization['rewardItemId'] as int,
      rewardItem: jsonSerialization['rewardItem'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.RewardItemRecord>(
              jsonSerialization['rewardItem'],
            ),
      rewardNameSnapshot: jsonSerialization['rewardNameSnapshot'] as String,
      pointsCostSnapshot: jsonSerialization['pointsCostSnapshot'] as int,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.RedemptionStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RedemptionRecordTable();

  static const db = RedemptionRecordRepository._();

  @override
  int? id;

  _i1.UuidValue customerUserId;

  _i3.AppUserRecord? customerUser;

  _i1.UuidValue staffUserId;

  _i3.AppUserRecord? staffUser;

  int rewardItemId;

  _i4.RewardItemRecord? rewardItem;

  String rewardNameSnapshot;

  int pointsCostSnapshot;

  _i2.RedemptionStatus status;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RedemptionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RedemptionRecord copyWith({
    int? id,
    _i1.UuidValue? customerUserId,
    _i3.AppUserRecord? customerUser,
    _i1.UuidValue? staffUserId,
    _i3.AppUserRecord? staffUser,
    int? rewardItemId,
    _i4.RewardItemRecord? rewardItem,
    String? rewardNameSnapshot,
    int? pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RedemptionRecord',
      if (id != null) 'id': id,
      'customerUserId': customerUserId.toJson(),
      if (customerUser != null) 'customerUser': customerUser?.toJson(),
      'staffUserId': staffUserId.toJson(),
      if (staffUser != null) 'staffUser': staffUser?.toJson(),
      'rewardItemId': rewardItemId,
      if (rewardItem != null) 'rewardItem': rewardItem?.toJson(),
      'rewardNameSnapshot': rewardNameSnapshot,
      'pointsCostSnapshot': pointsCostSnapshot,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RedemptionRecord',
      if (id != null) 'id': id,
      'customerUserId': customerUserId.toJson(),
      if (customerUser != null)
        'customerUser': customerUser?.toJsonForProtocol(),
      'staffUserId': staffUserId.toJson(),
      if (staffUser != null) 'staffUser': staffUser?.toJsonForProtocol(),
      'rewardItemId': rewardItemId,
      if (rewardItem != null) 'rewardItem': rewardItem?.toJsonForProtocol(),
      'rewardNameSnapshot': rewardNameSnapshot,
      'pointsCostSnapshot': pointsCostSnapshot,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static RedemptionRecordInclude include({
    _i3.AppUserRecordInclude? customerUser,
    _i3.AppUserRecordInclude? staffUser,
    _i4.RewardItemRecordInclude? rewardItem,
  }) {
    return RedemptionRecordInclude._(
      customerUser: customerUser,
      staffUser: staffUser,
      rewardItem: rewardItem,
    );
  }

  static RedemptionRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<RedemptionRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RedemptionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RedemptionRecordTable>? orderByList,
    RedemptionRecordInclude? include,
  }) {
    return RedemptionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RedemptionRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RedemptionRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RedemptionRecordImpl extends RedemptionRecord {
  _RedemptionRecordImpl({
    int? id,
    required _i1.UuidValue customerUserId,
    _i3.AppUserRecord? customerUser,
    required _i1.UuidValue staffUserId,
    _i3.AppUserRecord? staffUser,
    required int rewardItemId,
    _i4.RewardItemRecord? rewardItem,
    required String rewardNameSnapshot,
    required int pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         customerUserId: customerUserId,
         customerUser: customerUser,
         staffUserId: staffUserId,
         staffUser: staffUser,
         rewardItemId: rewardItemId,
         rewardItem: rewardItem,
         rewardNameSnapshot: rewardNameSnapshot,
         pointsCostSnapshot: pointsCostSnapshot,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RedemptionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RedemptionRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? customerUserId,
    Object? customerUser = _Undefined,
    _i1.UuidValue? staffUserId,
    Object? staffUser = _Undefined,
    int? rewardItemId,
    Object? rewardItem = _Undefined,
    String? rewardNameSnapshot,
    int? pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  }) {
    return RedemptionRecord(
      id: id is int? ? id : this.id,
      customerUserId: customerUserId ?? this.customerUserId,
      customerUser: customerUser is _i3.AppUserRecord?
          ? customerUser
          : this.customerUser?.copyWith(),
      staffUserId: staffUserId ?? this.staffUserId,
      staffUser: staffUser is _i3.AppUserRecord?
          ? staffUser
          : this.staffUser?.copyWith(),
      rewardItemId: rewardItemId ?? this.rewardItemId,
      rewardItem: rewardItem is _i4.RewardItemRecord?
          ? rewardItem
          : this.rewardItem?.copyWith(),
      rewardNameSnapshot: rewardNameSnapshot ?? this.rewardNameSnapshot,
      pointsCostSnapshot: pointsCostSnapshot ?? this.pointsCostSnapshot,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RedemptionRecordUpdateTable
    extends _i1.UpdateTable<RedemptionRecordTable> {
  RedemptionRecordUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> customerUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.customerUserId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> staffUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.staffUserId,
    value,
  );

  _i1.ColumnValue<int, int> rewardItemId(int value) => _i1.ColumnValue(
    table.rewardItemId,
    value,
  );

  _i1.ColumnValue<String, String> rewardNameSnapshot(String value) =>
      _i1.ColumnValue(
        table.rewardNameSnapshot,
        value,
      );

  _i1.ColumnValue<int, int> pointsCostSnapshot(int value) => _i1.ColumnValue(
    table.pointsCostSnapshot,
    value,
  );

  _i1.ColumnValue<_i2.RedemptionStatus, _i2.RedemptionStatus> status(
    _i2.RedemptionStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class RedemptionRecordTable extends _i1.Table<int?> {
  RedemptionRecordTable({super.tableRelation})
    : super(tableName: 'redemption') {
    updateTable = RedemptionRecordUpdateTable(this);
    customerUserId = _i1.ColumnUuid(
      'customerUserId',
      this,
    );
    staffUserId = _i1.ColumnUuid(
      'staffUserId',
      this,
    );
    rewardItemId = _i1.ColumnInt(
      'rewardItemId',
      this,
    );
    rewardNameSnapshot = _i1.ColumnString(
      'rewardNameSnapshot',
      this,
    );
    pointsCostSnapshot = _i1.ColumnInt(
      'pointsCostSnapshot',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RedemptionRecordUpdateTable updateTable;

  late final _i1.ColumnUuid customerUserId;

  _i3.AppUserRecordTable? _customerUser;

  late final _i1.ColumnUuid staffUserId;

  _i3.AppUserRecordTable? _staffUser;

  late final _i1.ColumnInt rewardItemId;

  _i4.RewardItemRecordTable? _rewardItem;

  late final _i1.ColumnString rewardNameSnapshot;

  late final _i1.ColumnInt pointsCostSnapshot;

  late final _i1.ColumnEnum<_i2.RedemptionStatus> status;

  late final _i1.ColumnDateTime createdAt;

  _i3.AppUserRecordTable get customerUser {
    if (_customerUser != null) return _customerUser!;
    _customerUser = _i1.createRelationTable(
      relationFieldName: 'customerUser',
      field: RedemptionRecord.t.customerUserId,
      foreignField: _i3.AppUserRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AppUserRecordTable(tableRelation: foreignTableRelation),
    );
    return _customerUser!;
  }

  _i3.AppUserRecordTable get staffUser {
    if (_staffUser != null) return _staffUser!;
    _staffUser = _i1.createRelationTable(
      relationFieldName: 'staffUser',
      field: RedemptionRecord.t.staffUserId,
      foreignField: _i3.AppUserRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AppUserRecordTable(tableRelation: foreignTableRelation),
    );
    return _staffUser!;
  }

  _i4.RewardItemRecordTable get rewardItem {
    if (_rewardItem != null) return _rewardItem!;
    _rewardItem = _i1.createRelationTable(
      relationFieldName: 'rewardItem',
      field: RedemptionRecord.t.rewardItemId,
      foreignField: _i4.RewardItemRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RewardItemRecordTable(tableRelation: foreignTableRelation),
    );
    return _rewardItem!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    customerUserId,
    staffUserId,
    rewardItemId,
    rewardNameSnapshot,
    pointsCostSnapshot,
    status,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'customerUser') {
      return customerUser;
    }
    if (relationField == 'staffUser') {
      return staffUser;
    }
    if (relationField == 'rewardItem') {
      return rewardItem;
    }
    return null;
  }
}

class RedemptionRecordInclude extends _i1.IncludeObject {
  RedemptionRecordInclude._({
    _i3.AppUserRecordInclude? customerUser,
    _i3.AppUserRecordInclude? staffUser,
    _i4.RewardItemRecordInclude? rewardItem,
  }) {
    _customerUser = customerUser;
    _staffUser = staffUser;
    _rewardItem = rewardItem;
  }

  _i3.AppUserRecordInclude? _customerUser;

  _i3.AppUserRecordInclude? _staffUser;

  _i4.RewardItemRecordInclude? _rewardItem;

  @override
  Map<String, _i1.Include?> get includes => {
    'customerUser': _customerUser,
    'staffUser': _staffUser,
    'rewardItem': _rewardItem,
  };

  @override
  _i1.Table<int?> get table => RedemptionRecord.t;
}

class RedemptionRecordIncludeList extends _i1.IncludeList {
  RedemptionRecordIncludeList._({
    _i1.WhereExpressionBuilder<RedemptionRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RedemptionRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RedemptionRecord.t;
}

class RedemptionRecordRepository {
  const RedemptionRecordRepository._();

  final attachRow = const RedemptionRecordAttachRowRepository._();

  /// Returns a list of [RedemptionRecord]s matching the given query parameters.
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
  Future<List<RedemptionRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RedemptionRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RedemptionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RedemptionRecordTable>? orderByList,
    _i1.Transaction? transaction,
    RedemptionRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RedemptionRecord>(
      where: where?.call(RedemptionRecord.t),
      orderBy: orderBy?.call(RedemptionRecord.t),
      orderByList: orderByList?.call(RedemptionRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RedemptionRecord] matching the given query parameters.
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
  Future<RedemptionRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RedemptionRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<RedemptionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RedemptionRecordTable>? orderByList,
    _i1.Transaction? transaction,
    RedemptionRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RedemptionRecord>(
      where: where?.call(RedemptionRecord.t),
      orderBy: orderBy?.call(RedemptionRecord.t),
      orderByList: orderByList?.call(RedemptionRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RedemptionRecord] by its [id] or null if no such row exists.
  Future<RedemptionRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    RedemptionRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RedemptionRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RedemptionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [RedemptionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RedemptionRecord>> insert(
    _i1.DatabaseSession session,
    List<RedemptionRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RedemptionRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RedemptionRecord] and returns the inserted row.
  ///
  /// The returned [RedemptionRecord] will have its `id` field set.
  Future<RedemptionRecord> insertRow(
    _i1.DatabaseSession session,
    RedemptionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RedemptionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RedemptionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RedemptionRecord>> update(
    _i1.DatabaseSession session,
    List<RedemptionRecord> rows, {
    _i1.ColumnSelections<RedemptionRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RedemptionRecord>(
      rows,
      columns: columns?.call(RedemptionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RedemptionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RedemptionRecord> updateRow(
    _i1.DatabaseSession session,
    RedemptionRecord row, {
    _i1.ColumnSelections<RedemptionRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RedemptionRecord>(
      row,
      columns: columns?.call(RedemptionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RedemptionRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RedemptionRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RedemptionRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RedemptionRecord>(
      id,
      columnValues: columnValues(RedemptionRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RedemptionRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RedemptionRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RedemptionRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<RedemptionRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RedemptionRecordTable>? orderBy,
    _i1.OrderByListBuilder<RedemptionRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RedemptionRecord>(
      columnValues: columnValues(RedemptionRecord.t.updateTable),
      where: where(RedemptionRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RedemptionRecord.t),
      orderByList: orderByList?.call(RedemptionRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RedemptionRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RedemptionRecord>> delete(
    _i1.DatabaseSession session,
    List<RedemptionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RedemptionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RedemptionRecord].
  Future<RedemptionRecord> deleteRow(
    _i1.DatabaseSession session,
    RedemptionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RedemptionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RedemptionRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RedemptionRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RedemptionRecord>(
      where: where(RedemptionRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RedemptionRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RedemptionRecord>(
      where: where?.call(RedemptionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RedemptionRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RedemptionRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RedemptionRecord>(
      where: where(RedemptionRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class RedemptionRecordAttachRowRepository {
  const RedemptionRecordAttachRowRepository._();

  /// Creates a relation between the given [RedemptionRecord] and [AppUserRecord]
  /// by setting the [RedemptionRecord]'s foreign key `customerUserId` to refer to the [AppUserRecord].
  Future<void> customerUser(
    _i1.DatabaseSession session,
    RedemptionRecord redemptionRecord,
    _i3.AppUserRecord customerUser, {
    _i1.Transaction? transaction,
  }) async {
    if (redemptionRecord.id == null) {
      throw ArgumentError.notNull('redemptionRecord.id');
    }
    if (customerUser.id == null) {
      throw ArgumentError.notNull('customerUser.id');
    }

    var $redemptionRecord = redemptionRecord.copyWith(
      customerUserId: customerUser.id,
    );
    await session.db.updateRow<RedemptionRecord>(
      $redemptionRecord,
      columns: [RedemptionRecord.t.customerUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RedemptionRecord] and [AppUserRecord]
  /// by setting the [RedemptionRecord]'s foreign key `staffUserId` to refer to the [AppUserRecord].
  Future<void> staffUser(
    _i1.DatabaseSession session,
    RedemptionRecord redemptionRecord,
    _i3.AppUserRecord staffUser, {
    _i1.Transaction? transaction,
  }) async {
    if (redemptionRecord.id == null) {
      throw ArgumentError.notNull('redemptionRecord.id');
    }
    if (staffUser.id == null) {
      throw ArgumentError.notNull('staffUser.id');
    }

    var $redemptionRecord = redemptionRecord.copyWith(
      staffUserId: staffUser.id,
    );
    await session.db.updateRow<RedemptionRecord>(
      $redemptionRecord,
      columns: [RedemptionRecord.t.staffUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RedemptionRecord] and [RewardItemRecord]
  /// by setting the [RedemptionRecord]'s foreign key `rewardItemId` to refer to the [RewardItemRecord].
  Future<void> rewardItem(
    _i1.DatabaseSession session,
    RedemptionRecord redemptionRecord,
    _i4.RewardItemRecord rewardItem, {
    _i1.Transaction? transaction,
  }) async {
    if (redemptionRecord.id == null) {
      throw ArgumentError.notNull('redemptionRecord.id');
    }
    if (rewardItem.id == null) {
      throw ArgumentError.notNull('rewardItem.id');
    }

    var $redemptionRecord = redemptionRecord.copyWith(
      rewardItemId: rewardItem.id,
    );
    await session.db.updateRow<RedemptionRecord>(
      $redemptionRecord,
      columns: [RedemptionRecord.t.rewardItemId],
      transaction: transaction,
    );
  }
}
