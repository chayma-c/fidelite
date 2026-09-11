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
import '../points/claim_token_status.dart' as _i2;
import '../orders/order.dart' as _i3;
import '../users/app_user.dart' as _i4;
import 'package:fidelite_client/src/protocol/protocol.dart' as _i5;

/// A single-use claim token for an order's points-earning QR. The raw
/// token is only ever returned once (at issuance, from
/// OrderEndpoint.submitOrder) -- only its hash is persisted here, so a
/// full DB dump can't be used to forge a claim. Single-use is enforced via
/// an atomic conditional UPDATE (see PointsClaimEndpoint.claimOrderPoints),
/// not by short expiry -- the generous [expiresAt] window below is just a
/// cleanup horizon, not the real defense.
abstract class OrderClaimTokenRecord implements _i1.SerializableModel {
  OrderClaimTokenRecord._({
    this.id,
    required this.orderId,
    this.order,
    required this.tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    required this.expiresAt,
    this.claimedAt,
    this.claimedByUserId,
    this.claimedByUser,
  }) : status = status ?? _i2.ClaimTokenStatus.pending,
       issuedAt = issuedAt ?? DateTime.now();

  factory OrderClaimTokenRecord({
    int? id,
    required int orderId,
    _i3.OrderRecord? order,
    required String tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    required DateTime expiresAt,
    DateTime? claimedAt,
    _i1.UuidValue? claimedByUserId,
    _i4.AppUserRecord? claimedByUser,
  }) = _OrderClaimTokenRecordImpl;

  factory OrderClaimTokenRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OrderClaimTokenRecord(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      order: jsonSerialization['order'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.OrderRecord>(
              jsonSerialization['order'],
            ),
      tokenHash: jsonSerialization['tokenHash'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.ClaimTokenStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      issuedAt: jsonSerialization['issuedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['issuedAt']),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      claimedAt: jsonSerialization['claimedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['claimedAt']),
      claimedByUserId: jsonSerialization['claimedByUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['claimedByUserId'],
            ),
      claimedByUser: jsonSerialization['claimedByUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.AppUserRecord>(
              jsonSerialization['claimedByUser'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  _i3.OrderRecord? order;

  String tokenHash;

  _i2.ClaimTokenStatus status;

  DateTime issuedAt;

  DateTime expiresAt;

  DateTime? claimedAt;

  _i1.UuidValue? claimedByUserId;

  _i4.AppUserRecord? claimedByUser;

  /// Returns a shallow copy of this [OrderClaimTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderClaimTokenRecord copyWith({
    int? id,
    int? orderId,
    _i3.OrderRecord? order,
    String? tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    DateTime? expiresAt,
    DateTime? claimedAt,
    _i1.UuidValue? claimedByUserId,
    _i4.AppUserRecord? claimedByUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderClaimTokenRecord',
      if (id != null) 'id': id,
      'orderId': orderId,
      if (order != null) 'order': order?.toJson(),
      'tokenHash': tokenHash,
      'status': status.toJson(),
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (claimedAt != null) 'claimedAt': claimedAt?.toJson(),
      if (claimedByUserId != null) 'claimedByUserId': claimedByUserId?.toJson(),
      if (claimedByUser != null) 'claimedByUser': claimedByUser?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderClaimTokenRecordImpl extends OrderClaimTokenRecord {
  _OrderClaimTokenRecordImpl({
    int? id,
    required int orderId,
    _i3.OrderRecord? order,
    required String tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    required DateTime expiresAt,
    DateTime? claimedAt,
    _i1.UuidValue? claimedByUserId,
    _i4.AppUserRecord? claimedByUser,
  }) : super._(
         id: id,
         orderId: orderId,
         order: order,
         tokenHash: tokenHash,
         status: status,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         claimedAt: claimedAt,
         claimedByUserId: claimedByUserId,
         claimedByUser: claimedByUser,
       );

  /// Returns a shallow copy of this [OrderClaimTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderClaimTokenRecord copyWith({
    Object? id = _Undefined,
    int? orderId,
    Object? order = _Undefined,
    String? tokenHash,
    _i2.ClaimTokenStatus? status,
    DateTime? issuedAt,
    DateTime? expiresAt,
    Object? claimedAt = _Undefined,
    Object? claimedByUserId = _Undefined,
    Object? claimedByUser = _Undefined,
  }) {
    return OrderClaimTokenRecord(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      order: order is _i3.OrderRecord? ? order : this.order?.copyWith(),
      tokenHash: tokenHash ?? this.tokenHash,
      status: status ?? this.status,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      claimedAt: claimedAt is DateTime? ? claimedAt : this.claimedAt,
      claimedByUserId: claimedByUserId is _i1.UuidValue?
          ? claimedByUserId
          : this.claimedByUserId,
      claimedByUser: claimedByUser is _i4.AppUserRecord?
          ? claimedByUser
          : this.claimedByUser?.copyWith(),
    );
  }
}
