import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'claim_token_util.dart';
import 'points_balance.dart';

/// Deliberately short -- unlike an order-claim token, this is the actual
/// defense against a screenshotted/replayed wallet QR (see
/// wallet_token.spy.yaml). The wallet screen re-requests a fresh token
/// roughly every 60s while it's visible, comfortably inside this window.
const _walletTokenValidity = Duration(seconds: 90);

class WalletEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:customer')};

  Future<int> getBalance(Session session) {
    final userId = UuidValue.fromString(session.authenticated!.userIdentifier);
    return currentPointsBalance(session, userId, null);
  }

  /// Issues a fresh single-use wallet QR token for staff to scan during a
  /// redemption. Bundles the current balance so the wallet QR screen
  /// doesn't need a second call on every refresh.
  Future<WalletTokenResponse> getWalletToken(Session session) async {
    final userId = UuidValue.fromString(session.authenticated!.userIdentifier);
    final rawToken = ClaimTokenUtil.generateRawToken();
    final expiresAt = DateTime.now().toUtc().add(_walletTokenValidity);

    await WalletTokenRecord.db.insertRow(
      session,
      WalletTokenRecord(
        userId: userId,
        tokenHash: ClaimTokenUtil.hash(rawToken),
        expiresAt: expiresAt,
      ),
    );

    final balance = await currentPointsBalance(session, userId, null);
    return WalletTokenResponse(
      rawToken: rawToken,
      expiresAt: expiresAt,
      currentBalanceMillimes: balance,
    );
  }

  /// Most recent entries first, bank-statement style.
  Future<List<PointsLedgerEntryRecord>> getPointsHistory(
    Session session, {
    int limit = 50,
  }) {
    final userId = UuidValue.fromString(session.authenticated!.userIdentifier);
    return PointsLedgerEntryRecord.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: limit,
    );
  }
}
