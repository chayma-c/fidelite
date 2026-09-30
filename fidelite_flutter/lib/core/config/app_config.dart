/// Compile-time application configuration.
///
/// Nothing here is hard-coded: every value is injected at build/run time via
/// `--dart-define-from-file=env/<file>.json` (copy `env/env.example.json`
/// first). See SETUP.md.
abstract final class AppConfig {
  static const String environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static const String serverpodBaseUrl = String.fromEnvironment(
    'SERVERPOD_BASE_URL',
  );

  /// Fails fast with a clear message instead of the app silently trying to
  /// reach an empty URL when the env file was not supplied.
  static void ensureConfigured() {
    if (serverpodBaseUrl.isNotEmpty) return;
    throw StateError(
      'Missing required configuration: SERVERPOD_BASE_URL.\n'
      'Run with --dart-define-from-file=env/dev.json '
      '(copy env/env.example.json first if it does not exist). See SETUP.md.',
    );
  }
}
