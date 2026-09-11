import '../entities/app_user.dart';

abstract interface class AuthRepository {
  /// Attempts to restore a previously persisted session, transparently
  /// refreshing the access token if it has expired. Returns null if there is
  /// no valid session to restore.
  Future<AppUser?> restoreSession();

  /// Launches Keycloak's hosted login page (Authorization Code + PKCE) and
  /// returns the authenticated user on success.
  Future<AppUser> signIn();

  /// Clears the local session and ends the SSO session on Keycloak.
  Future<void> signOut();
}
