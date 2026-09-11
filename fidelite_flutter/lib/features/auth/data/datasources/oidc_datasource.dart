import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/app_config.dart';
import '../../domain/entities/auth_tokens.dart';

/// Drives the OpenID Connect Authorization Code + PKCE flow against
/// Keycloak.
///
/// A single implementation is shared by Android, iOS and Web:
/// `flutter_web_auth_2` opens Keycloak's hosted login page in a Custom Tab /
/// SFSafariViewController / browser popup and hands back the redirect URL,
/// while the code-for-token exchange itself is a plain, standard OAuth2 HTTP
/// call, so there is no platform-specific branching to maintain.
class OidcDataSource {
  OidcDataSource({http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  final http.Client _http;
  final Random _random = Random.secure();

  Uri get _authorizationEndpoint =>
      Uri.parse('${AppConfig.keycloakIssuer}/protocol/openid-connect/auth');

  Uri get _tokenEndpoint =>
      Uri.parse('${AppConfig.keycloakIssuer}/protocol/openid-connect/token');

  Uri get _endSessionEndpoint =>
      Uri.parse('${AppConfig.keycloakIssuer}/protocol/openid-connect/logout');

  Future<AuthTokens> authenticate() async {
    final codeVerifier = _generateCodeVerifier();
    final codeChallenge = _codeChallengeFor(codeVerifier);
    final state = _generateCodeVerifier();
    final redirectUri = AppConfig.oauthRedirectUri;

    final authUrl = _authorizationEndpoint.replace(
      queryParameters: {
        'response_type': 'code',
        'client_id': AppConfig.keycloakClientId,
        'redirect_uri': redirectUri,
        'scope': 'openid profile email',
        'code_challenge': codeChallenge,
        'code_challenge_method': 'S256',
        'state': state,
      },
    );

    final callbackUrl = await FlutterWebAuth2.authenticate(
      url: authUrl.toString(),
      callbackUrlScheme: AppConfig.oauthCallbackUrlScheme,
    );

    final callbackParams = Uri.parse(callbackUrl).queryParameters;
    if (callbackParams['state'] != state) {
      throw StateError(
        'OIDC state mismatch: possible CSRF, aborting sign-in.',
      );
    }
    final code = callbackParams['code'];
    if (code == null) {
      throw StateError(
        callbackParams['error_description'] ??
            callbackParams['error'] ??
            'Keycloak did not return an authorization code.',
      );
    }

    return _exchange({
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': redirectUri,
      'client_id': AppConfig.keycloakClientId,
      'code_verifier': codeVerifier,
    });
  }

  Future<AuthTokens> refresh(String refreshToken) => _exchange({
    'grant_type': 'refresh_token',
    'refresh_token': refreshToken,
    'client_id': AppConfig.keycloakClientId,
  });

  /// Ends the SSO session on Keycloak. Best-effort: the local session is
  /// always cleared by the caller regardless of whether this succeeds.
  Future<void> endSession(String idToken) async {
    final logoutUrl = _endSessionEndpoint.replace(
      queryParameters: {
        'id_token_hint': idToken,
        'post_logout_redirect_uri': AppConfig.oauthRedirectUri,
      },
    );
    try {
      await FlutterWebAuth2.authenticate(
        url: logoutUrl.toString(),
        callbackUrlScheme: AppConfig.oauthCallbackUrlScheme,
      );
    } catch (_) {
      // Ignored: remote logout is best-effort.
    }
  }

  Future<AuthTokens> _exchange(Map<String, String> body) async {
    final response = await _http.post(
      _tokenEndpoint,
      headers: const {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );

    if (response.statusCode != 200) {
      throw StateError(
        'Keycloak token request failed (${response.statusCode}): ${response.body}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final expiresInSeconds = json['expires_in'] as int;
    return AuthTokens(
      accessToken: json['access_token'] as String,
      idToken: json['id_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      accessTokenExpiry: DateTime.now().add(
        Duration(seconds: expiresInSeconds),
      ),
    );
  }

  String _generateCodeVerifier() {
    final bytes = List<int>.generate(64, (_) => _random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  String _codeChallengeFor(String codeVerifier) {
    final digest = sha256.convert(ascii.encode(codeVerifier));
    return base64UrlEncode(digest.bytes).replaceAll('=', '');
  }
}
