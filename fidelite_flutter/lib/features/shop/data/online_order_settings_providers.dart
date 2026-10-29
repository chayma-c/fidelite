import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/serverpod/serverpod_client_provider.dart';

/// Whether a new online order should print automatically the moment
/// staff's device notices it (see OrderBuilderPage's auto-print listener),
/// instead of sitting in the Online Orders queue for a manual tap.
/// Staff-only, read on demand from the Settings page -- not polled,
/// unlike shop status/online orders, since nothing else depends on this
/// value changing live.
final autoPrintSettingProvider = FutureProvider.autoDispose<bool>((ref) async {
  final settings = await ref
      .read(serverpodClientProvider)
      .onlineOrderSettings
      .getSettings();
  return settings.autoPrintEnabled;
});

class AutoPrintSettingController {
  AutoPrintSettingController(this.ref);

  final Ref ref;

  Future<void> setEnabled(bool enabled) async {
    await ref.read(serverpodClientProvider).onlineOrderSettings.setAutoPrint(enabled);
    ref.invalidate(autoPrintSettingProvider);
  }
}

final autoPrintSettingControllerProvider = Provider<AutoPrintSettingController>(
  (ref) => AutoPrintSettingController(ref),
);

/// Whether a customer can currently choose delivery as a fulfillment
/// method -- staff-side read, for the Settings page toggle. Not the same
/// provider the customer's own cart reads from (see
/// deliveryAvailableProvider in features/orders): that one hits the
/// separate public endpoint, since this staff-only one requires a staff
/// session.
final deliveryEnabledSettingProvider = FutureProvider.autoDispose<bool>((
  ref,
) async {
  final settings = await ref
      .read(serverpodClientProvider)
      .onlineOrderSettings
      .getSettings();
  return settings.deliveryEnabled;
});

class DeliveryEnabledSettingController {
  DeliveryEnabledSettingController(this.ref);

  final Ref ref;

  Future<void> setEnabled(bool enabled) async {
    await ref
        .read(serverpodClientProvider)
        .onlineOrderSettings
        .setDeliveryEnabled(enabled);
    ref.invalidate(deliveryEnabledSettingProvider);
  }
}

final deliveryEnabledSettingControllerProvider =
    Provider<DeliveryEnabledSettingController>(
      (ref) => DeliveryEnabledSettingController(ref),
    );
