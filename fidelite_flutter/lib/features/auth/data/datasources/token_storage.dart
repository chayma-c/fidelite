import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/auth_tokens.dart';

/// Persists OIDC tokens using platform-appropriate secure storage: Keychain
/// on iOS, Keystore-backed EncryptedSharedPreferences on Android, and
/// WebCrypto-encrypted storage on web.
class TokenStorage {
  TokenStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const _tokensKey = 'fidelite.auth.tokens';

  final FlutterSecureStorage _storage;

  Future<void> save(AuthTokens tokens) {
    final json = jsonEncode({
      'accessToken': tokens.accessToken,
      'idToken': tokens.idToken,
      'refreshToken': tokens.refreshToken,
      'accessTokenExpiry': tokens.accessTokenExpiry.toIso8601String(),
    });
    return _storage.write(key: _tokensKey, value: json);
  }

  Future<AuthTokens?> read() async {
    final raw = await _storage.read(key: _tokensKey);
    if (raw == null) return null;
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return AuthTokens(
      accessToken: json['accessToken'] as String,
      idToken: json['idToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      accessTokenExpiry: DateTime.parse(json['accessTokenExpiry'] as String),
    );
  }

  Future<void> clear() => _storage.delete(key: _tokensKey);
}
