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

/// Why a points ledger entry exists.
enum PointsLedgerReason implements _i1.SerializableModel {
  /// Cashback earned by a customer claiming a confirmed order's receipt QR.
  orderClaim,

  /// Cashback spent redeeming a reward (staff-scanned wallet QR).
  redemption,

  /// Manual correction. Nothing creates this yet -- reserved for a future
  /// admin action.
  adjustment;

  static PointsLedgerReason fromJson(String name) {
    switch (name) {
      case 'orderClaim':
        return PointsLedgerReason.orderClaim;
      case 'redemption':
        return PointsLedgerReason.redemption;
      case 'adjustment':
        return PointsLedgerReason.adjustment;
      default:
        return PointsLedgerReason.adjustment;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
