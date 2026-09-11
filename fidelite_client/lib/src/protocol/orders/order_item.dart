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

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../orders/order.dart' as _i2;
import '../menu/menu_item.dart' as _i3;
import 'package:fidelite_client/src/protocol/protocol.dart' as _i4;

/// One line item within an order. Snapshots the menu item's name and price
/// at time of sale so later menu edits/repricing never corrupt historical
/// receipts.
abstract class OrderItemRecord implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  _i2.OrderRecord? order;

  int menuItemId;

  _i3.MenuItemRecord? menuItem;

  String menuItemNameSnapshot;

  int unitPriceMillimesSnapshot;

  int quantity;

  int lineTotalMillimes;

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
