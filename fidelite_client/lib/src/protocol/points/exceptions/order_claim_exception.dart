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
import '../../points/exceptions/order_claim_exception_reason.dart' as _i2;

/// Thrown by PointsClaimEndpoint.claimOrderPoints when the scanned QR
/// can't be redeemed for points. Inspect [reason] to show a specific
/// message instead of a generic failure.
abstract class OrderClaimException
    implements _i1.SerializableException, _i1.SerializableModel {
  OrderClaimException._({required this.reason});

  factory OrderClaimException({required _i2.OrderClaimExceptionReason reason}) =
      _OrderClaimExceptionImpl;

  factory OrderClaimException.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderClaimException(
      reason: _i2.OrderClaimExceptionReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
    );
  }

  _i2.OrderClaimExceptionReason reason;

  /// Returns a shallow copy of this [OrderClaimException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderClaimException copyWith({_i2.OrderClaimExceptionReason? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderClaimException',
      'reason': reason.toJson(),
    };
  }

  @override
  String toString() {
    return 'OrderClaimException(reason: $reason)';
  }
}

class _OrderClaimExceptionImpl extends OrderClaimException {
  _OrderClaimExceptionImpl({required _i2.OrderClaimExceptionReason reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [OrderClaimException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderClaimException copyWith({_i2.OrderClaimExceptionReason? reason}) {
    return OrderClaimException(reason: reason ?? this.reason);
  }
}
