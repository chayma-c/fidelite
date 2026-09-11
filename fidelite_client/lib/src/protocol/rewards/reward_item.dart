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

/// A catalog item redeemable for cashback. Deliberately a separate catalog
/// from the cash menu (not "spend balance as a discount on any menu item")
/// -- confirmed as the desired model up front -- currently seeded as a
/// mirror of the menu at its normal prices, but independent going forward:
/// editing a reward here never affects menu pricing or vice versa.
abstract class RewardItemRecord implements _i1.SerializableModel {
  RewardItemRecord._({
    this.id,
    required this.name,
    this.description,
    required this.pointsCost,
    bool? isActive,
    this.stock,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory RewardItemRecord({
    int? id,
    required String name,
    String? description,
    required int pointsCost,
    bool? isActive,
    int? stock,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RewardItemRecordImpl;

  factory RewardItemRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return RewardItemRecord(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      pointsCost: jsonSerialization['pointsCost'] as int,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      stock: jsonSerialization['stock'] as int?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? description;

  /// In millimes, same unit as the cashback balance itself.
  int pointsCost;

  /// Soft-disable instead of delete, so historical redemptions keep valid
  /// references (see RedemptionRecord's name/cost snapshot fields).
  bool isActive;

  /// Remaining redemptions available, or null for unlimited. Nothing
  /// decrements this yet -- reserved for a future limited-reward feature.
  int? stock;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [RewardItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RewardItemRecord copyWith({
    int? id,
    String? name,
    String? description,
    int? pointsCost,
    bool? isActive,
    int? stock,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RewardItemRecord',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'pointsCost': pointsCost,
      'isActive': isActive,
      if (stock != null) 'stock': stock,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RewardItemRecordImpl extends RewardItemRecord {
  _RewardItemRecordImpl({
    int? id,
    required String name,
    String? description,
    required int pointsCost,
    bool? isActive,
    int? stock,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         description: description,
         pointsCost: pointsCost,
         isActive: isActive,
         stock: stock,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RewardItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RewardItemRecord copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? pointsCost,
    bool? isActive,
    Object? stock = _Undefined,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RewardItemRecord(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      pointsCost: pointsCost ?? this.pointsCost,
      isActive: isActive ?? this.isActive,
      stock: stock is int? ? stock : this.stock,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
