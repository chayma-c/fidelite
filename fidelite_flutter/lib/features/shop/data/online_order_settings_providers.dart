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
