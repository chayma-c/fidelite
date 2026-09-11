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

/// Result of a successful points claim.
abstract class ClaimResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ClaimResult._({
    required this.pointsEarnedMillimes,
    required this.newBalanceMillimes,
  });

  factory ClaimResult({
    required int pointsEarnedMillimes,
    required int newBalanceMillimes,
  }) = _ClaimResultImpl;

  factory ClaimResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClaimResult(
      pointsEarnedMillimes: jsonSerialization['pointsEarnedMillimes'] as int,
      newBalanceMillimes: jsonSerialization['newBalanceMillimes'] as int,
    );
  }

  int pointsEarnedMillimes;

  int newBalanceMillimes;

  /// Returns a shallow copy of this [ClaimResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClaimResult copyWith({
    int? pointsEarnedMillimes,
    int? newBalanceMillimes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClaimResult',
      'pointsEarnedMillimes': pointsEarnedMillimes,
      'newBalanceMillimes': newBalanceMillimes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClaimResult',
      'pointsEarnedMillimes': pointsEarnedMillimes,
      'newBalanceMillimes': newBalanceMillimes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ClaimResultImpl extends ClaimResult {
  _ClaimResultImpl({
    required int pointsEarnedMillimes,
    required int newBalanceMillimes,
  }) : super._(
         pointsEarnedMillimes: pointsEarnedMillimes,
         newBalanceMillimes: newBalanceMillimes,
       );

  /// Returns a shallow copy of this [ClaimResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClaimResult copyWith({
    int? pointsEarnedMillimes,
    int? newBalanceMillimes,
  }) {
    return ClaimResult(
      pointsEarnedMillimes: pointsEarnedMillimes ?? this.pointsEarnedMillimes,
      newBalanceMillimes: newBalanceMillimes ?? this.newBalanceMillimes,
    );
  }
}
