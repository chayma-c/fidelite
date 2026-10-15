import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/money/millimes_formatting.dart';
import '../../../../core/serverpod/me_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_mode_menu_button.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../rewards/data/rewards_providers.dart';
import '../../../shop/presentation/widgets/shop_status_banner.dart';
import '../../data/wallet_providers.dart';
import 'wallet_qr_page.dart';

class WalletHomePage extends ConsumerWidget {
  const WalletHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(balanceProvider);
    final rewardsAsync = ref.watch(rewardsCatalogProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fidélité', overflow: TextOverflow.ellipsis),
        titleSpacing: 0,
        actions: [
          const ThemeModeMenuButton(),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: ShopStatusBanner()),
              const SizedBox(height: 16),
              _BalanceHeroCard(
                balanceAsync: balanceAsync,
                rewardsAsync: rewardsAsync,
                onShowQr: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const WalletQrPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The wallet's "physical card" moment: a personal greeting and quick
/// access to the redemption QR share top billing with the balance,
/// reward progress underneath -- one cohesive card rather than a
/// greeting banner stacked on top of a separate balance card, which
/// would be the same information doing the same job twice. Stays
/// gold-on-ink regardless of light/dark mode, matching the rest of the
/// brand-colored surfaces in [AppTheme].
class _BalanceHeroCard extends StatelessWidget {
  const _BalanceHeroCard({
    required this.balanceAsync,
    required this.rewardsAsync,
    required this.onShowQr,
  });

  final AsyncValue<int> balanceAsync;
  final AsyncValue<List<RewardItemRecord>> rewardsAsync;
  final VoidCallback onShowQr;

  @override
  Widget build(BuildContext context) {
    // A darker tint of the brand gold rather than a second hardcoded
    // color -- the gradient stays tied to whatever AppColors.gold is.
    final gradientEnd = Color.lerp(AppColors.gold, AppColors.ink, 0.18)!;
    final onCard = AppColors.ink;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.gold, gradientEnd],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _Greeting(onCard: onCard)),
              const SizedBox(width: 12),
              _QrIconButton(onCard: onCard, onTap: onShowQr),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Member balance',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: onCard.withValues(alpha: 0.75),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          balanceAsync.when(
            data: (balance) => Text(
              balance.asDinars,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: onCard,
                fontWeight: FontWeight.bold,
              ),
            ),
            loading: () => SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(strokeWidth: 2, color: onCard),
            ),
            error: (error, _) => Text(
              'Could not load your balance',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: onCard),
            ),
          ),
          const SizedBox(height: 16),
          _NextRewardProgress(
            balance: balanceAsync.valueOrNull,
            rewardsAsync: rewardsAsync,
            onCard: onCard,
          ),
        ],
      ),
    );
  }
}

/// "Welcome, {name}" using whatever the backend actually knows the
/// customer as -- [AppUserRecord.fullName] isn't collected at
/// registration today (email + password only), so this falls back to
/// [AppUserRecord.username], itself just the email's local part (see
/// EmailAuthEndpoint.startRegistration server-side). Hidden rather than
/// guessing a name while that profile call hasn't resolved yet.
class _Greeting extends ConsumerWidget {
  const _Greeting({required this.onCard});

  final Color onCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(meProvider).valueOrNull;
    if (me == null) return const SizedBox.shrink();

    final fullName = me.fullName?.trim();
    final name = (fullName != null && fullName.isNotEmpty)
        ? fullName
        : me.username;

    return Text(
      'Welcome, $name',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: onCard,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// A translucent square over the gradient -- echoes the card's own tone
/// (ink-on-gold) rather than introducing a separate accent color just for
/// this one button.
class _QrIconButton extends StatelessWidget {
  const _QrIconButton({required this.onCard, required this.onTap});

  final Color onCard;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onCard.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(Icons.qr_code, color: onCard),
        ),
      ),
    );
  }
}

/// Progress toward the cheapest reward the customer can't yet afford --
/// hidden entirely until both the balance and the reward catalog have
/// actually loaded, rather than guessing at a placeholder target.
class _NextRewardProgress extends StatelessWidget {
  const _NextRewardProgress({
    required this.balance,
    required this.rewardsAsync,
    required this.onCard,
  });

  final int? balance;
  final AsyncValue<List<RewardItemRecord>> rewardsAsync;
  final Color onCard;

  @override
  Widget build(BuildContext context) {
    final currentBalance = balance;
    final rewards = rewardsAsync.valueOrNull;
    if (currentBalance == null || rewards == null || rewards.isEmpty) {
      return const SizedBox.shrink();
    }

    RewardItemRecord? nextReward;
    for (final reward in rewards) {
      if (reward.pointsCost <= currentBalance) continue;
      if (nextReward == null || reward.pointsCost < nextReward.pointsCost) {
        nextReward = reward;
      }
    }

    final labelStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: onCard.withValues(alpha: 0.85),
      fontWeight: FontWeight.w600,
    );

    final progress = nextReward == null
        ? 1.0
        : currentBalance / nextReward.pointsCost;
    final label = nextReward == null
        ? 'You can redeem any reward right now'
        : '${(nextReward.pointsCost - currentBalance).asDinars} to '
              '${nextReward.displayName}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.clamp(0, 1).toDouble(),
            minHeight: 6,
            backgroundColor: onCard.withValues(alpha: 0.18),
            color: onCard,
          ),
        ),
      ],
    );
  }
}
