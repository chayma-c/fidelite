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

/// Why an order submission was rejected.
enum InvalidOrderExceptionReason implements _i1.SerializableModel {
  /// The submitted item list was empty.
  emptyCart,

  /// One or more requested quantities was less than 1.
  invalidQuantity,

  /// A referenced menu item id doesn't exist or is no longer active.
  menuItemUnavailable,
  unknown;

  static InvalidOrderExceptionReason fromJson(String name) {
    switch (name) {
      case 'emptyCart':
        return InvalidOrderExceptionReason.emptyCart;
      case 'invalidQuantity':
        return InvalidOrderExceptionReason.invalidQuantity;
      case 'menuItemUnavailable':
        return InvalidOrderExceptionReason.menuItemUnavailable;
      case 'unknown':
        return InvalidOrderExceptionReason.unknown;
      default:
        return InvalidOrderExceptionReason.unknown;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
