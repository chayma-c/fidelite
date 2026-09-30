import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether a network interface is currently up. Drives the offline banner
/// and triggers pending-order sync on reconnect -- it is a hint, not a
/// guarantee the backend itself is reachable, so actual RPC success/failure
/// remains the real signal for that; this just tells the app roughly when
/// it's worth trying again.
final isOnlineProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();
  bool isOnline(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);

  yield isOnline(await connectivity.checkConnectivity());
  yield* connectivity.onConnectivityChanged.map(isOnline);
});
