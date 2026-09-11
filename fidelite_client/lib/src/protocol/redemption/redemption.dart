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
import '../redemption/redemption_status.dart' as _i2;
import '../users/app_user.dart' as _i3;
import '../rewards/reward_item.dart' as _i4;
import 'package:fidelite_client/src/protocol/protocol.dart' as _i5;

/// A completed reward redemption: [pointsCostSnapshot] was deducted from
/// [customerUser]'s cashback balance by [staffUser] scanning their wallet
/// QR. Snapshots the reward's name/cost at time of redemption so later
/// catalog edits never corrupt history.
abstract class RedemptionRecord implements _i1.SerializableModel {
  RedemptionRecord._({
    this.id,
    required this.customerUserId,
    this.customerUser,
    required this.staffUserId,
    this.staffUser,
    required this.rewardItemId,
    this.rewardItem,
    required this.rewardNameSnapshot,
    required this.pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  }) : status = status ?? _i2.RedemptionStatus.completed,
       createdAt = createdAt ?? DateTime.now();

  factory RedemptionRecord({
    int? id,
    required _i1.UuidValue customerUserId,
    _i3.AppUserRecord? customerUser,
    required _i1.UuidValue staffUserId,
    _i3.AppUserRecord? staffUser,
    required int rewardItemId,
    _i4.RewardItemRecord? rewardItem,
    required String rewardNameSnapshot,
    required int pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  }) = _RedemptionRecordImpl;

  factory RedemptionRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return RedemptionRecord(
      id: jsonSerialization['id'] as int?,
      customerUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['customerUserId'],
      ),
      customerUser: jsonSerialization['customerUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['customerUser'],
            ),
      staffUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['staffUserId'],
      ),
      staffUser: jsonSerialization['staffUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['staffUser'],
            ),
      rewardItemId: jsonSerialization['rewardItemId'] as int,
      rewardItem: jsonSerialization['rewardItem'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.RewardItemRecord>(
              jsonSerialization['rewardItem'],
            ),
      rewardNameSnapshot: jsonSerialization['rewardNameSnapshot'] as String,
      pointsCostSnapshot: jsonSerialization['pointsCostSnapshot'] as int,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.RedemptionStatus.fromJson(
              (jsonSerialization['status'] as String),
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

  _i1.UuidValue customerUserId;

  _i3.AppUserRecord? customerUser;

  _i1.UuidValue staffUserId;

  _i3.AppUserRecord? staffUser;

  int rewardItemId;

  _i4.RewardItemRecord? rewardItem;

  String rewardNameSnapshot;

  int pointsCostSnapshot;

  _i2.RedemptionStatus status;

  DateTime createdAt;

  /// Returns a shallow copy of this [RedemptionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RedemptionRecord copyWith({
    int? id,
    _i1.UuidValue? customerUserId,
    _i3.AppUserRecord? customerUser,
    _i1.UuidValue? staffUserId,
    _i3.AppUserRecord? staffUser,
    int? rewardItemId,
    _i4.RewardItemRecord? rewardItem,
    String? rewardNameSnapshot,
    int? pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RedemptionRecord',
      if (id != null) 'id': id,
      'customerUserId': customerUserId.toJson(),
      if (customerUser != null) 'customerUser': customerUser?.toJson(),
      'staffUserId': staffUserId.toJson(),
      if (staffUser != null) 'staffUser': staffUser?.toJson(),
      'rewardItemId': rewardItemId,
      if (rewardItem != null) 'rewardItem': rewardItem?.toJson(),
      'rewardNameSnapshot': rewardNameSnapshot,
      'pointsCostSnapshot': pointsCostSnapshot,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RedemptionRecordImpl extends RedemptionRecord {
  _RedemptionRecordImpl({
    int? id,
    required _i1.UuidValue customerUserId,
    _i3.AppUserRecord? customerUser,
    required _i1.UuidValue staffUserId,
    _i3.AppUserRecord? staffUser,
    required int rewardItemId,
    _i4.RewardItemRecord? rewardItem,
    required String rewardNameSnapshot,
    required int pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         customerUserId: customerUserId,
         customerUser: customerUser,
         staffUserId: staffUserId,
         staffUser: staffUser,
         rewardItemId: rewardItemId,
         rewardItem: rewardItem,
         rewardNameSnapshot: rewardNameSnapshot,
         pointsCostSnapshot: pointsCostSnapshot,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RedemptionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RedemptionRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? customerUserId,
    Object? customerUser = _Undefined,
    _i1.UuidValue? staffUserId,
    Object? staffUser = _Undefined,
    int? rewardItemId,
    Object? rewardItem = _Undefined,
    String? rewardNameSnapshot,
    int? pointsCostSnapshot,
    _i2.RedemptionStatus? status,
    DateTime? createdAt,
  }) {
    return RedemptionRecord(
      id: id is int? ? id : this.id,
      customerUserId: customerUserId ?? this.customerUserId,
      customerUser: customerUser is _i3.AppUserRecord?
          ? customerUser
          : this.customerUser?.copyWith(),
      staffUserId: staffUserId ?? this.staffUserId,
      staffUser: staffUser is _i3.AppUserRecord?
          ? staffUser
          : this.staffUser?.copyWith(),
      rewardItemId: rewardItemId ?? this.rewardItemId,
      rewardItem: rewardItem is _i4.RewardItemRecord?
          ? rewardItem
          : this.rewardItem?.copyWith(),
      rewardNameSnapshot: rewardNameSnapshot ?? this.rewardNameSnapshot,
      pointsCostSnapshot: pointsCostSnapshot ?? this.pointsCostSnapshot,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
