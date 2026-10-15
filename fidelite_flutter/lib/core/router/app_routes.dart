/// Route paths, kept in their own file (rather than alongside
/// [appRouterProvider] in app_router.dart) so a page widget can reference
/// a path -- e.g. to switch bottom-nav tabs via `context.go(...)` -- without
/// importing the router setup itself, which pulls in every page it builds.
abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const staffHome = '/staff';
  static const orderConfirmation = '/staff/order-confirmation';

  /// The customer shell's four bottom-nav tabs. All nested under [wallet]
  /// so the router's existing "customers can't reach /staff/* and vice
  /// versa" redirect guard (which checks for this prefix) covers them too.
  static const wallet = '/wallet';
  static const customerOrder = '/wallet/order';
  static const customerRewards = '/wallet/rewards';
  static const customerActivity = '/wallet/activity';

  static const noAccess = '/no-access';
}
