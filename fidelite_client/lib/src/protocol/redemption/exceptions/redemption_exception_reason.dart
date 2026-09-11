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

/// Why RedemptionEndpoint.redeemReward was rejected.
enum RedemptionExceptionReason implements _i1.SerializableModel {
  /// No matching unconsumed, unexpired wallet token for this customer/token
  /// combination.
  tokenInvalidOrExpired,

  /// The requested reward doesn't exist or is no longer active.
  rewardUnavailable,

  /// The customer's balance is less than the reward's cost. The wallet
  /// token is left unconsumed so the cashier can retry a cheaper reward.
  insufficientBalance,
  unknown;

  static RedemptionExceptionReason fromJson(String name) {
    switch (name) {
      case 'tokenInvalidOrExpired':
        return RedemptionExceptionReason.tokenInvalidOrExpired;
      case 'rewardUnavailable':
        return RedemptionExceptionReason.rewardUnavailable;
      case 'insufficientBalance':
        return RedemptionExceptionReason.insufficientBalance;
      case 'unknown':
        return RedemptionExceptionReason.unknown;
      default:
        return RedemptionExceptionReason.unknown;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
