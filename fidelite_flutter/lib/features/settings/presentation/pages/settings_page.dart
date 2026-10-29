import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shop/data/online_order_settings_providers.dart';

/// Staff-only. Currently just the one toggle, but its own screen (rather
/// than folding it into Shop Status or the overflow menu directly) since
/// "settings" is where staff should expect to find any future operational
/// toggle too.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoPrintAsync = ref.watch(autoPrintSettingProvider);
    final deliveryEnabledAsync = ref.watch(deliveryEnabledSettingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: autoPrintAsync.when(
        data: (autoPrintEnabled) => ListView(
          children: [
            SwitchListTile(
              title: const Text('Auto-print online orders'),
              subtitle: const Text(
                'Print a new online order the moment it arrives, instead '
                'of waiting in the Online Orders queue for a manual tap. '
                "Leave this off if staff are often busy taking counter "
                'orders -- auto-printing everything can pile tickets up '
                'right when there\'s no time to deal with them.',
              ),
              value: autoPrintEnabled,
              onChanged: (value) async {
                await ref
                    .read(autoPrintSettingControllerProvider)
                    .setEnabled(value);
              },
            ),
            const Divider(height: 1),
            deliveryEnabledAsync.when(
              data: (deliveryEnabled) => SwitchListTile(
                title: const Text('Allow delivery'),
                subtitle: const Text(
                  'Let customers choose delivery when placing an online '
                  "order. Turn this off when delivery genuinely can't be "
                  "fulfilled right now (no one free to drive, etc.) -- "
                  'customers will still see Delivery as an option, just '
                  'disabled, with a note that it\'s not available.',
                ),
                value: deliveryEnabled,
                onChanged: (value) async {
                  await ref
                      .read(deliveryEnabledSettingControllerProvider)
                      .setEnabled(value);
                },
              ),
              loading: () => const ListTile(
                title: Text('Allow delivery'),
                trailing: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              error: (error, _) => ListTile(
                title: const Text('Allow delivery'),
                subtitle: Text('Could not load: $error'),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            'Could not load settings:\n$error',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
