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

/// One requested line when submitting an order. Deliberately carries no
/// price -- the server always looks up the current [MenuItemRecord] price
/// itself and computes totals server-side, so a client can never submit a
/// manipulated price.
abstract class OrderItemInput implements _i1.SerializableModel {
  OrderItemInput._({
    required this.menuItemId,
    required this.quantity,
  });

  factory OrderItemInput({
    required int menuItemId,
    required int quantity,
  }) = _OrderItemInputImpl;

  factory OrderItemInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderItemInput(
      menuItemId: jsonSerialization['menuItemId'] as int,
      quantity: jsonSerialization['quantity'] as int,
    );
  }

  int menuItemId;

  int quantity;

  /// Returns a shallow copy of this [OrderItemInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderItemInput copyWith({
    int? menuItemId,
    int? quantity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderItemInput',
      'menuItemId': menuItemId,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OrderItemInputImpl extends OrderItemInput {
  _OrderItemInputImpl({
    required int menuItemId,
    required int quantity,
  }) : super._(
         menuItemId: menuItemId,
         quantity: quantity,
       );

  /// Returns a shallow copy of this [OrderItemInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderItemInput copyWith({
    int? menuItemId,
    int? quantity,
  }) {
    return OrderItemInput(
      menuItemId: menuItemId ?? this.menuItemId,
      quantity: quantity ?? this.quantity,
    );
  }
}
