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

/// A purchasable item on the restaurant's menu.
abstract class MenuItemRecord implements _i1.SerializableModel {
  MenuItemRecord._({
    this.id,
    required this.name,
    this.description,
    required this.priceMillimes,
    required this.category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory MenuItemRecord({
    int? id,
    required String name,
    String? description,
    required int priceMillimes,
    required String category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MenuItemRecordImpl;

  factory MenuItemRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuItemRecord(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      priceMillimes: jsonSerialization['priceMillimes'] as int,
      category: jsonSerialization['category'] as String,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
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

  /// Price in millimes (1 Tunisian Dinar = 1000 millimes), matching the
  /// 3-decimal pricing on the physical menu (e.g. "3.000 DT").
  int priceMillimes;

  /// Menu section, e.g. "Chapati", "Sandwich", "Plats". Plain string for
  /// now rather than a separate category table -- the menu is still
  /// settling, and this keeps re-labelling cheap.
  String category;

  /// Soft-disable instead of delete, so historical orders keep valid
  /// references (see OrderItemRecord's name/price snapshot fields).
  bool isActive;

  /// Display order within a category.
  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [MenuItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MenuItemRecord copyWith({
    int? id,
    String? name,
    String? description,
    int? priceMillimes,
    String? category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuItemRecord',
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      'priceMillimes': priceMillimes,
      'category': category,
      'isActive': isActive,
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

class _MenuItemRecordImpl extends MenuItemRecord {
  _MenuItemRecordImpl({
    int? id,
    required String name,
    String? description,
    required int priceMillimes,
    required String category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         description: description,
         priceMillimes: priceMillimes,
         category: category,
         isActive: isActive,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MenuItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MenuItemRecord copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    int? priceMillimes,
    String? category,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MenuItemRecord(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      priceMillimes: priceMillimes ?? this.priceMillimes,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
