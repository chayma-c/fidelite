import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/entities/auth_state.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/no_access_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/orders/presentation/pages/order_builder_page.dart';
import '../../features/orders/presentation/pages/order_confirmation_page.dart';
import '../../features/wallet/presentation/pages/wallet_home_page.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const staffHome = '/staff';
  static const orderConfirmation = '/staff/order-confirmation';
  static const wallet = '/wallet';
  static const noAccess = '/no-access';
}

/// Bridges Riverpod's [authControllerProvider] to a [Listenable] so
/// `GoRouter` re-evaluates its `redirect` callback whenever auth state
/// changes (login, logout, session restored).
class _AuthListenable extends ChangeNotifier {
  _AuthListenable(Ref ref) {
    ref.listen<AuthState>(
      authControllerProvider,
      (previous, next) => notifyListeners(),
    );
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authListenable = _AuthListenable(ref);
  ref.onDispose(authListenable.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: authListenable,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.staffHome,
        builder: (context, state) => const OrderBuilderPage(),
      ),
      GoRoute(
        path: AppRoutes.orderConfirmation,
        builder: (context, state) => const OrderConfirmationPage(),
      ),
      GoRoute(
        path: AppRoutes.wallet,
        builder: (context, state) => const WalletHomePage(),
      ),
      GoRoute(
        path: AppRoutes.noAccess,
        builder: (context, state) => const NoAccessPage(),
      ),
    ],
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final goingTo = state.matchedLocation;

      if (authState is AuthInitial) {
        return goingTo == AppRoutes.splash ? null : AppRoutes.splash;
      }
      if (authState is! AuthAuthenticated) {
        return goingTo == AppRoutes.login ? null : AppRoutes.login;
      }

      final user = authState.user;
      final destination = user.hasRole('staff')
          ? AppRoutes.staffHome
          : user.hasRole('customer')
          ? AppRoutes.wallet
          : AppRoutes.noAccess;

      final isEntryPage =
          goingTo == AppRoutes.login || goingTo == AppRoutes.splash;
      if (isEntryPage) return destination;

      // Deep-link/URL-bar guard: a customer can't navigate into /staff/*
      // and vice versa, even by typing the URL directly (this is also a
      // web app).
      if (goingTo.startsWith(AppRoutes.staffHome) && !user.hasRole('staff')) {
        return destination;
      }
      if (goingTo.startsWith(AppRoutes.wallet) && !user.hasRole('customer')) {
        return destination;
      }

      return null;
    },
  );
});
