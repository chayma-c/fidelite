import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../auth/domain/entities/auth_state.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

sealed class WalletQrState {
  const WalletQrState();
}

class WalletQrLoading extends WalletQrState {
  const WalletQrLoading();
}

class WalletQrReady extends WalletQrState {
  const WalletQrReady({
    required this.payload,
    required this.balanceMillimes,
  });

  /// `FIDWALLET1:<userId>:<rawToken>` -- staff scan this to redeem a
  /// reward. Server-issued token, short-lived (see WalletTokenRecord).
  final String payload;
  final int balanceMillimes;
}

class WalletQrError extends WalletQrState {
  const WalletQrError(this.message);

  final String message;
}

/// Re-requests a wallet QR token roughly every 60s while this page is on
/// screen (server-side tokens expire after ~90s, see WalletEndpoint) so the
/// displayed QR never goes stale, and a screenshot of it is only useful for
/// the ~90s left on that specific token.
class WalletQrController extends Notifier<WalletQrState> {
  Timer? _refreshTimer;

  @override
  WalletQrState build() {
    ref.onDispose(() => _refreshTimer?.cancel());
    unawaited(_refresh());
    return const WalletQrLoading();
  }

  Future<void> refreshNow() => _refresh();

  Future<void> _refresh() async {
    final authState = ref.read(authControllerProvider);
    if (authState is! AuthAuthenticated) {
      state = const WalletQrError('Not signed in.');
      return;
    }

    try {
      final response = await ref
          .read(serverpodClientProvider)
          .wallet
          .getWalletToken();
      state = WalletQrReady(
        payload: 'FIDWALLET1:${authState.user.id}:${response.rawToken}',
        balanceMillimes: response.currentBalanceMillimes,
      );
      _refreshTimer?.cancel();
      _refreshTimer = Timer(const Duration(seconds: 60), _refresh);
    } catch (_) {
      state = const WalletQrError(
        'Could not reach the server. Check your connection and try again.',
      );
    }
  }
}

final walletQrControllerProvider =
    NotifierProvider<WalletQrController, WalletQrState>(
      WalletQrController.new,
    );
