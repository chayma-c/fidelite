import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'serverpod_client_provider.dart';

/// Fetches the backend's own profile row for the signed-in user (username,
/// email). Not load-bearing for routing/authorization -- the client already
/// has its own id/roles from the auth session (see `AuthController`); this
/// is only for screens that want to display account details.
final meProvider = FutureProvider.autoDispose<AppUserRecord>((ref) {
  return ref.watch(serverpodClientProvider).user.getMe();
});
