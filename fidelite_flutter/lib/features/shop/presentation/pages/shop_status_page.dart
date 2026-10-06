import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/shop_status_providers.dart';

/// Staff-only, and deliberately its own standalone screen reached through
/// the overflow menu -- not a quick-access button anywhere near the
/// order-taking flow. Changing the sign is rare and consequential enough
/// (customers see it the moment it changes) that it's worth the extra
/// couple of taps to get here, plus a confirmation dialog before anything
/// actually applies, so it can't be flipped by a stray tap while busy.
class ShopStatusPage extends ConsumerStatefulWidget {
  const ShopStatusPage({super.key});

  @override
  ConsumerState<ShopStatusPage> createState() => _ShopStatusPageState();
}

class _ShopStatusPageState extends ConsumerState<ShopStatusPage> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(shopStatusProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Shop status')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: statusAsync.when(
              data: (status) => _StatusOptions(
                current: status,
                isSaving: _isSaving,
                onSelect: (next) => _confirmAndApply(context, status, next),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text(
                  'Could not load the current status:\n$error',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmAndApply(
    BuildContext context,
    ShopOpenStatus current,
    ShopOpenStatus next,
  ) async {
    if (next == current || _isSaving) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Switch to "${_labelFor(next)}"?'),
        content: const Text(
          'Customers will see this change the moment they open the app.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);

    setState(() => _isSaving = true);
    try {
      await ref.read(serverpodClientProvider).shopStatusManagement.setStatus(next);
      // Network-first provider -- invalidating forces an immediate live
      // re-fetch instead of waiting for the next 15s poll, so staff (and
      // this same screen) see the change land right away.
      ref.invalidate(shopStatusProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not update the status: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

String _labelFor(ShopOpenStatus status) => switch (status) {
  ShopOpenStatus.open => 'Open',
  ShopOpenStatus.onBreak => 'On a quick break',
  ShopOpenStatus.closed => 'Closed',
};

class _StatusOptions extends StatelessWidget {
  const _StatusOptions({
    required this.current,
    required this.isSaving,
    required this.onSelect,
  });

  final ShopOpenStatus current;
  final bool isSaving;
  final ValueChanged<ShopOpenStatus> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Currently:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          _labelFor(current),
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        _StatusTile(
          status: ShopOpenStatus.open,
          icon: Icons.storefront,
          color: Colors.green,
          isSelected: current == ShopOpenStatus.open,
          isEnabled: !isSaving,
          onTap: onSelect,
        ),
        const SizedBox(height: 12),
        _StatusTile(
          status: ShopOpenStatus.onBreak,
          icon: Icons.free_breakfast,
          color: Colors.orange,
          isSelected: current == ShopOpenStatus.onBreak,
          isEnabled: !isSaving,
          onTap: onSelect,
        ),
        const SizedBox(height: 12),
        _StatusTile(
          status: ShopOpenStatus.closed,
          icon: Icons.storefront_outlined,
          color: Theme.of(context).colorScheme.error,
          isSelected: current == ShopOpenStatus.closed,
          isEnabled: !isSaving,
          onTap: onSelect,
        ),
      ],
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({
    required this.status,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  final ShopOpenStatus status;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final bool isEnabled;
  final ValueChanged<ShopOpenStatus> onTap;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      _labelFor(status),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: isSelected
          ? FilledButton.icon(
              onPressed: null,
              style: FilledButton.styleFrom(backgroundColor: color),
              icon: Icon(icon),
              label: label,
            )
          : OutlinedButton.icon(
              onPressed: isEnabled ? () => onTap(status) : null,
              style: OutlinedButton.styleFrom(foregroundColor: color),
              icon: Icon(icon),
              label: label,
            ),
    );
  }
}
