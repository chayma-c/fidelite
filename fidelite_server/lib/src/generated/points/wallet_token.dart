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
import '../redemption/redemption.dart' as _i3;
import 'package:fidelite_server/src/generated/protocol.dart' as _i4;

/// A short-lived, single-use token behind the customer's wallet QR (shown
/// on their phone, scanned by staff to redeem a reward). Short expiry here
/// is the actual defense (unlike OrderClaimTokenRecord) -- a static,
/// never-expiring wallet QR would be a screenshot/replay risk, so the
/// wallet screen re-issues a fresh token roughly every 60s while visible.
abstract class WalletTokenRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WalletTokenRecord._({
    this.id,
    required this.userId,
    this.user,
    required this.tokenHash,
    DateTime? issuedAt,
    required this.expiresAt,
    this.consumedAt,
    this.consumedByRedemptionId,
    this.consumedByRedemption,
  }) : issuedAt = issuedAt ?? DateTime.now();

  factory WalletTokenRecord({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required String tokenHash,
    DateTime? issuedAt,
    required DateTime expiresAt,
    DateTime? consumedAt,
    int? consumedByRedemptionId,
    _i3.RedemptionRecord? consumedByRedemption,
  }) = _WalletTokenRecordImpl;

  factory WalletTokenRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return WalletTokenRecord(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AppUserRecord>(
              jsonSerialization['user'],
            ),
      tokenHash: jsonSerialization['tokenHash'] as String,
      issuedAt: jsonSerialization['issuedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['issuedAt']),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      consumedAt: jsonSerialization['consumedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['consumedAt']),
      consumedByRedemptionId:
          jsonSerialization['consumedByRedemptionId'] as int?,
      consumedByRedemption: jsonSerialization['consumedByRedemption'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.RedemptionRecord>(
              jsonSerialization['consumedByRedemption'],
            ),
    );
  }

  static final t = WalletTokenRecordTable();

  static const db = WalletTokenRecordRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  _i2.AppUserRecord? user;

  String tokenHash;

  DateTime issuedAt;

  DateTime expiresAt;

  /// Left null (token stays valid) if a redemption attempt fails for a
  /// business reason (e.g. insufficient balance) rather than an invalid
  /// token -- lets the cashier immediately retry a cheaper reward against
  /// the same still-displayed QR.
  DateTime? consumedAt;

  int? consumedByRedemptionId;

  _i3.RedemptionRecord? consumedByRedemption;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WalletTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WalletTokenRecord copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AppUserRecord? user,
    String? tokenHash,
    DateTime? issuedAt,
    DateTime? expiresAt,
    DateTime? consumedAt,
    int? consumedByRedemptionId,
    _i3.RedemptionRecord? consumedByRedemption,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WalletTokenRecord',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'tokenHash': tokenHash,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (consumedAt != null) 'consumedAt': consumedAt?.toJson(),
      if (consumedByRedemptionId != null)
        'consumedByRedemptionId': consumedByRedemptionId,
      if (consumedByRedemption != null)
        'consumedByRedemption': consumedByRedemption?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WalletTokenRecord',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'tokenHash': tokenHash,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (consumedAt != null) 'consumedAt': consumedAt?.toJson(),
      if (consumedByRedemptionId != null)
        'consumedByRedemptionId': consumedByRedemptionId,
      if (consumedByRedemption != null)
        'consumedByRedemption': consumedByRedemption?.toJsonForProtocol(),
    };
  }

  static WalletTokenRecordInclude include({
    _i2.AppUserRecordInclude? user,
    _i3.RedemptionRecordInclude? consumedByRedemption,
  }) {
    return WalletTokenRecordInclude._(
      user: user,
      consumedByRedemption: consumedByRedemption,
    );
  }

  static WalletTokenRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<WalletTokenRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WalletTokenRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WalletTokenRecordTable>? orderByList,
    WalletTokenRecordInclude? include,
  }) {
    return WalletTokenRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WalletTokenRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WalletTokenRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WalletTokenRecordImpl extends WalletTokenRecord {
  _WalletTokenRecordImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required String tokenHash,
    DateTime? issuedAt,
    required DateTime expiresAt,
    DateTime? consumedAt,
    int? consumedByRedemptionId,
    _i3.RedemptionRecord? consumedByRedemption,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         tokenHash: tokenHash,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         consumedAt: consumedAt,
         consumedByRedemptionId: consumedByRedemptionId,
         consumedByRedemption: consumedByRedemption,
       );

  /// Returns a shallow copy of this [WalletTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WalletTokenRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? tokenHash,
    DateTime? issuedAt,
    DateTime? expiresAt,
    Object? consumedAt = _Undefined,
    Object? consumedByRedemptionId = _Undefined,
    Object? consumedByRedemption = _Undefined,
  }) {
    return WalletTokenRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AppUserRecord? ? user : this.user?.copyWith(),
      tokenHash: tokenHash ?? this.tokenHash,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      consumedAt: consumedAt is DateTime? ? consumedAt : this.consumedAt,
      consumedByRedemptionId: consumedByRedemptionId is int?
          ? consumedByRedemptionId
          : this.consumedByRedemptionId,
      consumedByRedemption: consumedByRedemption is _i3.RedemptionRecord?
          ? consumedByRedemption
          : this.consumedByRedemption?.copyWith(),
    );
  }
}

class WalletTokenRecordUpdateTable
    extends _i1.UpdateTable<WalletTokenRecordTable> {
  WalletTokenRecordUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> tokenHash(String value) => _i1.ColumnValue(
    table.tokenHash,
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

  _i1.ColumnValue<DateTime, DateTime> consumedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.consumedAt,
        value,
      );

  _i1.ColumnValue<int, int> consumedByRedemptionId(int? value) =>
      _i1.ColumnValue(
        table.consumedByRedemptionId,
        value,
      );
}

class WalletTokenRecordTable extends _i1.Table<int?> {
  WalletTokenRecordTable({super.tableRelation})
    : super(tableName: 'wallet_token') {
    updateTable = WalletTokenRecordUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    tokenHash = _i1.ColumnString(
      'tokenHash',
      this,
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
    consumedAt = _i1.ColumnDateTime(
      'consumedAt',
      this,
    );
    consumedByRedemptionId = _i1.ColumnInt(
      'consumedByRedemptionId',
      this,
    );
  }

  late final WalletTokenRecordUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.AppUserRecordTable? _user;

  late final _i1.ColumnString tokenHash;

  late final _i1.ColumnDateTime issuedAt;

  late final _i1.ColumnDateTime expiresAt;

  /// Left null (token stays valid) if a redemption attempt fails for a
  /// business reason (e.g. insufficient balance) rather than an invalid
  /// token -- lets the cashier immediately retry a cheaper reward against
  /// the same still-displayed QR.
  late final _i1.ColumnDateTime consumedAt;

  late final _i1.ColumnInt consumedByRedemptionId;

  _i3.RedemptionRecordTable? _consumedByRedemption;

  _i2.AppUserRecordTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: WalletTokenRecord.t.userId,
      foreignField: _i2.AppUserRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AppUserRecordTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.RedemptionRecordTable get consumedByRedemption {
    if (_consumedByRedemption != null) return _consumedByRedemption!;
    _consumedByRedemption = _i1.createRelationTable(
      relationFieldName: 'consumedByRedemption',
      field: WalletTokenRecord.t.consumedByRedemptionId,
      foreignField: _i3.RedemptionRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.RedemptionRecordTable(tableRelation: foreignTableRelation),
    );
    return _consumedByRedemption!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    tokenHash,
    issuedAt,
    expiresAt,
    consumedAt,
    consumedByRedemptionId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'consumedByRedemption') {
      return consumedByRedemption;
    }
    return null;
  }
}

class WalletTokenRecordInclude extends _i1.IncludeObject {
  WalletTokenRecordInclude._({
    _i2.AppUserRecordInclude? user,
    _i3.RedemptionRecordInclude? consumedByRedemption,
  }) {
    _user = user;
    _consumedByRedemption = consumedByRedemption;
  }

  _i2.AppUserRecordInclude? _user;

  _i3.RedemptionRecordInclude? _consumedByRedemption;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'consumedByRedemption': _consumedByRedemption,
  };

  @override
  _i1.Table<int?> get table => WalletTokenRecord.t;
}

class WalletTokenRecordIncludeList extends _i1.IncludeList {
  WalletTokenRecordIncludeList._({
    _i1.WhereExpressionBuilder<WalletTokenRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WalletTokenRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WalletTokenRecord.t;
}

class WalletTokenRecordRepository {
  const WalletTokenRecordRepository._();

  final attachRow = const WalletTokenRecordAttachRowRepository._();

  final detachRow = const WalletTokenRecordDetachRowRepository._();

  /// Returns a list of [WalletTokenRecord]s matching the given query parameters.
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
  Future<List<WalletTokenRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WalletTokenRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WalletTokenRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WalletTokenRecordTable>? orderByList,
    _i1.Transaction? transaction,
    WalletTokenRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WalletTokenRecord>(
      where: where?.call(WalletTokenRecord.t),
      orderBy: orderBy?.call(WalletTokenRecord.t),
      orderByList: orderByList?.call(WalletTokenRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WalletTokenRecord] matching the given query parameters.
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
  Future<WalletTokenRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WalletTokenRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<WalletTokenRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WalletTokenRecordTable>? orderByList,
    _i1.Transaction? transaction,
    WalletTokenRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WalletTokenRecord>(
      where: where?.call(WalletTokenRecord.t),
      orderBy: orderBy?.call(WalletTokenRecord.t),
      orderByList: orderByList?.call(WalletTokenRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WalletTokenRecord] by its [id] or null if no such row exists.
  Future<WalletTokenRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    WalletTokenRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WalletTokenRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WalletTokenRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [WalletTokenRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WalletTokenRecord>> insert(
    _i1.DatabaseSession session,
    List<WalletTokenRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WalletTokenRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WalletTokenRecord] and returns the inserted row.
  ///
  /// The returned [WalletTokenRecord] will have its `id` field set.
  Future<WalletTokenRecord> insertRow(
    _i1.DatabaseSession session,
    WalletTokenRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WalletTokenRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WalletTokenRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WalletTokenRecord>> update(
    _i1.DatabaseSession session,
    List<WalletTokenRecord> rows, {
    _i1.ColumnSelections<WalletTokenRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WalletTokenRecord>(
      rows,
      columns: columns?.call(WalletTokenRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WalletTokenRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WalletTokenRecord> updateRow(
    _i1.DatabaseSession session,
    WalletTokenRecord row, {
    _i1.ColumnSelections<WalletTokenRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WalletTokenRecord>(
      row,
      columns: columns?.call(WalletTokenRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WalletTokenRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WalletTokenRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WalletTokenRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WalletTokenRecord>(
      id,
      columnValues: columnValues(WalletTokenRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WalletTokenRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WalletTokenRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WalletTokenRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<WalletTokenRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WalletTokenRecordTable>? orderBy,
    _i1.OrderByListBuilder<WalletTokenRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WalletTokenRecord>(
      columnValues: columnValues(WalletTokenRecord.t.updateTable),
      where: where(WalletTokenRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WalletTokenRecord.t),
      orderByList: orderByList?.call(WalletTokenRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WalletTokenRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WalletTokenRecord>> delete(
    _i1.DatabaseSession session,
    List<WalletTokenRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WalletTokenRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WalletTokenRecord].
  Future<WalletTokenRecord> deleteRow(
    _i1.DatabaseSession session,
    WalletTokenRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WalletTokenRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WalletTokenRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WalletTokenRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WalletTokenRecord>(
      where: where(WalletTokenRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WalletTokenRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WalletTokenRecord>(
      where: where?.call(WalletTokenRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WalletTokenRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WalletTokenRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WalletTokenRecord>(
      where: where(WalletTokenRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class WalletTokenRecordAttachRowRepository {
  const WalletTokenRecordAttachRowRepository._();

  /// Creates a relation between the given [WalletTokenRecord] and [AppUserRecord]
  /// by setting the [WalletTokenRecord]'s foreign key `userId` to refer to the [AppUserRecord].
  Future<void> user(
    _i1.DatabaseSession session,
    WalletTokenRecord walletTokenRecord,
    _i2.AppUserRecord user, {
    _i1.Transaction? transaction,
  }) async {
    if (walletTokenRecord.id == null) {
      throw ArgumentError.notNull('walletTokenRecord.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $walletTokenRecord = walletTokenRecord.copyWith(userId: user.id);
    await session.db.updateRow<WalletTokenRecord>(
      $walletTokenRecord,
      columns: [WalletTokenRecord.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [WalletTokenRecord] and [RedemptionRecord]
  /// by setting the [WalletTokenRecord]'s foreign key `consumedByRedemptionId` to refer to the [RedemptionRecord].
  Future<void> consumedByRedemption(
    _i1.DatabaseSession session,
    WalletTokenRecord walletTokenRecord,
    _i3.RedemptionRecord consumedByRedemption, {
    _i1.Transaction? transaction,
  }) async {
    if (walletTokenRecord.id == null) {
      throw ArgumentError.notNull('walletTokenRecord.id');
    }
    if (consumedByRedemption.id == null) {
      throw ArgumentError.notNull('consumedByRedemption.id');
    }

    var $walletTokenRecord = walletTokenRecord.copyWith(
      consumedByRedemptionId: consumedByRedemption.id,
    );
    await session.db.updateRow<WalletTokenRecord>(
      $walletTokenRecord,
      columns: [WalletTokenRecord.t.consumedByRedemptionId],
      transaction: transaction,
    );
  }
}

class WalletTokenRecordDetachRowRepository {
  const WalletTokenRecordDetachRowRepository._();

  /// Detaches the relation between this [WalletTokenRecord] and the [RedemptionRecord] set in `consumedByRedemption`
  /// by setting the [WalletTokenRecord]'s foreign key `consumedByRedemptionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> consumedByRedemption(
    _i1.DatabaseSession session,
    WalletTokenRecord walletTokenRecord, {
    _i1.Transaction? transaction,
  }) async {
    if (walletTokenRecord.id == null) {
      throw ArgumentError.notNull('walletTokenRecord.id');
    }

    var $walletTokenRecord = walletTokenRecord.copyWith(
      consumedByRedemptionId: null,
    );
    await session.db.updateRow<WalletTokenRecord>(
      $walletTokenRecord,
      columns: [WalletTokenRecord.t.consumedByRedemptionId],
      transaction: transaction,
    );
  }
}
