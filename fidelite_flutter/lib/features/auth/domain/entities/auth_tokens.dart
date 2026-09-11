/// The OIDC token set issued by Keycloak for the current session.
class AuthTokens {
  const AuthTokens({
    required this.accessToken,
    required this.idToken,
    required this.refreshToken,
    required this.accessTokenExpiry,
  });

  final String accessToken;
  final String idToken;
  final String? refreshToken;
  final DateTime accessTokenExpiry;

  /// True once the access token is expired or within 30s of expiring, so
  /// callers refresh proactively rather than racing a failed request.
  bool get isAccessTokenExpired => DateTime.now().isAfter(
    accessTokenExpiry.subtract(const Duration(seconds: 30)),
  );
}
