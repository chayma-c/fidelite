import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/serverpod/serverpod_client_provider.dart';

/// The active menu, grouped/sorted server-side by category then
/// [MenuItemRecord.sortOrder]. Uses the generated [MenuItemRecord] directly
/// as the domain type here -- Serverpod's protocol classes already are the
/// shared model between client and server, so a parallel wrapper entity
/// would just duplicate it.
final menuProvider = FutureProvider.autoDispose<List<MenuItemRecord>>((ref) {
  return ref.watch(serverpodClientProvider).menu.getMenu();
});
