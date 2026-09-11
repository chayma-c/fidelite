import 'app_user.dart';

/// The authentication lifecycle of the app, exposed to the UI by
/// `AuthController`. Modeled as a sealed class so the router and widgets can
/// exhaustively `switch` over every possible state.
sealed class AuthState {
  const AuthState();
}

/// A persisted session is being restored (app just started).
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// A sign-in or sign-out is in flight.
class AuthAuthenticating extends AuthState {
  const AuthAuthenticating();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);

  final AppUser user;
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);

  final String message;
}
