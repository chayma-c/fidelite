import 'package:jwt_decoder/jwt_decoder.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/repositories/auth_repository.dart';
import '../access_token_provider.dart';
import '../datasources/oidc_datasource.dart';
import '../datasources/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required OidcDataSource oidcDataSource,
    required TokenStorage tokenStorage,
    required AccessTokenProvider accessTokenProvider,
  }) : _oidc = oidcDataSource,
       _storage = tokenStorage,
       // ignore: prefer_initializing_formals
       _accessTokenProvider = accessTokenProvider;

  final OidcDataSource _oidc;
  final TokenStorage _storage;
  final AccessTokenProvider _accessTokenProvider;

  @override
  Future<AppUser?> restoreSession() async {
    final tokens = await _accessTokenProvider.getValidTokens();
    if (tokens == null) return null;
    return _userFrom(tokens);
  }

  @override
  Future<AppUser> signIn() async {
    final tokens = await _oidc.authenticate();
    await _storage.save(tokens);
    return _userFrom(tokens);
  }

  @override
  Future<void> signOut() async {
    final tokens = await _storage.read();
    await _storage.clear();
    if (tokens != null) {
      await _oidc.endSession(tokens.idToken);
    }
  }

  AppUser _userFrom(AuthTokens tokens) =>
      AppUser.fromIdTokenClaims(JwtDecoder.decode(tokens.idToken));
}
