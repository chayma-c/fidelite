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
