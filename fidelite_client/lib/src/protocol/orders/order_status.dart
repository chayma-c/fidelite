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

/// Lifecycle status of an order.
enum OrderStatus implements _i1.SerializableModel {
  /// The order was placed and paid for at the counter.
  confirmed,

  /// Voided/cancelled after being placed (e.g. mistake at the till).
  /// Reserved for a future admin action; nothing sets this yet.
  voided;

  static OrderStatus fromJson(String name) {
    switch (name) {
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'voided':
        return OrderStatus.voided;
      default:
        return OrderStatus.confirmed;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
