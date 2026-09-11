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
import '../../redemption/exceptions/redemption_exception_reason.dart' as _i2;

/// Thrown by RedemptionEndpoint.redeemReward when a scanned wallet QR
/// can't be redeemed for the requested reward.
abstract class RedemptionException
    implements _i1.SerializableException, _i1.SerializableModel {
  RedemptionException._({required this.reason});

  factory RedemptionException({required _i2.RedemptionExceptionReason reason}) =
      _RedemptionExceptionImpl;

  factory RedemptionException.fromJson(Map<String, dynamic> jsonSerialization) {
    return RedemptionException(
      reason: _i2.RedemptionExceptionReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
    );
  }

  _i2.RedemptionExceptionReason reason;

  /// Returns a shallow copy of this [RedemptionException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RedemptionException copyWith({_i2.RedemptionExceptionReason? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RedemptionException',
      'reason': reason.toJson(),
    };
  }

  @override
  String toString() {
    return 'RedemptionException(reason: $reason)';
  }
}

class _RedemptionExceptionImpl extends RedemptionException {
  _RedemptionExceptionImpl({required _i2.RedemptionExceptionReason reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [RedemptionException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RedemptionException copyWith({_i2.RedemptionExceptionReason? reason}) {
    return RedemptionException(reason: reason ?? this.reason);
  }
}
