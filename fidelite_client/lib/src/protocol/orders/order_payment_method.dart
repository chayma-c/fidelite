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

/// How a customer is paying for an online order. Not meaningful for a
/// counter order -- staff collect payment directly, outside the app.
enum OrderPaymentMethod implements _i1.SerializableModel {
  /// Deducted immediately from the customer's Fidélité cashback balance.
  /// No cashback is earned on an order paid this way (see
  /// OnlineOrderEndpoint) -- it would otherwise look like generating
  /// points from spending points.
  points,

  /// Paid in cash when the order is picked up or delivered -- not
  /// collected through the app. Still earns the usual cashback.
  cashOnSite;

  static OrderPaymentMethod fromJson(String name) {
    switch (name) {
      case 'points':
        return OrderPaymentMethod.points;
      case 'cashOnSite':
        return OrderPaymentMethod.cashOnSite;
      default:
        return OrderPaymentMethod.cashOnSite;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
