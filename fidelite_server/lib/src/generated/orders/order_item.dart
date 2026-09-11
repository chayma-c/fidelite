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
import '../orders/order.dart' as _i2;
import '../menu/menu_item.dart' as _i3;
import 'package:fidelite_server/src/generated/protocol.dart' as _i4;

/// One line item within an order. Snapshots the menu item's name and price
/// at time of sale so later menu edits/repricing never corrupt historical
/// receipts.
abstract class OrderItemRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrderItemRecord._({
    this.id,
    required this.orderId,
    this.order,
    required this.menuItemId,
    this.menuItem,
    required this.menuItemNameSnapshot,
    required this.unitPriceMillimesSnapshot,
    required this.quantity,
    required this.lineTotalMillimes,
  });

  factory OrderItemRecord({
    int? id,
    required int orderId,
    _i2.OrderRecord? order,
    required int menuItemId,
    _i3.MenuItemRecord? menuItem,
    required String menuItemNameSnapshot,
    required int unitPriceMillimesSnapshot,
    required int quantity,
    required int lineTotalMillimes,
  }) = _OrderItemRecordImpl;

  factory OrderItemRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderItemRecord(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      order: jsonSerialization['order'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.OrderRecord>(
              jsonSerialization['order'],
            ),
      menuItemId: jsonSerialization['menuItemId'] as int,
      menuItem: jsonSerialization['menuItem'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.MenuItemRecord>(
              jsonSerialization['menuItem'],
            ),
      menuItemNameSnapshot: jsonSerialization['menuItemNameSnapshot'] as String,
      unitPriceMillimesSnapshot:
          jsonSerialization['unitPriceMillimesSnapshot'] as int,
      quantity: jsonSerialization['quantity'] as int,
      lineTotalMillimes: jsonSerialization['lineTotalMillimes'] as int,
    );
  }

  static final t = OrderItemRecordTable();

  static const db = OrderItemRecordRepository._();

  @override
  int? id;

  int orderId;

  _i2.OrderRecord? order;

  int menuItemId;

  _i3.MenuItemRecord? menuItem;

  String menuItemNameSnapshot;

  int unitPriceMillimesSnapshot;

  int quantity;

  int lineTotalMillimes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrderItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderItemRecord copyWith({
    int? id,
    int? orderId,
    _i2.OrderRecord? order,
    int? menuItemId,
    _i3.MenuItemRecord? menuItem,
    String? menuItemNameSnapshot,
    int? unitPriceMillimesSnapshot,
    int? quantity,
    int? lineTotalMillimes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderItemRecord',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (order != null) 'order': order?.toJson(),
      'menuItemId': menuItemId,
      if (menuItem != null) 'menuItem': menuItem?.toJson(),
      'menuItemNameSnapshot': menuItemNameSnapshot,
      'unitPriceMillimesSnapshot': unitPriceMillimesSnapshot,
      'quantity': quantity,
      'lineTotalMillimes': lineTotalMillimes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderItemRecord',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (order != null) 'order': order?.toJsonForProtocol(),
      'menuItemId': menuItemId,
      if (menuItem != null) 'menuItem': menuItem?.toJsonForProtocol(),
      'menuItemNameSnapshot': menuItemNameSnapshot,
      'unitPriceMillimesSnapshot': unitPriceMillimesSnapshot,
      'quantity': quantity,
      'lineTotalMillimes': lineTotalMillimes,
    };
  }

  static OrderItemRecordInclude include({
    _i2.OrderRecordInclude? order,
    _i3.MenuItemRecordInclude? menuItem,
  }) {
    return OrderItemRecordInclude._(
      order: order,
      menuItem: menuItem,
    );
  }

  static OrderItemRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<OrderItemRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderItemRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderItemRecordTable>? orderByList,
    OrderItemRecordInclude? include,
  }) {
    return OrderItemRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderItemRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrderItemRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderItemRecordImpl extends OrderItemRecord {
  _OrderItemRecordImpl({
    int? id,
    required int orderId,
    _i2.OrderRecord? order,
    required int menuItemId,
    _i3.MenuItemRecord? menuItem,
    required String menuItemNameSnapshot,
    required int unitPriceMillimesSnapshot,
    required int quantity,
    required int lineTotalMillimes,
  }) : super._(
         id: id,
         orderId: orderId,
         order: order,
         menuItemId: menuItemId,
         menuItem: menuItem,
         menuItemNameSnapshot: menuItemNameSnapshot,
         unitPriceMillimesSnapshot: unitPriceMillimesSnapshot,
         quantity: quantity,
         lineTotalMillimes: lineTotalMillimes,
       );

  /// Returns a shallow copy of this [OrderItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderItemRecord copyWith({
    Object? id = _Undefined,
    int? orderId,
    Object? order = _Undefined,
    int? menuItemId,
    Object? menuItem = _Undefined,
    String? menuItemNameSnapshot,
    int? unitPriceMillimesSnapshot,
    int? quantity,
    int? lineTotalMillimes,
  }) {
    return OrderItemRecord(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      order: order is _i2.OrderRecord? ? order : this.order?.copyWith(),
      menuItemId: menuItemId ?? this.menuItemId,
      menuItem: menuItem is _i3.MenuItemRecord?
          ? menuItem
          : this.menuItem?.copyWith(),
      menuItemNameSnapshot: menuItemNameSnapshot ?? this.menuItemNameSnapshot,
      unitPriceMillimesSnapshot:
          unitPriceMillimesSnapshot ?? this.unitPriceMillimesSnapshot,
      quantity: quantity ?? this.quantity,
      lineTotalMillimes: lineTotalMillimes ?? this.lineTotalMillimes,
    );
  }
}

class OrderItemRecordUpdateTable extends _i1.UpdateTable<OrderItemRecordTable> {
  OrderItemRecordUpdateTable(super.table);

  _i1.ColumnValue<int, int> orderId(int value) => _i1.ColumnValue(
    table.orderId,
    value,
  );

  _i1.ColumnValue<int, int> menuItemId(int value) => _i1.ColumnValue(
    table.menuItemId,
    value,
  );

  _i1.ColumnValue<String, String> menuItemNameSnapshot(String value) =>
      _i1.ColumnValue(
        table.menuItemNameSnapshot,
        value,
      );

  _i1.ColumnValue<int, int> unitPriceMillimesSnapshot(int value) =>
      _i1.ColumnValue(
        table.unitPriceMillimesSnapshot,
        value,
      );

  _i1.ColumnValue<int, int> quantity(int value) => _i1.ColumnValue(
    table.quantity,
    value,
  );

  _i1.ColumnValue<int, int> lineTotalMillimes(int value) => _i1.ColumnValue(
    table.lineTotalMillimes,
    value,
  );
}

class OrderItemRecordTable extends _i1.Table<int?> {
  OrderItemRecordTable({super.tableRelation}) : super(tableName: 'order_item') {
    updateTable = OrderItemRecordUpdateTable(this);
    orderId = _i1.ColumnInt(
      'orderId',
      this,
    );
    menuItemId = _i1.ColumnInt(
      'menuItemId',
      this,
    );
    menuItemNameSnapshot = _i1.ColumnString(
      'menuItemNameSnapshot',
      this,
    );
    unitPriceMillimesSnapshot = _i1.ColumnInt(
      'unitPriceMillimesSnapshot',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    lineTotalMillimes = _i1.ColumnInt(
      'lineTotalMillimes',
      this,
    );
  }

  late final OrderItemRecordUpdateTable updateTable;

  late final _i1.ColumnInt orderId;

  _i2.OrderRecordTable? _order;

  late final _i1.ColumnInt menuItemId;

  _i3.MenuItemRecordTable? _menuItem;

  late final _i1.ColumnString menuItemNameSnapshot;

  late final _i1.ColumnInt unitPriceMillimesSnapshot;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnInt lineTotalMillimes;

  _i2.OrderRecordTable get order {
    if (_order != null) return _order!;
    _order = _i1.createRelationTable(
      relationFieldName: 'order',
      field: OrderItemRecord.t.orderId,
      foreignField: _i2.OrderRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrderRecordTable(tableRelation: foreignTableRelation),
    );
    return _order!;
  }

  _i3.MenuItemRecordTable get menuItem {
    if (_menuItem != null) return _menuItem!;
    _menuItem = _i1.createRelationTable(
      relationFieldName: 'menuItem',
      field: OrderItemRecord.t.menuItemId,
      foreignField: _i3.MenuItemRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.MenuItemRecordTable(tableRelation: foreignTableRelation),
    );
    return _menuItem!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    orderId,
    menuItemId,
    menuItemNameSnapshot,
    unitPriceMillimesSnapshot,
    quantity,
    lineTotalMillimes,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'order') {
      return order;
    }
    if (relationField == 'menuItem') {
      return menuItem;
    }
    return null;
  }
}

class OrderItemRecordInclude extends _i1.IncludeObject {
  OrderItemRecordInclude._({
    _i2.OrderRecordInclude? order,
    _i3.MenuItemRecordInclude? menuItem,
  }) {
    _order = order;
    _menuItem = menuItem;
  }

  _i2.OrderRecordInclude? _order;

  _i3.MenuItemRecordInclude? _menuItem;

  @override
  Map<String, _i1.Include?> get includes => {
    'order': _order,
    'menuItem': _menuItem,
  };

  @override
  _i1.Table<int?> get table => OrderItemRecord.t;
}

class OrderItemRecordIncludeList extends _i1.IncludeList {
  OrderItemRecordIncludeList._({
    _i1.WhereExpressionBuilder<OrderItemRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrderItemRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrderItemRecord.t;
}

class OrderItemRecordRepository {
  const OrderItemRecordRepository._();

  final attachRow = const OrderItemRecordAttachRowRepository._();

  /// Returns a list of [OrderItemRecord]s matching the given query parameters.
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
  Future<List<OrderItemRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderItemRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderItemRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderItemRecordTable>? orderByList,
    _i1.Transaction? transaction,
    OrderItemRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OrderItemRecord>(
      where: where?.call(OrderItemRecord.t),
      orderBy: orderBy?.call(OrderItemRecord.t),
      orderByList: orderByList?.call(OrderItemRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OrderItemRecord] matching the given query parameters.
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
  Future<OrderItemRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderItemRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrderItemRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrderItemRecordTable>? orderByList,
    _i1.Transaction? transaction,
    OrderItemRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OrderItemRecord>(
      where: where?.call(OrderItemRecord.t),
      orderBy: orderBy?.call(OrderItemRecord.t),
      orderByList: orderByList?.call(OrderItemRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OrderItemRecord] by its [id] or null if no such row exists.
  Future<OrderItemRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    OrderItemRecordInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OrderItemRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OrderItemRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [OrderItemRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OrderItemRecord>> insert(
    _i1.DatabaseSession session,
    List<OrderItemRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OrderItemRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OrderItemRecord] and returns the inserted row.
  ///
  /// The returned [OrderItemRecord] will have its `id` field set.
  Future<OrderItemRecord> insertRow(
    _i1.DatabaseSession session,
    OrderItemRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrderItemRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrderItemRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrderItemRecord>> update(
    _i1.DatabaseSession session,
    List<OrderItemRecord> rows, {
    _i1.ColumnSelections<OrderItemRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrderItemRecord>(
      rows,
      columns: columns?.call(OrderItemRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderItemRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrderItemRecord> updateRow(
    _i1.DatabaseSession session,
    OrderItemRecord row, {
    _i1.ColumnSelections<OrderItemRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrderItemRecord>(
      row,
      columns: columns?.call(OrderItemRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderItemRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrderItemRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OrderItemRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OrderItemRecord>(
      id,
      columnValues: columnValues(OrderItemRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrderItemRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OrderItemRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OrderItemRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<OrderItemRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrderItemRecordTable>? orderBy,
    _i1.OrderByListBuilder<OrderItemRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OrderItemRecord>(
      columnValues: columnValues(OrderItemRecord.t.updateTable),
      where: where(OrderItemRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderItemRecord.t),
      orderByList: orderByList?.call(OrderItemRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OrderItemRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrderItemRecord>> delete(
    _i1.DatabaseSession session,
    List<OrderItemRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrderItemRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrderItemRecord].
  Future<OrderItemRecord> deleteRow(
    _i1.DatabaseSession session,
    OrderItemRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrderItemRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrderItemRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderItemRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrderItemRecord>(
      where: where(OrderItemRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrderItemRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrderItemRecord>(
      where: where?.call(OrderItemRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OrderItemRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrderItemRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OrderItemRecord>(
      where: where(OrderItemRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class OrderItemRecordAttachRowRepository {
  const OrderItemRecordAttachRowRepository._();

  /// Creates a relation between the given [OrderItemRecord] and [OrderRecord]
  /// by setting the [OrderItemRecord]'s foreign key `orderId` to refer to the [OrderRecord].
  Future<void> order(
    _i1.DatabaseSession session,
    OrderItemRecord orderItemRecord,
    _i2.OrderRecord order, {
    _i1.Transaction? transaction,
  }) async {
    if (orderItemRecord.id == null) {
      throw ArgumentError.notNull('orderItemRecord.id');
    }
    if (order.id == null) {
      throw ArgumentError.notNull('order.id');
    }

    var $orderItemRecord = orderItemRecord.copyWith(orderId: order.id);
    await session.db.updateRow<OrderItemRecord>(
      $orderItemRecord,
      columns: [OrderItemRecord.t.orderId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [OrderItemRecord] and [MenuItemRecord]
  /// by setting the [OrderItemRecord]'s foreign key `menuItemId` to refer to the [MenuItemRecord].
  Future<void> menuItem(
    _i1.DatabaseSession session,
    OrderItemRecord orderItemRecord,
    _i3.MenuItemRecord menuItem, {
    _i1.Transaction? transaction,
  }) async {
    if (orderItemRecord.id == null) {
      throw ArgumentError.notNull('orderItemRecord.id');
    }
    if (menuItem.id == null) {
      throw ArgumentError.notNull('menuItem.id');
    }

    var $orderItemRecord = orderItemRecord.copyWith(menuItemId: menuItem.id);
    await session.db.updateRow<OrderItemRecord>(
      $orderItemRecord,
      columns: [OrderItemRecord.t.menuItemId],
      transaction: transaction,
    );
  }
}
