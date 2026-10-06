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
import 'package:fidelite_client/src/protocol/protocol.dart' as _i3;

/// A staff member's current FCM push token -- one row per user, enforced
/// at the application level (see device_token_endpoint.dart) the same way
/// ShopStatusRecord's singleton row is, rather than a DB constraint. A
/// fresh token (reinstall, app data cleared, rotation) overwrites the old
/// one; the previous device simply stops receiving pushes, which is the
/// right behavior for what's effectively one shared staff tablet.
abstract class DeviceTokenRecord implements _i1.SerializableModel {
  DeviceTokenRecord._({
    this.id,
    required this.userId,
    this.user,
    required this.fcmToken,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory DeviceTokenRecord({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required String fcmToken,
    DateTime? updatedAt,
  }) = _DeviceTokenRecordImpl;

  factory DeviceTokenRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeviceTokenRecord(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AppUserRecord>(
              jsonSerialization['user'],
            ),
      fcmToken: jsonSerialization['fcmToken'] as String,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  _i2.AppUserRecord? user;

  String fcmToken;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DeviceTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeviceTokenRecord copyWith({
    int? id,
    _i1.UuidValue? userId,
    _i2.AppUserRecord? user,
    String? fcmToken,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeviceTokenRecord',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'fcmToken': fcmToken,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeviceTokenRecordImpl extends DeviceTokenRecord {
  _DeviceTokenRecordImpl({
    int? id,
    required _i1.UuidValue userId,
    _i2.AppUserRecord? user,
    required String fcmToken,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         fcmToken: fcmToken,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DeviceTokenRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeviceTokenRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? fcmToken,
    DateTime? updatedAt,
  }) {
    return DeviceTokenRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.AppUserRecord? ? user : this.user?.copyWith(),
      fcmToken: fcmToken ?? this.fcmToken,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
