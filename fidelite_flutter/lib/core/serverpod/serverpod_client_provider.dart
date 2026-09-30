import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';

import '../config/app_config.dart';

final serverpodClientProvider = Provider<Client>((ref) {
  final client = Client(AppConfig.serverpodBaseUrl);
  // Handles session persistence/refresh for every auth strategy the backend
  // exposes (here, just email/password) -- see AuthController for how the
  // rest of the app reacts to its state.
  client.authSessionManager = FlutterAuthSessionManager();
  ref.onDispose(client.close);
  return client;
});
