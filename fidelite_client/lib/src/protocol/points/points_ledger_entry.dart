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
import '../points/points_ledger_reason.dart' as _i3;
import '../orders/order.dart' as _i4;
import '../redemption/redemption.dart' as _i5;
import 'package:fidelite_client/src/protocol/protocol.dart' as _i6;

/// An append-only record of a cashback balance change. The running balance
/// is always the sum of every entry for a user -- this table is the
/// source of truth, not a convenience cache alongside a separate mutable
/// balance column, so it's inherently auditable and reconcilable.
abstract class PointsLedgerEntryRecord implements _i1.SerializableModel {
  PointsLedgerEntryRecord._({
    this.id,
    required this.userId,
    this.user,
    required this.deltaMillimes,
    required this.reason,
    this.relatedOrderId,
    this.relatedOrder,
    this.relatedRedemptionId,
    this.relatedRedemption,
    required this.balanceAfterMillimes,
    required this.createdByUserId,
    this.createdByUser,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory PointsLedgerEntryRecord({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required int deltaMillimes,
    required _i3.PointsLedgerReason reason,
    int? relatedOrderId,
    _i4.OrderRecord? relatedOrder,
    int? relatedRedemptionId,
    _i5.RedemptionRecord? relatedRedemption,
    required int balanceAfterMillimes,
    required _i1.UuidValue createdByUserId,
    _i2.AppUserRecord? createdByUser,
    DateTime? createdAt,
  }) = _PointsLedgerEntryRecordImpl;

  factory PointsLedgerEntryRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PointsLedgerEntryRecord(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.AppUserRecord>(
              jsonSerialization['user'],
            ),
      deltaMillimes: jsonSerialization['deltaMillimes'] as int,
      reason: _i3.PointsLedgerReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
      relatedOrderId: jsonSerialization['relatedOrderId'] as int?,
      relatedOrder: jsonSerialization['relatedOrder'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.OrderRecord>(
              jsonSerialization['relatedOrder'],
            ),
      relatedRedemptionId: jsonSerialization['relatedRedemptionId'] as int?,
      relatedRedemption: jsonSerialization['relatedRedemption'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.RedemptionRecord>(
              jsonSerialization['relatedRedemption'],
            ),
      balanceAfterMillimes: jsonSerialization['balanceAfterMillimes'] as int,
      createdByUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdByUserId'],
      ),
      createdByUser: jsonSerialization['createdByUser'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.AppUserRecord>(
              jsonSerialization['createdByUser'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  /// The customer whose balance this entry affects.
  _i2.AppUserRecord? user;

  /// In millimes, the same unit as order prices -- this is cashback, not
  /// an abstract points currency (8% of an order's total, confirmed by
  /// the owner). Positive = earned, negative = spent.
  int deltaMillimes;

  _i3.PointsLedgerReason reason;

  int? relatedOrderId;

  /// Set when [reason] is orderClaim.
  _i4.OrderRecord? relatedOrder;

  int? relatedRedemptionId;

  /// Set when [reason] is redemption.
  _i5.RedemptionRecord? relatedRedemption;

  /// Running balance immediately after this entry, in millimes.
  int balanceAfterMillimes;

  _i1.UuidValue createdByUserId;

  /// Who caused this entry -- the customer themselves for an order claim;
  /// the staff member for a redemption.
  _i2.AppUserRecord? createdByUser;

  DateTime createdAt;

  /// Returns a shallow copy of this [PointsLedgerEntryRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PointsLedgerEntryRecord copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AppUserRecord? user,
    int? deltaMillimes,
    _i3.PointsLedgerReason? reason,
    int? relatedOrderId,
    _i4.OrderRecord? relatedOrder,
    int? relatedRedemptionId,
    _i5.RedemptionRecord? relatedRedemption,
    int? balanceAfterMillimes,
    _i1.UuidValue? createdByUserId,
    _i2.AppUserRecord? createdByUser,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PointsLedgerEntryRecord',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'deltaMillimes': deltaMillimes,
      'reason': reason.toJson(),
      if (relatedOrderId != null) 'relatedOrderId': relatedOrderId,
      if (relatedOrder != null) 'relatedOrder': relatedOrder?.toJson(),
      if (relatedRedemptionId != null)
        'relatedRedemptionId': relatedRedemptionId,
      if (relatedRedemption != null)
        'relatedRedemption': relatedRedemption?.toJson(),
      'balanceAfterMillimes': balanceAfterMillimes,
      'createdByUserId': createdByUserId.toJson(),
      if (createdByUser != null) 'createdByUser': createdByUser?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PointsLedgerEntryRecordImpl extends PointsLedgerEntryRecord {
  _PointsLedgerEntryRecordImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required int deltaMillimes,
    required _i3.PointsLedgerReason reason,
    int? relatedOrderId,
    _i4.OrderRecord? relatedOrder,
    int? relatedRedemptionId,
    _i5.RedemptionRecord? relatedRedemption,
    required int balanceAfterMillimes,
    required _i1.UuidValue createdByUserId,
    _i2.AppUserRecord? createdByUser,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         deltaMillimes: deltaMillimes,
         reason: reason,
         relatedOrderId: relatedOrderId,
         relatedOrder: relatedOrder,
         relatedRedemptionId: relatedRedemptionId,
         relatedRedemption: relatedRedemption,
         balanceAfterMillimes: balanceAfterMillimes,
         createdByUserId: createdByUserId,
         createdByUser: createdByUser,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PointsLedgerEntryRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PointsLedgerEntryRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    int? deltaMillimes,
    _i3.PointsLedgerReason? reason,
    Object? relatedOrderId = _Undefined,
    Object? relatedOrder = _Undefined,
    Object? relatedRedemptionId = _Undefined,
    Object? relatedRedemption = _Undefined,
    int? balanceAfterMillimes,
    _i1.UuidValue? createdByUserId,
    Object? createdByUser = _Undefined,
    DateTime? createdAt,
  }) {
    return PointsLedgerEntryRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AppUserRecord? ? user : this.user?.copyWith(),
      deltaMillimes: deltaMillimes ?? this.deltaMillimes,
      reason: reason ?? this.reason,
      relatedOrderId: relatedOrderId is int?
          ? relatedOrderId
          : this.relatedOrderId,
      relatedOrder: relatedOrder is _i4.OrderRecord?
          ? relatedOrder
          : this.relatedOrder?.copyWith(),
      relatedRedemptionId: relatedRedemptionId is int?
          ? relatedRedemptionId
          : this.relatedRedemptionId,
      relatedRedemption: relatedRedemption is _i5.RedemptionRecord?
          ? relatedRedemption
          : this.relatedRedemption?.copyWith(),
      balanceAfterMillimes: balanceAfterMillimes ?? this.balanceAfterMillimes,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdByUser: createdByUser is _i2.AppUserRecord?
          ? createdByUser
          : this.createdByUser?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
