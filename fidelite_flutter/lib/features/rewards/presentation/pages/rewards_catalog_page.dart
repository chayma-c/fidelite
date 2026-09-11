import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../data/rewards_providers.dart';

/// Customer-facing "what could I redeem" browsing. Staff use the same
/// [rewardsCatalogProvider] data inside the redemption flow's reward
/// picker instead of this page.
class RewardsCatalogPage extends ConsumerWidget {
  const RewardsCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(rewardsCatalogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rewards')),
      body: catalogAsync.when(
        data: (rewards) => ListView.builder(
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            final reward = rewards[index];
            return ListTile(
              title: Text(reward.name),
              trailing: Text(
                reward.pointsCost.asDinars,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Could not load rewards:\n$error')),
      ),
    );
  }
}
