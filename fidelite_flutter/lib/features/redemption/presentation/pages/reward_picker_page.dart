import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../rewards/data/rewards_providers.dart';
import '../controllers/redemption_controller.dart';

/// Shown after staff scan a customer's wallet QR. Stays open across a
/// failed `insufficientBalance` attempt (the token is still valid -- see
/// RedemptionController) so the cashier can immediately retry a cheaper
/// reward without re-scanning.
class RewardPickerPage extends ConsumerWidget {
  const RewardPickerPage({
    super.key,
    required this.walletUserId,
    required this.walletToken,
  });

  final UuidValue walletUserId;
  final String walletToken;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RedemptionState>(redemptionControllerProvider, (
      previous,
      next,
    ) {
      switch (next) {
        case RedemptionSuccess():
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Redeemed!'),
              content: Text(
                '${next.result.redemption.rewardNameSnapshot}\n\n'
                "Customer's new balance: "
                '${next.result.customerNewBalanceMillimes.asDinars}',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          );
        case RedemptionFailure():
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.message)));
          if (!next.tokenStillValid) {
            Navigator.of(context).pop();
          }
          ref.read(redemptionControllerProvider.notifier).reset();
        case RedemptionIdle():
        case RedemptionInProgress():
          break;
      }
    });

    final catalogAsync = ref.watch(rewardsCatalogProvider);
    final isRedeeming = ref.watch(redemptionControllerProvider) is RedemptionInProgress;

    return Scaffold(
      appBar: AppBar(title: const Text('Pick a reward')),
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
              onTap: isRedeeming
                  ? null
                  : () => ref
                      .read(redemptionControllerProvider.notifier)
                      .redeem(
                        walletUserId: walletUserId,
                        walletToken: walletToken,
                        rewardItemId: reward.id!,
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
