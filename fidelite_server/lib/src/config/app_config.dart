import 'dart:io';

/// Server-side configuration read from environment variables — the Dart
/// server's equivalent of the Flutter app's `AppConfig` (which reads
/// `--dart-define` values). Nothing Keycloak-specific is hard-coded here;
/// see SETUP.md for how to set these before running the server.
abstract final class AppConfig {
  static String get keycloakIssuer => _require('KEYCLOAK_ISSUER');
  static String get keycloakClientId => _require('KEYCLOAK_CLIENT_ID');

  static String get keycloakJwksUri =>
      '$keycloakIssuer/protocol/openid-connect/certs';

  static String _require(String key) {
    final value = Platform.environment[key];
    if (value == null || value.isEmpty) {
      throw StateError(
        'Missing required environment variable "$key". See SETUP.md for '
        'how to run the server.',
      );
    }
    return value;
  }
}
