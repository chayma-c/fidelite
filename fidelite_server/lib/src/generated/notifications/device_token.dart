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
import 'package:fidelite_server/src/generated/protocol.dart' as _i3;

/// A staff member's current FCM push token -- one row per user, enforced
/// at the application level (see device_token_endpoint.dart) the same way
/// ShopStatusRecord's singleton row is, rather than a DB constraint. A
/// fresh token (reinstall, app data cleared, rotation) overwrites the old
/// one; the previous device simply stops receiving pushes, which is the
/// right behavior for what's effectively one shared staff tablet.
abstract class DeviceTokenRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DeviceTokenRecord._({
    this.id,
    required this.userId,
    this.user,
    required this.fcmToken,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory DeviceTokenRecord({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required String fcmToken,
    DateTime? updatedAt,
  }) = _DeviceTokenRecordImpl;

  factory DeviceTokenRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceTokenRecord(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AppUserRecord>(
              jsonSerialization['user'],
            ),
      fcmToken: jsonSerialization['fcmToken'] as String,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DeviceTokenRecordTable();

  static const db = DeviceTokenRecordRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  _i2.AppUserRecord? user;

  String fcmToken;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DeviceTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceTokenRecord copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AppUserRecord? user,
    String? fcmToken,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceTokenRecord',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'fcmToken': fcmToken,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DeviceTokenRecord',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'fcmToken': fcmToken,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DeviceTokenRecordInclude include({_i2.AppUserRecordInclude? user}) {
    return DeviceTokenRecordInclude._(user: user);
  }

  static DeviceTokenRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<DeviceTokenRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceTokenRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceTokenRecordTable>? orderByList,
    DeviceTokenRecordInclude? include,
  }) {
    return DeviceTokenRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceTokenRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DeviceTokenRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceTokenRecordImpl extends DeviceTokenRecord {
  _DeviceTokenRecordImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required String fcmToken,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         fcmToken: fcmToken,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DeviceTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceTokenRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? fcmToken,
    DateTime? updatedAt,
  }) {
    return DeviceTokenRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AppUserRecord? ? user : this.user?.copyWith(),
      fcmToken: fcmToken ?? this.fcmToken,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DeviceTokenRecordUpdateTable
    extends _i1.UpdateTable<DeviceTokenRecordTable> {
  DeviceTokenRecordUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> fcmToken(String value) => _i1.ColumnValue(
    table.fcmToken,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class DeviceTokenRecordTable extends _i1.Table<int?> {
  DeviceTokenRecordTable({super.tableRelation})
    : super(tableName: 'device_token') {
    updateTable = DeviceTokenRecordUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    fcmToken = _i1.ColumnString(
      'fcmToken',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final DeviceTokenRecordUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.AppUserRecordTable? _user;

  late final _i1.ColumnString fcmToken;

  late final _i1.ColumnDateTime updatedAt;

  _i2.AppUserRecordTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: DeviceTokenRecord.t.userId,
      foreignField: _i2.AppUserRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AppUserRecordTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    fcmToken,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class DeviceTokenRecordInclude extends _i1.IncludeObject {
  DeviceTokenRecordInclude._({_i2.AppUserRecordInclude? user}) {
    _user = user;
  }

  _i2.AppUserRecordInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<int?> get table => DeviceTokenRecord.t;
}

class DeviceTokenRecordIncludeList extends _i1.IncludeList {
  DeviceTokenRecordIncludeList._({
    _i1.WhereExpressionBuilder<DeviceTokenRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DeviceTokenRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DeviceTokenRecord.t;
}

class DeviceTokenRecordRepository {
  const DeviceTokenRecordRepository._();

  final attachRow = const DeviceTokenRecordAttachRowRepository._();

  /// Returns a list of [DeviceTokenRecord]s matching the given query parameters.
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
  Future<List<DeviceTokenRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceTokenRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceTokenRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceTokenRecordTable>? orderByList,
    _i1.Transaction? transaction,
    DeviceTokenRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DeviceTokenRecord>(
      where: where?.call(DeviceTokenRecord.t),
      orderBy: orderBy?.call(DeviceTokenRecord.t),
      orderByList: orderByList?.call(DeviceTokenRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DeviceTokenRecord] matching the given query parameters.
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
  Future<DeviceTokenRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceTokenRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<DeviceTokenRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DeviceTokenRecordTable>? orderByList,
    _i1.Transaction? transaction,
    DeviceTokenRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DeviceTokenRecord>(
      where: where?.call(DeviceTokenRecord.t),
      orderBy: orderBy?.call(DeviceTokenRecord.t),
      orderByList: orderByList?.call(DeviceTokenRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DeviceTokenRecord] by its [id] or null if no such row exists.
  Future<DeviceTokenRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    DeviceTokenRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DeviceTokenRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DeviceTokenRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [DeviceTokenRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DeviceTokenRecord>> insert(
    _i1.DatabaseSession session,
    List<DeviceTokenRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DeviceTokenRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DeviceTokenRecord] and returns the inserted row.
  ///
  /// The returned [DeviceTokenRecord] will have its `id` field set.
  Future<DeviceTokenRecord> insertRow(
    _i1.DatabaseSession session,
    DeviceTokenRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DeviceTokenRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DeviceTokenRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DeviceTokenRecord>> update(
    _i1.DatabaseSession session,
    List<DeviceTokenRecord> rows, {
    _i1.ColumnSelections<DeviceTokenRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DeviceTokenRecord>(
      rows,
      columns: columns?.call(DeviceTokenRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceTokenRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DeviceTokenRecord> updateRow(
    _i1.DatabaseSession session,
    DeviceTokenRecord row, {
    _i1.ColumnSelections<DeviceTokenRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DeviceTokenRecord>(
      row,
      columns: columns?.call(DeviceTokenRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeviceTokenRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DeviceTokenRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DeviceTokenRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DeviceTokenRecord>(
      id,
      columnValues: columnValues(DeviceTokenRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DeviceTokenRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DeviceTokenRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DeviceTokenRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DeviceTokenRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DeviceTokenRecordTable>? orderBy,
    _i1.OrderByListBuilder<DeviceTokenRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DeviceTokenRecord>(
      columnValues: columnValues(DeviceTokenRecord.t.updateTable),
      where: where(DeviceTokenRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeviceTokenRecord.t),
      orderByList: orderByList?.call(DeviceTokenRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DeviceTokenRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DeviceTokenRecord>> delete(
    _i1.DatabaseSession session,
    List<DeviceTokenRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DeviceTokenRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DeviceTokenRecord].
  Future<DeviceTokenRecord> deleteRow(
    _i1.DatabaseSession session,
    DeviceTokenRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DeviceTokenRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DeviceTokenRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceTokenRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DeviceTokenRecord>(
      where: where(DeviceTokenRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DeviceTokenRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DeviceTokenRecord>(
      where: where?.call(DeviceTokenRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DeviceTokenRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DeviceTokenRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DeviceTokenRecord>(
      where: where(DeviceTokenRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DeviceTokenRecordAttachRowRepository {
  const DeviceTokenRecordAttachRowRepository._();

  /// Creates a relation between the given [DeviceTokenRecord] and [AppUserRecord]
  /// by setting the [DeviceTokenRecord]'s foreign key `userId` to refer to the [AppUserRecord].
  Future<void> user(
    _i1.DatabaseSession session,
    DeviceTokenRecord deviceTokenRecord,
    _i2.AppUserRecord user, {
    _i1.Transaction? transaction,
  }) async {
    if (deviceTokenRecord.id == null) {
      throw ArgumentError.notNull('deviceTokenRecord.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $deviceTokenRecord = deviceTokenRecord.copyWith(userId: user.id);
    await session.db.updateRow<DeviceTokenRecord>(
      $deviceTokenRecord,
      columns: [DeviceTokenRecord.t.userId],
      transaction: transaction,
    );
  }
}
