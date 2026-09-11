import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/serverpod/serverpod_client_provider.dart';

/// Current cashback balance, in millimes. Always the sum of the customer's
/// points ledger entries server-side -- not a cached column -- so this is
/// re-fetched (via [claimControllerProvider]'s invalidation) after every
/// successful claim rather than updated optimistically client-side.
final balanceProvider = FutureProvider.autoDispose<int>((ref) {
  return ref.watch(serverpodClientProvider).wallet.getBalance();
});

final pointsHistoryProvider = FutureProvider.autoDispose<
  List<PointsLedgerEntryRecord>
>((ref) {
  // The generated client doesn't carry over the server-side default for
  // `limit` -- Serverpod's codegen makes every endpoint parameter required
  // on the client stub regardless of a default on the server method, so
  // this always has to be passed explicitly.
  return ref.watch(serverpodClientProvider).wallet.getPointsHistory(limit: 50);
});
