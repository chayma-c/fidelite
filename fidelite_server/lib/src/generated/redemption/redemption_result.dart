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
import '../redemption/redemption.dart' as _i2;
import 'package:fidelite_server/src/generated/protocol.dart' as _i3;

/// Result of a successful redemption.
abstract class RedemptionResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RedemptionResult._({
    required this.redemption,
    required this.customerNewBalanceMillimes,
  });

  factory RedemptionResult({
    required _i2.RedemptionRecord redemption,
    required int customerNewBalanceMillimes,
  }) = _RedemptionResultImpl;

  factory RedemptionResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return RedemptionResult(
      redemption: _i3.Protocol().deserialize<_i2.RedemptionRecord>(
        jsonSerialization['redemption'],
      ),
      customerNewBalanceMillimes:
          jsonSerialization['customerNewBalanceMillimes'] as int,
    );
  }

  _i2.RedemptionRecord redemption;

  int customerNewBalanceMillimes;

  /// Returns a shallow copy of this [RedemptionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RedemptionResult copyWith({
    _i2.RedemptionRecord? redemption,
    int? customerNewBalanceMillimes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RedemptionResult',
      'redemption': redemption.toJson(),
      'customerNewBalanceMillimes': customerNewBalanceMillimes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RedemptionResult',
      'redemption': redemption.toJsonForProtocol(),
      'customerNewBalanceMillimes': customerNewBalanceMillimes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _RedemptionResultImpl extends RedemptionResult {
  _RedemptionResultImpl({
    required _i2.RedemptionRecord redemption,
    required int customerNewBalanceMillimes,
  }) : super._(
         redemption: redemption,
         customerNewBalanceMillimes: customerNewBalanceMillimes,
       );

  /// Returns a shallow copy of this [RedemptionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RedemptionResult copyWith({
    _i2.RedemptionRecord? redemption,
    int? customerNewBalanceMillimes,
  }) {
    return RedemptionResult(
      redemption: redemption ?? this.redemption.copyWith(),
      customerNewBalanceMillimes:
          customerNewBalanceMillimes ?? this.customerNewBalanceMillimes,
    );
  }
}
