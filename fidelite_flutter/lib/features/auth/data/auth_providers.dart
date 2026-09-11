import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repositories/auth_repository.dart';
import 'access_token_provider.dart';
import 'datasources/oidc_datasource.dart';
import 'datasources/token_storage.dart';
import 'repositories/auth_repository_impl.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

final oidcDataSourceProvider = Provider<OidcDataSource>(
  (ref) => OidcDataSource(),
);

final accessTokenProviderProvider = Provider<AccessTokenProvider>(
  (ref) => AccessTokenProvider(
    oidcDataSource: ref.watch(oidcDataSourceProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
  ),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    oidcDataSource: ref.watch(oidcDataSourceProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
    accessTokenProvider: ref.watch(accessTokenProviderProvider),
  ),
);
