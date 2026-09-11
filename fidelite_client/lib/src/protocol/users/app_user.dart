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
import 'package:fidelite_client/src/protocol/protocol.dart' as _i2;

/// An app user, mirrored from Keycloak on login. Keycloak remains the only
/// identity provider and source of truth for credentials/roles per request
/// (see keycloak_authentication_handler.dart) — this table exists so other
/// records (orders, points ledger, redemptions) have something to relate to,
/// plus lightweight denormalized fields for convenience (e.g. an admin
/// listing "all customers" without calling out to Keycloak).
abstract class AppUserRecord implements _i1.SerializableModel {
  AppUserRecord._({
    this.id,
    required this.username,
    this.email,
    this.fullName,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppUserRecord({
    _i1.UuidValue? id,
    required String username,
    String? email,
    String? fullName,
    required List<String> roles,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AppUserRecordImpl;

  factory AppUserRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUserRecord(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      username: jsonSerialization['username'] as String,
      email: jsonSerialization['email'] as String?,
      fullName: jsonSerialization['fullName'] as String?,
      roles: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['roles'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// Equal to the Keycloak subject ("sub" claim) — always set explicitly
  /// from Keycloak in code, never actually DB-generated. The generator
  /// requires a default for any UuidValue id field regardless.
  _i1.UuidValue? id;

  String username;

  String? email;

  String? fullName;

  /// Snapshot of the Keycloak realm roles at last login. Not the
  /// authorization source of truth — the JWT is, checked per request.
  List<String> roles;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AppUserRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppUserRecord copyWith({
    _i1.UuidValue? id,
    String? username,
    String? email,
    String? fullName,
    List<String>? roles,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUserRecord',
      if (id != null) 'id': id?.toJson(),
      'username': username,
      if (email != null) 'email': email,
      if (fullName != null) 'fullName': fullName,
      'roles': roles.toJson(),
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

class _AppUserRecordImpl extends AppUserRecord {
  _AppUserRecordImpl({
    _i1.UuidValue? id,
    required String username,
    String? email,
    String? fullName,
    required List<String> roles,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         username: username,
         email: email,
         fullName: fullName,
         roles: roles,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AppUserRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppUserRecord copyWith({
    Object? id = _Undefined,
    String? username,
    Object? email = _Undefined,
    Object? fullName = _Undefined,
    List<String>? roles,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUserRecord(
      id: id is _i1.UuidValue? ? id : this.id,
      username: username ?? this.username,
      email: email is String? ? email : this.email,
      fullName: fullName is String? ? fullName : this.fullName,
      roles: roles ?? this.roles.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
