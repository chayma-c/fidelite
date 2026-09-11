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
import '../orders/order_status.dart' as _i2;
import '../users/app_user.dart' as _i3;
import 'package:fidelite_client/src/protocol/protocol.dart' as _i4;

/// A confirmed counter order. Created already-confirmed in one atomic call
/// (OrderEndpoint.submitOrder) -- the cart is client-local state until that
/// single "confirm" tap, so there's no separate "pending" order concept in
/// the schema. Named `fidelite_order`/`OrderRecord` (not `order`/`Order`)
/// since "order" is a reserved SQL keyword and collides with Serverpod's
/// own `Order` (see database/concepts/order.dart) used for query sorting.
abstract class OrderRecord implements _i1.SerializableModel {
  OrderRecord._({
    this.id,
    required this.staffUserId,
    this.staffUser,
    _i2.OrderStatus? status,
    required this.subtotalMillimes,
    required this.totalMillimes,
    DateTime? createdAt,
  }) : status = status ?? _i2.OrderStatus.confirmed,
       createdAt = createdAt ?? DateTime.now();

  factory OrderRecord({
    int? id,
    required _i1.UuidValue staffUserId,
    _i3.AppUserRecord? staffUser,
    _i2.OrderStatus? status,
    required int subtotalMillimes,
    required int totalMillimes,
    DateTime? createdAt,
  }) = _OrderRecordImpl;

  factory OrderRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderRecord(
      id: jsonSerialization['id'] as int?,
      staffUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['staffUserId'],
      ),
      staffUser: jsonSerialization['staffUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['staffUser'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.OrderStatus.fromJson((jsonSerialization['status'] as String)),
      subtotalMillimes: jsonSerialization['subtotalMillimes'] as int,
      totalMillimes: jsonSerialization['totalMillimes'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue staffUserId;

  /// The staff member who took this order.
  _i3.AppUserRecord? staffUser;

  _i2.OrderStatus status;

  /// Split from totalMillimes now so a discount/tax line can be introduced
  /// later without a schema change; currently always equal.
  int subtotalMillimes;

  int totalMillimes;

  DateTime createdAt;

  /// Returns a shallow copy of this [OrderRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrderRecord copyWith({
    int? id,
    _i1.UuidValue? staffUserId,
    _i3.AppUserRecord? staffUser,
    _i2.OrderStatus? status,
    int? subtotalMillimes,
    int? totalMillimes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderRecord',
      if (id != null) 'id': id,
      'staffUserId': staffUserId.toJson(),
      if (staffUser != null) 'staffUser': staffUser?.toJson(),
      'status': status.toJson(),
      'subtotalMillimes': subtotalMillimes,
      'totalMillimes': totalMillimes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderRecordImpl extends OrderRecord {
  _OrderRecordImpl({
    int? id,
    required _i1.UuidValue staffUserId,
    _i3.AppUserRecord? staffUser,
    _i2.OrderStatus? status,
    required int subtotalMillimes,
    required int totalMillimes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         staffUserId: staffUserId,
         staffUser: staffUser,
         status: status,
         subtotalMillimes: subtotalMillimes,
         totalMillimes: totalMillimes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OrderRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrderRecord copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? staffUserId,
    Object? staffUser = _Undefined,
    _i2.OrderStatus? status,
    int? subtotalMillimes,
    int? totalMillimes,
    DateTime? createdAt,
  }) {
    return OrderRecord(
      id: id is int? ? id : this.id,
      staffUserId: staffUserId ?? this.staffUserId,
      staffUser: staffUser is _i3.AppUserRecord?
          ? staffUser
          : this.staffUser?.copyWith(),
      status: status ?? this.status,
      subtotalMillimes: subtotalMillimes ?? this.subtotalMillimes,
      totalMillimes: totalMillimes ?? this.totalMillimes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
