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

/// Response for WalletEndpoint.getWalletToken. Bundles the current balance
/// with the token so the wallet QR screen doesn't need a second round trip
/// on every ~60s refresh.
abstract class WalletTokenResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  WalletTokenResponse._({
    required this.rawToken,
    required this.expiresAt,
    required this.currentBalanceMillimes,
  });

  factory WalletTokenResponse({
    required String rawToken,
    required DateTime expiresAt,
    required int currentBalanceMillimes,
  }) = _WalletTokenResponseImpl;

  factory WalletTokenResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return WalletTokenResponse(
      rawToken: jsonSerialization['rawToken'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      currentBalanceMillimes:
          jsonSerialization['currentBalanceMillimes'] as int,
    );
  }

  String rawToken;

  DateTime expiresAt;

  int currentBalanceMillimes;

  /// Returns a shallow copy of this [WalletTokenResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WalletTokenResponse copyWith({
    String? rawToken,
    DateTime? expiresAt,
    int? currentBalanceMillimes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WalletTokenResponse',
      'rawToken': rawToken,
      'expiresAt': expiresAt.toJson(),
      'currentBalanceMillimes': currentBalanceMillimes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WalletTokenResponse',
      'rawToken': rawToken,
      'expiresAt': expiresAt.toJson(),
      'currentBalanceMillimes': currentBalanceMillimes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _WalletTokenResponseImpl extends WalletTokenResponse {
  _WalletTokenResponseImpl({
    required String rawToken,
    required DateTime expiresAt,
    required int currentBalanceMillimes,
  }) : super._(
         rawToken: rawToken,
         expiresAt: expiresAt,
         currentBalanceMillimes: currentBalanceMillimes,
       );

  /// Returns a shallow copy of this [WalletTokenResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WalletTokenResponse copyWith({
    String? rawToken,
    DateTime? expiresAt,
    int? currentBalanceMillimes,
  }) {
    return WalletTokenResponse(
      rawToken: rawToken ?? this.rawToken,
      expiresAt: expiresAt ?? this.expiresAt,
      currentBalanceMillimes:
          currentBalanceMillimes ?? this.currentBalanceMillimes,
    );
  }
}
