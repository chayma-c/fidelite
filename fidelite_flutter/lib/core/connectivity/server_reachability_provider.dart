import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../serverpod/serverpod_client_provider.dart';

/// Whether the backend itself has actually answered recently -- as opposed
/// to [isOnlineProvider], which only knows whether a network interface is
/// up. `unknown` is the brief window right after the app starts, before the
/// first check has come back.
enum ServerReachability { unknown, online, offline }

/// Periodically pings the backend (a plain `getMe` call -- cheap, already
/// authenticated, no side effects) so the app has a real answer to "is the
/// server actually reachable right now" instead of just guessing from the
/// OS network state. This is the *only* thing on a recurring timer; every
/// other screen's data refresh piggybacks on a transition here rather than
/// polling independently, which is what keeps total server traffic to a
/// bare minimum instead of every cached screen checking on its own clock.
class ServerReachabilityController extends AutoDisposeNotifier<ServerReachability> {
  static const _checkInterval = Duration(seconds: 60);

  Timer? _timer;

  @override
  ServerReachability build() {
    ref.onDispose(() => _timer?.cancel());
    _timer = Timer.periodic(_checkInterval, (_) => checkNow());
    unawaited(checkNow());
    return ServerReachability.unknown;
  }

  Future<void> checkNow() async {
    try {
      await ref.read(serverpodClientProvider).user.getMe();
      state = ServerReachability.online;
    } catch (_) {
      state = ServerReachability.offline;
    }
  }
}

final serverReachabilityProvider =
    AutoDisposeNotifierProvider<ServerReachabilityController, ServerReachability>(
      ServerReachabilityController.new,
    );
