import 'package:serverpod_client/serverpod_client.dart';

import '../../features/auth/data/access_token_provider.dart';

/// Attaches the app's Keycloak access token to every Serverpod API call,
/// refreshing it first if it's expired. Reuses [AccessTokenProvider] — the
/// same refresh path the router's [AuthController] uses to restore a
/// session on app start — so there is exactly one place that talks to
/// Keycloak's token endpoint.
class KeycloakAuthKeyProvider implements RefresherClientAuthKeyProvider {
  KeycloakAuthKeyProvider(this._accessTokenProvider);

  final AccessTokenProvider _accessTokenProvider;

  @override
  Future<String?> get authHeaderValue async {
    final tokens = await _accessTokenProvider.getValidTokens();
    if (tokens == null) return null;
    return wrapAsBearerAuthHeaderValue(tokens.accessToken);
  }

  @override
  Future<RefreshAuthKeyResult> refreshAuthKey({bool force = false}) async {
    final tokens = await _accessTokenProvider.getValidTokens();
    return tokens == null
        ? RefreshAuthKeyResult.failedUnauthorized
        : RefreshAuthKeyResult.success;
  }
}
