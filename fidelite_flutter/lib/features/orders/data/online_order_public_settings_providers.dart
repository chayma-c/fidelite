import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/serverpod/serverpod_client_provider.dart';

/// Whether a customer can currently choose delivery when placing an online
/// order -- staff-controlled (see Settings), read here through the
/// separate public endpoint rather than the staff-only
/// onlineOrderSettings one, since this is read from the customer's own
/// cart. Not polled: the cart screen is short-lived enough that reading it
/// once per visit is enough, same reasoning as the staff Settings page's
/// equivalent provider.
final deliveryAvailableProvider = FutureProvider.autoDispose<bool>((
  ref,
) async {
  final settings = await ref
      .read(serverpodClientProvider)
      .onlineOrderPublicSettings
      .getSettings();
  return settings.deliveryEnabled;
});
