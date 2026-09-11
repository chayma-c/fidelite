import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';

sealed class RedemptionState {
  const RedemptionState();
}

class RedemptionIdle extends RedemptionState {
  const RedemptionIdle();
}

class RedemptionInProgress extends RedemptionState {
  const RedemptionInProgress();
}

class RedemptionSuccess extends RedemptionState {
  const RedemptionSuccess(this.result);

  final RedemptionResult result;
}

class RedemptionFailure extends RedemptionState {
  const RedemptionFailure(this.message, {required this.tokenStillValid});

  final String message;

  /// True only for `insufficientBalance` -- the wallet token is still
  /// usable, so the UI should let staff immediately retry a cheaper reward
  /// rather than sending them back to re-scan (see RedemptionEndpoint).
  final bool tokenStillValid;
}

class RedemptionController extends Notifier<RedemptionState> {
  @override
  RedemptionState build() => const RedemptionIdle();

  Future<void> redeem({
    required UuidValue walletUserId,
    required String walletToken,
    required int rewardItemId,
  }) async {
    state = const RedemptionInProgress();
    try {
      final result = await ref
          .read(serverpodClientProvider)
          .redemption
          .redeemReward(walletUserId, walletToken, rewardItemId);
      state = RedemptionSuccess(result);
    } on RedemptionException catch (e) {
      state = RedemptionFailure(
        _messageFor(e.reason),
        tokenStillValid: e.reason == RedemptionExceptionReason.insufficientBalance,
      );
    } catch (_) {
      state = const RedemptionFailure(
        'Could not reach the server. Check your connection and try again.',
        tokenStillValid: false,
      );
    }
  }

  void reset() => state = const RedemptionIdle();

  String _messageFor(RedemptionExceptionReason reason) => switch (reason) {
    RedemptionExceptionReason.tokenInvalidOrExpired =>
      'This QR code is invalid or has expired. Ask the customer to show a fresh one.',
    RedemptionExceptionReason.rewardUnavailable =>
      'That reward is no longer available.',
    RedemptionExceptionReason.insufficientBalance =>
      "Customer doesn't have enough balance for that reward.",
    RedemptionExceptionReason.unknown =>
      'Something went wrong redeeming this reward.',
  };
}

final redemptionControllerProvider =
    NotifierProvider<RedemptionController, RedemptionState>(
      RedemptionController.new,
    );
