import 'dart:async';

import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';

import '../../../../core/notifications/push_notification_service.dart';
import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_state.dart';

/// Mirrors the Serverpod client's auth session into an [AuthState] the
/// router and UI can react to. `FlutterAuthSessionManager` (see
/// serverpod_client_provider.dart) already does the real work -- restoring
/// a persisted session, refreshing tokens, and updating itself after a
/// successful login/registration/sign-out (each driven directly by
/// `EmailAuthController` in the auth UI, not through this class) -- so this
/// is just a thin reactive bridge, not an orchestrator.
class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    final client = ref.watch(serverpodClientProvider);

    void listener() => _syncFromAuthInfo(client.auth.authInfo);
    client.auth.authInfoListenable.addListener(listener);
    ref.onDispose(() => client.auth.authInfoListenable.removeListener(listener));

    unawaited(_restore(client));
    return const AuthInitial();
  }

  Future<void> _restore(Client client) async {
    try {
      await client.auth.initialize();
    } catch (_) {
      // `initialize()` both restores the locally persisted session and
      // then validates it with the server; a network failure on that
      // second step shouldn't throw away a perfectly good cached session
      // the first step already loaded -- fall through and sync from
      // whatever `authInfo` holds either way.
    }
    _syncFromAuthInfo(client.auth.authInfo);
  }

  void _syncFromAuthInfo(AuthSuccess? authInfo) {
    state = authInfo == null
        ? const AuthUnauthenticated()
        : AuthAuthenticated(AppUser.fromAuthSuccess(authInfo));

    // Fires on every genuine auth change (sign-in, restore, token refresh),
    // not on every rebuild -- this listener only runs when
    // authInfoListenable itself notifies. registerForStaffDevice() is a
    // no-op off Android and idempotent server-side (upsert by user), so
    // there's no real cost to it running again on an already-registered
    // device.
    if (state case AuthAuthenticated(user: final user)
        when user.hasRole('staff')) {
      unawaited(
        ref.read(pushNotificationServiceProvider).registerForStaffDevice(),
      );
    }
  }

  Future<void> signOut() async {
    state = const AuthAuthenticating();
    // Always leaves the device signed out locally, even on failure -- the
    // listener above will pick up the resulting null auth info.
    await ref.read(serverpodClientProvider).auth.signOutDevice();
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
