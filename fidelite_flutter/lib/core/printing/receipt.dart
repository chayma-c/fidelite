/// What would appear on a printed ticket. Built client-side from the cart
/// (which already has the item names/prices from the menu it fetched) plus
/// the [OrderRecord] the server actually confirmed, rather than round
/// -tripping the line items back from the server.
///
/// [orderId] and [claimQrPayload] are server-issued and nullable: an order
/// placed with no connectivity is queued locally and doesn't have either
/// yet (no DB-assigned id, and the QR is a single-use secret token the
/// server generates atomically with the order -- it can't exist before
/// that). [ticketNumber] is different -- it's always available, reserved
/// locally the moment an offline order is queued (see
/// LocalTicketNumberTracker), specifically so staff always have a real
/// number to call out and print, connection or not.
class Receipt {
  const Receipt({
    this.orderId,
    required this.ticketNumber,
    required this.createdAt,
    required this.lines,
    required this.totalMillimes,
    this.claimQrPayload,
    this.isOnlineOrder = false,
    this.deliveryFeeMillimes = 0,
    this.deliveryAddress,
    this.deliveryPhone,
    this.paidWithPoints = false,
  });

  final int? orderId;

  /// The short, printable number called out to the customer -- 1..100,
  /// resetting daily -- as opposed to [orderId] (the database id, which
  /// never resets and is for internal/staff reference).
  final int ticketNumber;
  final DateTime createdAt;
  final List<ReceiptLine> lines;
  final int totalMillimes;

  /// Printed as a QR code on the ticket; scanning it credits the customer
  /// with cashback for this order (see PointsClaimEndpoint on the server).
  final String? claimQrPayload;

  /// Distinguishes an online order (self-ordered by the customer, see
  /// OnlineOrderEndpoint) from a counter order -- needed because
  /// [paidWithPoints] alone can't: it defaults to false for a counter
  /// order too, where the concept simply doesn't apply (staff handle
  /// payment directly, outside the app). Gates whether the payment-status
  /// line and delivery details print at all.
  final bool isOnlineOrder;

  /// Already included in [totalMillimes] -- broken out here purely so it
  /// can be itemized on the ticket. 0 for a counter order or an online
  /// pickup order.
  final int deliveryFeeMillimes;

  /// Set only for an online delivery order.
  final String? deliveryAddress;

  /// Set only for an online delivery order.
  final String? deliveryPhone;

  /// Whether [totalMillimes] was already settled from the customer's
  /// points balance at order time -- if so, nothing is due on
  /// pickup/delivery. Always false for a counter order (payment there is
  /// handled directly by staff, outside the app).
  final bool paidWithPoints;
}

class ReceiptLine {
  const ReceiptLine({
    required this.category,
    required this.name,
    required this.quantity,
    required this.lineTotalMillimes,
  });

  /// The menu category, e.g. "Chawarma" -- printed ahead of [name] as the
  /// item's main/headline name, since [name] alone is often just the
  /// filling/variant (e.g. "Poulet") and reads ambiguously on its own.
  final String category;
  final String name;
  final int quantity;
  final int lineTotalMillimes;
}
