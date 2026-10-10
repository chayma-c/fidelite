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

/// How a customer wants to receive an online order. Not meaningful for a
/// counter order -- staff and customer are both already physically there.
enum OrderFulfillmentMethod implements _i1.SerializableModel {
  /// Customer comes to the counter to collect it themselves.
  pickup,

  /// Delivered to the customer -- adds a flat delivery fee and requires a
  /// delivery address/phone (see OnlineOrderEndpoint).
  delivery;

  static OrderFulfillmentMethod fromJson(String name) {
    switch (name) {
      case 'pickup':
        return OrderFulfillmentMethod.pickup;
      case 'delivery':
        return OrderFulfillmentMethod.delivery;
      default:
        return OrderFulfillmentMethod.pickup;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
