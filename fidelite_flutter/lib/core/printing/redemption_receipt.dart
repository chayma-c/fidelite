/// What gets printed after staff redeem a reward against a customer's
/// wallet QR -- see RedemptionController. Deliberately not a [Receipt]: a
/// redemption has no ticket number, no items to prepare, and nothing left
/// to scan afterward, so forcing it into that shape would mean a lot of
/// fields that don't mean anything here.
class RedemptionReceipt {
  const RedemptionReceipt({
    required this.rewardName,
    required this.pointsCostMillimes,
    required this.customerNewBalanceMillimes,
    required this.createdAt,
  });

  final String rewardName;
  final int pointsCostMillimes;
  final int customerNewBalanceMillimes;
  final DateTime createdAt;
}
