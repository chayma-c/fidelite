import 'package:jose/jose.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'keycloak_jwt_validator.dart';

final _validator = KeycloakJwtValidator();

/// Serverpod's [AuthenticationHandler]: validates the bearer token as a
/// Keycloak-issued JWT (see [KeycloakJwtValidator]) and, on success,
/// JIT-provisions/refreshes the local [AppUserRecord] and maps each Keycloak
/// realm role to a Serverpod [Scope] (`role:staff`, `role:customer`, ...)
/// that endpoints declare via `requiredScopes`.
Future<AuthenticationInfo?> keycloakAuthenticationHandler(
  Session session,
  String token,
) async {
  final claims = await _validator.verify(token);
  if (claims == null) return null;

  final roles =
      ((claims['realm_access'] as Map<String, dynamic>?)?['roles']
              as List<dynamic>?)
          ?.cast<String>() ??
      const <String>[];

  final userId = UuidValue.fromString(claims.subject!);
  await _upsertAppUser(session, userId, claims, roles);

  return AuthenticationInfo(
    userId.uuid,
    roles.map((role) => Scope('role:$role')).toSet(),
    authId: claims.jwtId ?? userId.uuid,
  );
}

Future<void> _upsertAppUser(
  Session session,
  UuidValue userId,
  JsonWebTokenClaims claims,
  List<String> roles,
) async {
  final now = DateTime.now().toUtc();
  final existing = await AppUserRecord.db.findById(session, userId);

  final record = AppUserRecord(
    id: userId,
    username: claims['preferred_username'] as String? ?? '',
    email: claims['email'] as String?,
    fullName: claims['name'] as String?,
    roles: roles,
    createdAt: existing?.createdAt ?? now,
    updatedAt: now,
  );

  if (existing == null) {
    await AppUserRecord.db.insertRow(session, record);
  } else {
    await AppUserRecord.db.updateRow(session, record);
  }
}
