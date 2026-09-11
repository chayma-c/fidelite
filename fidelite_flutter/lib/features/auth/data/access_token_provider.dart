import '../domain/entities/auth_tokens.dart';
import 'datasources/oidc_datasource.dart';
import 'datasources/token_storage.dart';

/// Single source of truth for "give me currently-valid tokens, refreshing
/// first if needed." Used both by [AuthRepositoryImpl] (to restore a
/// session on app start, and decode the ID token's claims) and by the
/// Serverpod client's auth key provider (to attach a bearer access token to
/// every API call) — one refresh implementation, two consumers.
class AccessTokenProvider {
  AccessTokenProvider({
    required OidcDataSource oidcDataSource,
    required TokenStorage tokenStorage,
  }) : _oidc = oidcDataSource,
       _storage = tokenStorage;

  final OidcDataSource _oidc;
  final TokenStorage _storage;

  /// Returns valid tokens, or null if there is no session or the refresh
  /// token turned out to be invalid (in which case the local session is
  /// cleared).
  Future<AuthTokens?> getValidTokens() async {
    var tokens = await _storage.read();
    if (tokens == null) return null;

    if (tokens.isAccessTokenExpired) {
      final refreshToken = tokens.refreshToken;
      if (refreshToken == null) {
        await _storage.clear();
        return null;
      }
      try {
        tokens = await _oidc.refresh(refreshToken);
        await _storage.save(tokens);
      } catch (_) {
        await _storage.clear();
        return null;
      }
    }

    return tokens;
  }
}
