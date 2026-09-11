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
import '../users/app_user.dart' as _i2;
import '../redemption/redemption.dart' as _i3;
import 'package:fidelite_client/src/protocol/protocol.dart' as _i4;

/// A short-lived, single-use token behind the customer's wallet QR (shown
/// on their phone, scanned by staff to redeem a reward). Short expiry here
/// is the actual defense (unlike OrderClaimTokenRecord) -- a static,
/// never-expiring wallet QR would be a screenshot/replay risk, so the
/// wallet screen re-issues a fresh token roughly every 60s while visible.
abstract class WalletTokenRecord implements _i1.SerializableModel {
  WalletTokenRecord._({
    this.id,
    required this.userId,
    this.user,
    required this.tokenHash,
    DateTime? issuedAt,
    required this.expiresAt,
    this.consumedAt,
    this.consumedByRedemptionId,
    this.consumedByRedemption,
  }) : issuedAt = issuedAt ?? DateTime.now();

  factory WalletTokenRecord({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required String tokenHash,
    DateTime? issuedAt,
    required DateTime expiresAt,
    DateTime? consumedAt,
    int? consumedByRedemptionId,
    _i3.RedemptionRecord? consumedByRedemption,
  }) = _WalletTokenRecordImpl;

  factory WalletTokenRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return WalletTokenRecord(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.AppUserRecord>(
              jsonSerialization['user'],
            ),
      tokenHash: jsonSerialization['tokenHash'] as String,
      issuedAt: jsonSerialization['issuedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['issuedAt']),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      consumedAt: jsonSerialization['consumedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['consumedAt']),
      consumedByRedemptionId:
          jsonSerialization['consumedByRedemptionId'] as int?,
      consumedByRedemption: jsonSerialization['consumedByRedemption'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.RedemptionRecord>(
              jsonSerialization['consumedByRedemption'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  _i2.AppUserRecord? user;

  String tokenHash;

  DateTime issuedAt;

  DateTime expiresAt;

  /// Left null (token stays valid) if a redemption attempt fails for a
  /// business reason (e.g. insufficient balance) rather than an invalid
  /// token -- lets the cashier immediately retry a cheaper reward against
  /// the same still-displayed QR.
  DateTime? consumedAt;

  int? consumedByRedemptionId;

  _i3.RedemptionRecord? consumedByRedemption;

  /// Returns a shallow copy of this [WalletTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WalletTokenRecord copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AppUserRecord? user,
    String? tokenHash,
    DateTime? issuedAt,
    DateTime? expiresAt,
    DateTime? consumedAt,
    int? consumedByRedemptionId,
    _i3.RedemptionRecord? consumedByRedemption,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WalletTokenRecord',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'tokenHash': tokenHash,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (consumedAt != null) 'consumedAt': consumedAt?.toJson(),
      if (consumedByRedemptionId != null)
        'consumedByRedemptionId': consumedByRedemptionId,
      if (consumedByRedemption != null)
        'consumedByRedemption': consumedByRedemption?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WalletTokenRecordImpl extends WalletTokenRecord {
  _WalletTokenRecordImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required String tokenHash,
    DateTime? issuedAt,
    required DateTime expiresAt,
    DateTime? consumedAt,
    int? consumedByRedemptionId,
    _i3.RedemptionRecord? consumedByRedemption,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         tokenHash: tokenHash,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         consumedAt: consumedAt,
         consumedByRedemptionId: consumedByRedemptionId,
         consumedByRedemption: consumedByRedemption,
       );

  /// Returns a shallow copy of this [WalletTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WalletTokenRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? tokenHash,
    DateTime? issuedAt,
    DateTime? expiresAt,
    Object? consumedAt = _Undefined,
    Object? consumedByRedemptionId = _Undefined,
    Object? consumedByRedemption = _Undefined,
  }) {
    return WalletTokenRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AppUserRecord? ? user : this.user?.copyWith(),
      tokenHash: tokenHash ?? this.tokenHash,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      consumedAt: consumedAt is DateTime? ? consumedAt : this.consumedAt,
      consumedByRedemptionId: consumedByRedemptionId is int?
          ? consumedByRedemptionId
          : this.consumedByRedemptionId,
      consumedByRedemption: consumedByRedemption is _i3.RedemptionRecord?
          ? consumedByRedemption
          : this.consumedByRedemption?.copyWith(),
    );
  }
}
