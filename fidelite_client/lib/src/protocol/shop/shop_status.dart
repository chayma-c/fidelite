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
import '../shop/shop_open_status.dart' as _i2;

/// Singleton row (there's only ever one, created lazily on first read/
/// write -- see shop_status_util.dart) tracking the restaurant's current
/// open/closed/break status.
abstract class ShopStatusRecord implements _i1.SerializableModel {
  ShopStatusRecord._({
    this.id,
    _i2.ShopOpenStatus? status,
    DateTime? updatedAt,
  }) : status = status ?? _i2.ShopOpenStatus.open,
       updatedAt = updatedAt ?? DateTime.now();

  factory ShopStatusRecord({
    int? id,
    _i2.ShopOpenStatus? status,
    DateTime? updatedAt,
  }) = _ShopStatusRecordImpl;

  factory ShopStatusRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopStatusRecord(
      id: jsonSerialization['id'] as int?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.ShopOpenStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.ShopOpenStatus status;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ShopStatusRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ShopStatusRecord copyWith({
    int? id,
    _i2.ShopOpenStatus? status,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopStatusRecord',
      if (id != null) 'id': id,
      'status': status.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShopStatusRecordImpl extends ShopStatusRecord {
  _ShopStatusRecordImpl({
    int? id,
    _i2.ShopOpenStatus? status,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         status: status,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ShopStatusRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ShopStatusRecord copyWith({
    Object? id = _Undefined,
    _i2.ShopOpenStatus? status,
    DateTime? updatedAt,
  }) {
    return ShopStatusRecord(
      id: id is int? ? id : this.id,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
