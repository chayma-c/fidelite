import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_update_providers.dart';

/// Shown on the wallet home screen when a newer build is flagged "latest"
/// on GitHub than the one currently installed (see app_update_providers
/// .dart). Customer-only by construction -- it's only ever placed on
/// WalletHomePage, which staff never reach; staff get updates through
/// Firebase App Distribution instead, a separate channel with its own
/// versioning this check knows nothing about.
///
/// There's no way to install the update without the customer tapping
/// through -- Android requires an explicit install confirmation
/// regardless of how the app got there, sideloaded or not -- so this is a
/// nudge, not a forced update. Dismissible for the current app session
/// only (not persisted to disk), so it reappears next launch if they
/// skipped it rather than being silently forgotten forever.
class UpdateAvailableBanner extends ConsumerStatefulWidget {
  const UpdateAvailableBanner({super.key});

  @override
  ConsumerState<UpdateAvailableBanner> createState() =>
      _UpdateAvailableBannerState();
}

class _UpdateAvailableBannerState
    extends ConsumerState<UpdateAvailableBanner> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    final updateAvailable =
        ref.watch(updateAvailableProvider).valueOrNull ?? false;
    if (_dismissed || !updateAvailable) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(14, 8, 6, 8),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.system_update_alt,
            color: colorScheme.onPrimaryContainer,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'A new version of the app is available.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          TextButton(onPressed: _openDownload, child: const Text('Update')),
          IconButton(
            icon: Icon(
              Icons.close,
              color: colorScheme.onPrimaryContainer,
              size: 18,
            ),
            tooltip: 'Dismiss',
            visualDensity: VisualDensity.compact,
            onPressed: () => setState(() => _dismissed = true),
          ),
        ],
      ),
    );
  }

  Future<void> _openDownload() async {
    await launchUrl(
      Uri.parse(latestApkDownloadUrl),
      mode: LaunchMode.externalApplication,
    );
  }
}
