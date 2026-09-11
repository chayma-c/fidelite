import 'package:flutter/foundation.dart' show kIsWeb;

/// Compile-time application configuration.
///
/// Nothing here is hard-coded: every value is injected at build/run time via
/// `--dart-define-from-file=env/<file>.json` (copy `env/env.example.json`
/// first). See SETUP.md for platform-specific notes (e.g. Android emulators
/// must reach the host's Keycloak via `10.0.2.2`, not `localhost`).
abstract final class AppConfig {
  static const String environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static const String keycloakBaseUrl = String.fromEnvironment(
    'KEYCLOAK_BASE_URL',
  );
  static const String keycloakRealm = String.fromEnvironment('KEYCLOAK_REALM');
  static const String keycloakClientId = String.fromEnvironment(
    'KEYCLOAK_CLIENT_ID',
  );

  static const String _mobileRedirectScheme = String.fromEnvironment(
    'OAUTH_REDIRECT_SCHEME_MOBILE',
  );
  static const String _webRedirectUri = String.fromEnvironment(
    'OAUTH_REDIRECT_URI_WEB',
  );

  static const String serverpodBaseUrl = String.fromEnvironment(
    'SERVERPOD_BASE_URL',
  );

  /// The realm's OpenID Connect issuer, e.g. `http://localhost:8080/realms/fidelite`.
  static String get keycloakIssuer => '$keycloakBaseUrl/realms/$keycloakRealm';

  /// The redirect URI to hand to Keycloak for the current platform. Must be
  /// registered verbatim in the realm client's "Valid redirect URIs".
  static String get oauthRedirectUri =>
      kIsWeb ? _webRedirectUri : '$_mobileRedirectScheme:/oauthredirect';

  /// The scheme `flutter_web_auth_2` watches for to detect the OAuth
  /// redirect coming back from the browser/webview.
  static String get oauthCallbackUrlScheme =>
      kIsWeb ? Uri.parse(_webRedirectUri).scheme : _mobileRedirectScheme;

  /// Fails fast with a clear message instead of the app silently trying to
  /// reach an empty URL when the env file was not supplied.
  static void ensureConfigured() {
    final missing = <String>[
      if (keycloakBaseUrl.isEmpty) 'KEYCLOAK_BASE_URL',
      if (keycloakRealm.isEmpty) 'KEYCLOAK_REALM',
      if (keycloakClientId.isEmpty) 'KEYCLOAK_CLIENT_ID',
      if (_mobileRedirectScheme.isEmpty) 'OAUTH_REDIRECT_SCHEME_MOBILE',
      if (_webRedirectUri.isEmpty) 'OAUTH_REDIRECT_URI_WEB',
      if (serverpodBaseUrl.isEmpty) 'SERVERPOD_BASE_URL',
    ];
    if (missing.isEmpty) return;
    throw StateError(
      'Missing required configuration: ${missing.join(', ')}.\n'
      'Run with --dart-define-from-file=env/dev.json '
      '(copy env/env.example.json first if it does not exist). See SETUP.md.',
    );
  }
}
