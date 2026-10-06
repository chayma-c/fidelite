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

/// Singleton row (see online_order_settings_util.dart for the same
/// lazy-create pattern as ShopStatusRecord) holding staff-only operational
/// settings for online orders. Deliberately separate from ShopStatusRecord
/// even though both are "shop settings" -- that one is public (customers
/// read it), this one is staff-internal only.
abstract class OnlineOrderSettingsRecord implements _i1.SerializableModel {
  OnlineOrderSettingsRecord._({
    this.id,
    bool? autoPrintEnabled,
    DateTime? updatedAt,
  }) : autoPrintEnabled = autoPrintEnabled ?? false,
       updatedAt = updatedAt ?? DateTime.now();

  factory OnlineOrderSettingsRecord({
    int? id,
    bool? autoPrintEnabled,
    DateTime? updatedAt,
  }) = _OnlineOrderSettingsRecordImpl;

  factory OnlineOrderSettingsRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OnlineOrderSettingsRecord(
      id: jsonSerialization['id'] as int?,
      autoPrintEnabled: jsonSerialization['autoPrintEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['autoPrintEnabled'],
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

  /// Whether a new online order should print automatically the moment
  /// staff's device notices it, instead of sitting in the Online Orders
  /// queue for a manual tap. Off by default -- auto-printing everything
  /// unconditionally is exactly what caused problems when staff were
  /// already busy taking counter orders.
  bool autoPrintEnabled;

  DateTime updatedAt;

  /// Returns a shallow copy of this [OnlineOrderSettingsRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OnlineOrderSettingsRecord copyWith({
    int? id,
    bool? autoPrintEnabled,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OnlineOrderSettingsRecord',
      if (id != null) 'id': id,
      'autoPrintEnabled': autoPrintEnabled,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OnlineOrderSettingsRecordImpl extends OnlineOrderSettingsRecord {
  _OnlineOrderSettingsRecordImpl({
    int? id,
    bool? autoPrintEnabled,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         autoPrintEnabled: autoPrintEnabled,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [OnlineOrderSettingsRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OnlineOrderSettingsRecord copyWith({
    Object? id = _Undefined,
    bool? autoPrintEnabled,
    DateTime? updatedAt,
  }) {
    return OnlineOrderSettingsRecord(
      id: id is int? ? id : this.id,
      autoPrintEnabled: autoPrintEnabled ?? this.autoPrintEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
