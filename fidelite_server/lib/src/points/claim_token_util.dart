import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// 256-bit random tokens for order-claim QR payloads, plus their hash for
/// storage. The raw token only ever exists in memory / is returned to the
/// caller once, at issuance -- see order_claim_token.spy.yaml.
abstract final class ClaimTokenUtil {
  /// How long an issued-but-unclaimed token stays valid -- generous on
  /// purpose. Single-use (not short expiry) is what actually prevents a
  /// receipt being claimed twice (see order_claim_token.spy.yaml); this
  /// window just bounds how long a stale unclaimed row sticks around.
  /// Shared by both OrderEndpoint.submitOrder (counter orders, issued at
  /// placement) and OnlineOrderManagementEndpoint.issueClaimToken (online
  /// orders, issued at print time).
  static const validity = Duration(days: 7);

  static final Random _random = Random.secure();

  static String generateRawToken() {
    final bytes = List<int>.generate(32, (_) => _random.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  static String hash(String rawToken) =>
      sha256.convert(utf8.encode(rawToken)).toString();
}
