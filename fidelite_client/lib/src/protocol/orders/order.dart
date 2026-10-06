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

/// A confirmed order, placed either by staff at the counter or by a
/// customer ordering themselves (see OnlineOrderEndpoint). Created
/// already-confirmed in one atomic call -- the cart is client-local state
/// until that single "confirm"/"place order" tap, so there's no separate
/// "draft" order concept in the schema. Named `fidelite_order`/
/// `OrderRecord` (not `order`/`Order`) since "order" is a reserved SQL
/// keyword and collides with Serverpod's own `Order` (see
/// database/concepts/order.dart) used for query sorting.
abstract class OrderRecord implements _i1.SerializableModel {
  OrderRecord._({
    this.id,
    this.staffUserId,
    this.staffUser,
    this.customerUserId,
    this.customerUser,
    this.handledAt,
    _i2.OrderStatus? status,
    int? ticketNumber,
    required this.subtotalMillimes,
    required this.totalMillimes,
    DateTime? createdAt,
  }) : status = status ?? _i2.OrderStatus.confirmed,
       ticketNumber = ticketNumber ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory OrderRecord({
    int? id,
    _i1.UuidValue? staffUserId,
    _i3.AppUserRecord? staffUser,
    _i1.UuidValue? customerUserId,
    _i3.AppUserRecord? customerUser,
    DateTime? handledAt,
    _i2.OrderStatus? status,
    int? ticketNumber,
    required int subtotalMillimes,
    required int totalMillimes,
    DateTime? createdAt,
  }) = _OrderRecordImpl;

  factory OrderRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderRecord(
      id: jsonSerialization['id'] as int?,
      staffUserId: jsonSerialization['staffUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['staffUserId'],
            ),
      staffUser: jsonSerialization['staffUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['staffUser'],
            ),
      customerUserId: jsonSerialization['customerUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['customerUserId'],
            ),
      customerUser: jsonSerialization['customerUser'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.AppUserRecord>(
              jsonSerialization['customerUser'],
            ),
      handledAt: jsonSerialization['handledAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['handledAt']),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.OrderStatus.fromJson((jsonSerialization['status'] as String)),
      ticketNumber: jsonSerialization['ticketNumber'] as int?,
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

  _i1.UuidValue? staffUserId;

  /// The staff member who took this order at the counter. Null for an
  /// online order -- see [customerUser].
  _i3.AppUserRecord? staffUser;

  _i1.UuidValue? customerUserId;

  /// The customer who placed this order themselves, if it's an online
  /// order. This (not a separate "source" flag) is what distinguishes an
  /// online order from a counter one -- exactly one of [staffUser]/
  /// [customerUser] is ever set.
  _i3.AppUserRecord? customerUser;

  /// When staff became aware of/processed this order. Set to [createdAt]
  /// itself for a counter order -- staff creating it in person *is*
  /// handling it -- so only an online order is ever actually null here,
  /// which is what makes a plain `handledAt == null` filter enough to
  /// drive both the staff notification badge and the Online Orders queue
  /// (see OnlineOrderManagementEndpoint.listUnhandled).
  DateTime? handledAt;

  _i2.OrderStatus status;

  /// A short, printable customer-facing sequence -- 1..100, wrapping back
  /// to 1 -- resetting every restaurant-local day. Distinct from `id`
  /// (which never resets and just keeps growing): this is what's called
  /// out to a customer and printed large on the ticket. See
  /// ticket_numbering.dart for how it's assigned.
  int ticketNumber;

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
    _i1.UuidValue? customerUserId,
    _i3.AppUserRecord? customerUser,
    DateTime? handledAt,
    _i2.OrderStatus? status,
    int? ticketNumber,
    int? subtotalMillimes,
    int? totalMillimes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderRecord',
      if (id != null) 'id': id,
      if (staffUserId != null) 'staffUserId': staffUserId?.toJson(),
      if (staffUser != null) 'staffUser': staffUser?.toJson(),
      if (customerUserId != null) 'customerUserId': customerUserId?.toJson(),
      if (customerUser != null) 'customerUser': customerUser?.toJson(),
      if (handledAt != null) 'handledAt': handledAt?.toJson(),
      'status': status.toJson(),
      'ticketNumber': ticketNumber,
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
    _i1.UuidValue? staffUserId,
    _i3.AppUserRecord? staffUser,
    _i1.UuidValue? customerUserId,
    _i3.AppUserRecord? customerUser,
    DateTime? handledAt,
    _i2.OrderStatus? status,
    int? ticketNumber,
    required int subtotalMillimes,
    required int totalMillimes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         staffUserId: staffUserId,
         staffUser: staffUser,
         customerUserId: customerUserId,
         customerUser: customerUser,
         handledAt: handledAt,
         status: status,
         ticketNumber: ticketNumber,
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
    Object? staffUserId = _Undefined,
    Object? staffUser = _Undefined,
    Object? customerUserId = _Undefined,
    Object? customerUser = _Undefined,
    Object? handledAt = _Undefined,
    _i2.OrderStatus? status,
    int? ticketNumber,
    int? subtotalMillimes,
    int? totalMillimes,
    DateTime? createdAt,
  }) {
    return OrderRecord(
      id: id is int? ? id : this.id,
      staffUserId: staffUserId is _i1.UuidValue?
          ? staffUserId
          : this.staffUserId,
      staffUser: staffUser is _i3.AppUserRecord?
          ? staffUser
          : this.staffUser?.copyWith(),
      customerUserId: customerUserId is _i1.UuidValue?
          ? customerUserId
          : this.customerUserId,
      customerUser: customerUser is _i3.AppUserRecord?
          ? customerUser
          : this.customerUser?.copyWith(),
      handledAt: handledAt is DateTime? ? handledAt : this.handledAt,
      status: status ?? this.status,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      subtotalMillimes: subtotalMillimes ?? this.subtotalMillimes,
      totalMillimes: totalMillimes ?? this.totalMillimes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
