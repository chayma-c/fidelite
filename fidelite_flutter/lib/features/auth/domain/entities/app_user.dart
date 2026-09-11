/// The authenticated end-user, derived from the OIDC ID token claims.
class AppUser {
  const AppUser({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.roles,
  });

  factory AppUser.fromIdTokenClaims(Map<String, dynamic> claims) {
    final realmAccess = claims['realm_access'] as Map<String, dynamic>?;
    final roles =
        (realmAccess?['roles'] as List<dynamic>?)?.cast<String>() ??
        const <String>[];
    return AppUser(
      id: claims['sub'] as String,
      username: claims['preferred_username'] as String? ?? '',
      email: claims['email'] as String?,
      fullName: claims['name'] as String?,
      roles: roles,
    );
  }

  final String id;
  final String username;
  final String? email;
  final String? fullName;
  final List<String> roles;

  bool hasRole(String role) => roles.contains(role);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          id == other.id &&
          username == other.username &&
          email == other.email &&
          fullName == other.fullName &&
          roles.length == other.roles.length &&
          roles.every(other.roles.contains));

  @override
  int get hashCode =>
      Object.hash(id, username, email, fullName, Object.hashAllUnordered(roles));
}
