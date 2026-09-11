import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/serverpod/serverpod_client_provider.dart';

/// The active reward catalog, shared by the customer's browsing page and
/// staff's redemption reward-picker.
final rewardsCatalogProvider = FutureProvider.autoDispose<
  List<RewardItemRecord>
>((ref) {
  return ref.watch(serverpodClientProvider).rewards.getCatalog();
});
