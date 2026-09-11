/// What would appear on a printed ticket. Built client-side from the cart
/// (which already has the item names/prices from the menu it fetched) plus
/// the [OrderRecord] the server actually confirmed, rather than round
/// -tripping the line items back from the server.
class Receipt {
  const Receipt({
    required this.orderId,
    required this.createdAt,
    required this.lines,
    required this.totalMillimes,
    required this.claimQrPayload,
  });

  final int orderId;
  final DateTime createdAt;
  final List<ReceiptLine> lines;
  final int totalMillimes;

  /// Printed as a QR code on the ticket; scanning it credits the customer
  /// with cashback for this order (see PointsClaimEndpoint on the server).
  final String claimQrPayload;
}

class ReceiptLine {
  const ReceiptLine({
    required this.name,
    required this.quantity,
    required this.lineTotalMillimes,
  });

  final String name;
  final int quantity;
  final int lineTotalMillimes;
}
