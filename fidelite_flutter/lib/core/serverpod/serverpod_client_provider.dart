import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/data/auth_providers.dart';
import '../config/app_config.dart';
import 'keycloak_auth_key_provider.dart';

final serverpodClientProvider = Provider<Client>((ref) {
  final client = Client(AppConfig.serverpodBaseUrl);
  client.authKeyProvider = MutexRefresherClientAuthKeyProvider(
    KeycloakAuthKeyProvider(ref.watch(accessTokenProviderProvider)),
  );
  ref.onDispose(client.close);
  return client;
});
