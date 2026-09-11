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

/// Why PointsClaimEndpoint.claimOrderPoints was rejected.
enum OrderClaimExceptionReason implements _i1.SerializableModel {
  /// This exact token has already been used to claim points.
  alreadyClaimed,

  /// The token existed but is past its cleanup horizon.
  expired,

  /// No matching pending token for this order/token combination.
  invalidToken,
  unknown;

  static OrderClaimExceptionReason fromJson(String name) {
    switch (name) {
      case 'alreadyClaimed':
        return OrderClaimExceptionReason.alreadyClaimed;
      case 'expired':
        return OrderClaimExceptionReason.expired;
      case 'invalidToken':
        return OrderClaimExceptionReason.invalidToken;
      case 'unknown':
        return OrderClaimExceptionReason.unknown;
      default:
        return OrderClaimExceptionReason.unknown;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
