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
    required this.removedIngredients,
    required this.addedSauces,
    this.specialRequest,
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
    required List<String> removedIngredients,
    required List<String> addedSauces,
    String? specialRequest,
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
      removedIngredients: _i4.Protocol().deserialize<List<String>>(
        jsonSerialization['removedIngredients'],
      ),
      addedSauces: _i4.Protocol().deserialize<List<String>>(
        jsonSerialization['addedSauces'],
      ),
      specialRequest: jsonSerialization['specialRequest'] as String?,
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

  /// Base ingredients the customer asked to leave out ("menghir"), by
  /// name -- snapshotted as plain text like the other *Snapshot fields,
  /// so a later edit/removal from the ingredient catalog never corrupts
  /// a historical receipt. Empty for a non-customizable item, or a
  /// customizable one ordered with nothing left out.
  List<String> removedIngredients;

  /// Optional sauces the customer added, by name -- same snapshot
  /// reasoning as [removedIngredients].
  List<String> addedSauces;

  /// Free-text note from the customer (e.g. "spicy"). Null when they
  /// skipped it.
  String? specialRequest;

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
    List<String>? removedIngredients,
    List<String>? addedSauces,
    String? specialRequest,
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
      'removedIngredients': removedIngredients.toJson(),
      'addedSauces': addedSauces.toJson(),
      if (specialRequest != null) 'specialRequest': specialRequest,
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
    required List<String> removedIngredients,
    required List<String> addedSauces,
    String? specialRequest,
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
         removedIngredients: removedIngredients,
         addedSauces: addedSauces,
         specialRequest: specialRequest,
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
    List<String>? removedIngredients,
    List<String>? addedSauces,
    Object? specialRequest = _Undefined,
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
      removedIngredients:
          removedIngredients ??
          this.removedIngredients.map((e0) => e0).toList(),
      addedSauces: addedSauces ?? this.addedSauces.map((e0) => e0).toList(),
      specialRequest: specialRequest is String?
          ? specialRequest
          : this.specialRequest,
    );
  }
}
