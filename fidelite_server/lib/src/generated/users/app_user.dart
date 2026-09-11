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
import 'package:fidelite_server/src/generated/protocol.dart' as _i2;

/// An app user, mirrored from Keycloak on login. Keycloak remains the only
/// identity provider and source of truth for credentials/roles per request
/// (see keycloak_authentication_handler.dart) — this table exists so other
/// records (orders, points ledger, redemptions) have something to relate to,
/// plus lightweight denormalized fields for convenience (e.g. an admin
/// listing "all customers" without calling out to Keycloak).
abstract class AppUserRecord
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  AppUserRecord._({
    this.id,
    required this.username,
    this.email,
    this.fullName,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppUserRecord({
    _i1.UuidValue? id,
    required String username,
    String? email,
    String? fullName,
    required List<String> roles,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AppUserRecordImpl;

  factory AppUserRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUserRecord(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      username: jsonSerialization['username'] as String,
      email: jsonSerialization['email'] as String?,
      fullName: jsonSerialization['fullName'] as String?,
      roles: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['roles'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = AppUserRecordTable();

  static const db = AppUserRecordRepository._();

  @override
  _i1.UuidValue? id;

  String username;

  String? email;

  String? fullName;

  /// Snapshot of the Keycloak realm roles at last login. Not the
  /// authorization source of truth — the JWT is, checked per request.
  List<String> roles;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [AppUserRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppUserRecord copyWith({
    _i1.UuidValue? id,
    String? username,
    String? email,
    String? fullName,
    List<String>? roles,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUserRecord',
      if (id != null) 'id': id?.toJson(),
      'username': username,
      if (email != null) 'email': email,
      if (fullName != null) 'fullName': fullName,
      'roles': roles.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppUserRecord',
      if (id != null) 'id': id?.toJson(),
      'username': username,
      if (email != null) 'email': email,
      if (fullName != null) 'fullName': fullName,
      'roles': roles.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AppUserRecordInclude include() {
    return AppUserRecordInclude._();
  }

  static AppUserRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<AppUserRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppUserRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppUserRecordTable>? orderByList,
    AppUserRecordInclude? include,
  }) {
    return AppUserRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUserRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AppUserRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserRecordImpl extends AppUserRecord {
  _AppUserRecordImpl({
    _i1.UuidValue? id,
    required String username,
    String? email,
    String? fullName,
    required List<String> roles,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         username: username,
         email: email,
         fullName: fullName,
         roles: roles,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AppUserRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppUserRecord copyWith({
    Object? id = _Undefined,
    String? username,
    Object? email = _Undefined,
    Object? fullName = _Undefined,
    List<String>? roles,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUserRecord(
      id: id is _i1.UuidValue? ? id : this.id,
      username: username ?? this.username,
      email: email is String? ? email : this.email,
      fullName: fullName is String? ? fullName : this.fullName,
      roles: roles ?? this.roles.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AppUserRecordUpdateTable extends _i1.UpdateTable<AppUserRecordTable> {
  AppUserRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> username(String value) => _i1.ColumnValue(
    table.username,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> fullName(String? value) => _i1.ColumnValue(
    table.fullName,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> roles(List<String> value) =>
      _i1.ColumnValue(
        table.roles,
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

class AppUserRecordTable extends _i1.Table<_i1.UuidValue?> {
  AppUserRecordTable({super.tableRelation}) : super(tableName: 'app_user') {
    updateTable = AppUserRecordUpdateTable(this);
    username = _i1.ColumnString(
      'username',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    fullName = _i1.ColumnString(
      'fullName',
      this,
    );
    roles = _i1.ColumnSerializable<List<String>>(
      'roles',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final AppUserRecordUpdateTable updateTable;

  late final _i1.ColumnString username;

  late final _i1.ColumnString email;

  late final _i1.ColumnString fullName;

  /// Snapshot of the Keycloak realm roles at last login. Not the
  /// authorization source of truth — the JWT is, checked per request.
  late final _i1.ColumnSerializable<List<String>> roles;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    username,
    email,
    fullName,
    roles,
    createdAt,
    updatedAt,
  ];
}

class AppUserRecordInclude extends _i1.IncludeObject {
  AppUserRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => AppUserRecord.t;
}

class AppUserRecordIncludeList extends _i1.IncludeList {
  AppUserRecordIncludeList._({
    _i1.WhereExpressionBuilder<AppUserRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppUserRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => AppUserRecord.t;
}

class AppUserRecordRepository {
  const AppUserRecordRepository._();

  /// Returns a list of [AppUserRecord]s matching the given query parameters.
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
  Future<List<AppUserRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppUserRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppUserRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppUserRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AppUserRecord>(
      where: where?.call(AppUserRecord.t),
      orderBy: orderBy?.call(AppUserRecord.t),
      orderByList: orderByList?.call(AppUserRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AppUserRecord] matching the given query parameters.
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
  Future<AppUserRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppUserRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<AppUserRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppUserRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AppUserRecord>(
      where: where?.call(AppUserRecord.t),
      orderBy: orderBy?.call(AppUserRecord.t),
      orderByList: orderByList?.call(AppUserRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AppUserRecord] by its [id] or null if no such row exists.
  Future<AppUserRecord?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AppUserRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AppUserRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [AppUserRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AppUserRecord>> insert(
    _i1.DatabaseSession session,
    List<AppUserRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AppUserRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AppUserRecord] and returns the inserted row.
  ///
  /// The returned [AppUserRecord] will have its `id` field set.
  Future<AppUserRecord> insertRow(
    _i1.DatabaseSession session,
    AppUserRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AppUserRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AppUserRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AppUserRecord>> update(
    _i1.DatabaseSession session,
    List<AppUserRecord> rows, {
    _i1.ColumnSelections<AppUserRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AppUserRecord>(
      rows,
      columns: columns?.call(AppUserRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppUserRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppUserRecord> updateRow(
    _i1.DatabaseSession session,
    AppUserRecord row, {
    _i1.ColumnSelections<AppUserRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppUserRecord>(
      row,
      columns: columns?.call(AppUserRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppUserRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AppUserRecord?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<AppUserRecordUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AppUserRecord>(
      id,
      columnValues: columnValues(AppUserRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AppUserRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AppUserRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AppUserRecordUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AppUserRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppUserRecordTable>? orderBy,
    _i1.OrderByListBuilder<AppUserRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AppUserRecord>(
      columnValues: columnValues(AppUserRecord.t.updateTable),
      where: where(AppUserRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUserRecord.t),
      orderByList: orderByList?.call(AppUserRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AppUserRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AppUserRecord>> delete(
    _i1.DatabaseSession session,
    List<AppUserRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AppUserRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AppUserRecord].
  Future<AppUserRecord> deleteRow(
    _i1.DatabaseSession session,
    AppUserRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AppUserRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AppUserRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppUserRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AppUserRecord>(
      where: where(AppUserRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppUserRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AppUserRecord>(
      where: where?.call(AppUserRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AppUserRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppUserRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AppUserRecord>(
      where: where(AppUserRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
