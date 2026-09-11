import 'package:jose/jose.dart';

import '../config/app_config.dart';

/// Verifies Keycloak-issued bearer tokens against the realm's JWKS.
///
/// [JsonWebKeyStore.addKeySetUrl] fetches and caches Keycloak's public keys
/// itself (including re-fetching on a `kid` cache-miss), so key rotation
/// doesn't need to be handled here.
class KeycloakJwtValidator {
  KeycloakJwtValidator()
    : _keyStore = JsonWebKeyStore()
        ..addKeySetUrl(Uri.parse(AppConfig.keycloakJwksUri));

  final JsonWebKeyStore _keyStore;

  /// Returns the token's verified claims, or null if the token is invalid,
  /// expired, from the wrong issuer, or not issued for our client.
  ///
  /// Note: this Keycloak realm's tokens carry no `aud` claim, only `azp`
  /// (confirmed against a real token from the running dev realm) — so the
  /// client is checked via `azp`, not jose's built-in `clientId`/`aud` check.
  Future<JsonWebTokenClaims?> verify(String token) async {
    final JsonWebToken jwt;
    try {
      jwt = await JsonWebToken.decodeAndVerify(token, _keyStore);
    } catch (_) {
      return null;
    }

    final claims = jwt.claims;
    final violations = claims
        .validate(issuer: Uri.parse(AppConfig.keycloakIssuer))
        .toList();
    if (violations.isNotEmpty) return null;

    if (claims['azp'] != AppConfig.keycloakClientId) return null;
    if (claims.subject == null || claims.subject!.isEmpty) return null;

    return claims;
  }
}
