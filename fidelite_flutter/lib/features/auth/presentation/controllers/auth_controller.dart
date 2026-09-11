import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth_providers.dart';
import '../../domain/entities/auth_state.dart';

/// Orchestrates sign-in / sign-out / session restoration and exposes the
/// current [AuthState] to the router and UI.
class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    unawaited(_restoreSession());
    return const AuthInitial();
  }

  Future<void> _restoreSession() async {
    try {
      final user = await ref.read(authRepositoryProvider).restoreSession();
      state = user != null
          ? AuthAuthenticated(user)
          : const AuthUnauthenticated();
    } catch (_) {
      state = const AuthUnauthenticated();
    }
  }

  Future<void> signIn() async {
    state = const AuthAuthenticating();
    try {
      final user = await ref.read(authRepositoryProvider).signIn();
      state = AuthAuthenticated(user);
    } catch (e) {
      state = AuthFailure(_messageFor(e));
    }
  }

  Future<void> signOut() async {
    state = const AuthAuthenticating();
    try {
      await ref.read(authRepositoryProvider).signOut();
    } finally {
      state = const AuthUnauthenticated();
    }
  }

  String _messageFor(Object error) {
    final message = error.toString().toLowerCase();
    if (message.contains('cancel')) {
      return 'Sign-in was cancelled.';
    }
    return 'Sign-in failed. Please try again.';
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
