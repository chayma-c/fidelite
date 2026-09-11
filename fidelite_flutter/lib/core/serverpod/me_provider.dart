import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'serverpod_client_provider.dart';

/// Fetches the backend's view of the signed-in user. Phase-0 purpose: prove
/// the Keycloak JWT actually reaches the Serverpod backend, gets validated,
/// and JIT-provisions an [AppUserRecord] — visible end-to-end in the app,
/// not just via curl. Not load-bearing after that: the client already knows
/// its own roles from the decoded ID token (see `AuthController`).
final meProvider = FutureProvider.autoDispose<AppUserRecord>((ref) {
  return ref.watch(serverpodClientProvider).user.getMe();
});
