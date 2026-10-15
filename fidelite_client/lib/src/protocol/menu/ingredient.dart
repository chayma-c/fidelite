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
import '../menu/ingredient_kind.dart' as _i2;

/// A customization option offered when ordering a sandwich/malfouf/chapati
/// item -- either part of the fixed base recipe the customer can ask to
/// leave out ("menghir"/without, in the local dialect), or an optional
/// sauce they can add on top. Plain editable catalog data rather than
/// hardcoded in the app, so the base recipe or sauce list can change
/// without a code change.
abstract class IngredientRecord implements _i1.SerializableModel {
  IngredientRecord._({
    this.id,
    required this.name,
    required this.kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory IngredientRecord({
    int? id,
    required String name,
    required _i2.IngredientKind kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _IngredientRecordImpl;

  factory IngredientRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngredientRecord(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      kind: _i2.IngredientKind.fromJson((jsonSerialization['kind'] as String)),
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

  _i2.IngredientKind kind;

  /// Soft-disable instead of delete, so a historical order's snapshotted
  /// ingredient names (see OrderItemRecord) stay meaningful even after an
  /// ingredient is retired from the catalog.
  bool isActive;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [IngredientRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  IngredientRecord copyWith({
    int? id,
    String? name,
    _i2.IngredientKind? kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngredientRecord',
      if (id != null) 'id': id,
      'name': name,
      'kind': kind.toJson(),
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

class _IngredientRecordImpl extends IngredientRecord {
  _IngredientRecordImpl({
    int? id,
    required String name,
    required _i2.IngredientKind kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         kind: kind,
         isActive: isActive,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [IngredientRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  IngredientRecord copyWith({
    Object? id = _Undefined,
    String? name,
    _i2.IngredientKind? kind,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IngredientRecord(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
