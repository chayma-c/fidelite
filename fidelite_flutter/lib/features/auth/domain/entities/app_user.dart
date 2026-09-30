import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';

/// The authenticated end-user. [id] and [roles] are derived straight from
/// the current Serverpod auth session (see AuthController) -- they're the
/// only fields anything in the app actually reads (role-based routing in
/// app_router.dart, the wallet QR payload in wallet_qr_controller.dart).
class AppUser {
  const AppUser({required this.id, required this.roles});

  static const _rolePrefix = 'role:';

  factory AppUser.fromAuthSuccess(AuthSuccess authInfo) => AppUser(
    id: authInfo.authUserId.toString(),
    roles: authInfo.scopeNames
        .where((scope) => scope.startsWith(_rolePrefix))
        .map((scope) => scope.substring(_rolePrefix.length))
        .toSet(),
  );

  final String id;
  final Set<String> roles;

  bool hasRole(String role) => roles.contains(role);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          id == other.id &&
          roles.length == other.roles.length &&
          roles.containsAll(other.roles));

  @override
  int get hashCode => Object.hash(id, Object.hashAllUnordered(roles));
}
