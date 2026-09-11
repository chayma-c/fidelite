import 'package:fidelite_client/fidelite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/wallet_providers.dart';

sealed class ClaimState {
  const ClaimState();
}

class ClaimIdle extends ClaimState {
  const ClaimIdle();
}

class ClaimInProgress extends ClaimState {
  const ClaimInProgress();
}

class ClaimSuccess extends ClaimState {
  const ClaimSuccess(this.result);

  final ClaimResult result;
}

class ClaimFailure extends ClaimState {
  const ClaimFailure(this.message);

  final String message;
}

class ClaimController extends Notifier<ClaimState> {
  @override
  ClaimState build() => const ClaimIdle();

  /// Parses a scanned `FIDCLAIM1:<orderId>:<token>` payload (see
  /// OrderEndpoint.submitOrder, which is the only place that format is
  /// produced) and redeems it for cashback.
  Future<void> claim(String scannedPayload) async {
    final parsed = _parse(scannedPayload);
    if (parsed == null) {
      state = const ClaimFailure('That QR code is not a valid A&A receipt.');
      return;
    }

    state = const ClaimInProgress();
    try {
      final result = await ref
          .read(serverpodClientProvider)
          .pointsClaim
          .claimOrderPoints(parsed.orderId, parsed.token);
      state = ClaimSuccess(result);
      ref.invalidate(balanceProvider);
      ref.invalidate(pointsHistoryProvider);
    } on OrderClaimException catch (e) {
      state = ClaimFailure(_messageFor(e.reason));
    } catch (_) {
      state = const ClaimFailure(
        'Could not reach the server. Check your connection and try again.',
      );
    }
  }

  void reset() => state = const ClaimIdle();

  ({int orderId, String token})? _parse(String payload) {
    final parts = payload.split(':');
    if (parts.length != 3 || parts[0] != 'FIDCLAIM1') return null;
    final orderId = int.tryParse(parts[1]);
    if (orderId == null) return null;
    return (orderId: orderId, token: parts[2]);
  }

  String _messageFor(OrderClaimExceptionReason reason) => switch (reason) {
    OrderClaimExceptionReason.alreadyClaimed =>
      'This receipt has already been scanned.',
    OrderClaimExceptionReason.expired => 'This receipt has expired.',
    OrderClaimExceptionReason.invalidToken =>
      'That QR code is not a valid A&A receipt.',
    OrderClaimExceptionReason.unknown =>
      'Something went wrong claiming this receipt.',
  };
}

final claimControllerProvider = NotifierProvider<ClaimController, ClaimState>(
  ClaimController.new,
);
