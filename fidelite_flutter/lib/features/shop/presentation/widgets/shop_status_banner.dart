import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/shop_status_providers.dart';

/// Shown on both the auth screen (first thing a not-yet-logged-in visitor
/// sees) and the customer's wallet home (what a returning, already-logged
/// -in customer sees instead, since go_router sends them straight there).
/// Silently shows nothing while loading or on a genuine first-ever
/// failure with no cache at all -- a missing banner reads as "didn't load
/// yet", which is a safer default than guessing a status.
class ShopStatusBanner extends ConsumerWidget {
  const ShopStatusBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(shopStatusProvider);
    final status = statusAsync.valueOrNull;
    if (status == null) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final (background, foreground, icon, label) = switch (status) {
      ShopOpenStatus.open => (
        Colors.green.withValues(alpha: 0.15),
        Colors.green.shade800,
        Icons.storefront,
        'Open now',
      ),
      ShopOpenStatus.onBreak => (
        Colors.orange.withValues(alpha: 0.15),
        Colors.orange.shade800,
        Icons.free_breakfast,
        'On a quick break',
      ),
      ShopOpenStatus.closed => (
        scheme.errorContainer,
        scheme.onErrorContainer,
        Icons.storefront_outlined,
        'Closed',
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: foreground, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
