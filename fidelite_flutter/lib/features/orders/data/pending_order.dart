import '../presentation/controllers/cart_controller.dart';

/// A single line within a [PendingOrder] -- a snapshot of the menu item at
/// the moment it was queued, not a live reference. If the item's price
/// changes server-side before this order finally syncs, the *server's*
/// price wins at sync time (same pricing-integrity rule as the normal
/// online path); this snapshot only exists to show a provisional total
/// while the order is still queued.
class PendingOrderLine {
  const PendingOrderLine({
    required this.menuItemId,
    required this.category,
    required this.name,
    required this.priceMillimesSnapshot,
    required this.quantity,
  });

  final int menuItemId;
  final String category;
  final String name;
  final int priceMillimesSnapshot;
  final int quantity;

  int get lineTotalMillimes => priceMillimesSnapshot * quantity;

  factory PendingOrderLine.fromJson(Map<String, dynamic> json) =>
      PendingOrderLine(
        menuItemId: json['menuItemId'] as int,
        // Queued before this field existed, on disk from an older app
        // version: fall back to an empty category rather than crash.
        category: json['category'] as String? ?? '',
        name: json['name'] as String,
        priceMillimesSnapshot: json['priceMillimesSnapshot'] as int,
        quantity: json['quantity'] as int,
      );

  Map<String, dynamic> toJson() => {
    'menuItemId': menuItemId,
    'category': category,
    'name': name,
    'priceMillimesSnapshot': priceMillimesSnapshot,
    'quantity': quantity,
  };
}

/// An order that couldn't reach the server at submit time and is waiting to
/// be synced. [localId] only ever identifies it on this device -- the
/// server assigns the real order id once `submitOrder` finally succeeds.
class PendingOrder {
  const PendingOrder({
    required this.localId,
    required this.ticketNumber,
    required this.createdAt,
    required this.lines,
  });

  final String localId;

  /// Reserved locally (see LocalTicketNumberTracker) the moment the order
  /// is queued, so there's a real number to print right away -- not
  /// deferred until the order actually reaches the server. Sent along as
  /// `requestedTicketNumber` when this order syncs, so what's on the
  /// printed ticket matches what the server ends up recording in the
  /// normal (single-device) case.
  final int ticketNumber;
  final DateTime createdAt;
  final List<PendingOrderLine> lines;

  int get estimatedTotalMillimes =>
      lines.fold(0, (sum, line) => sum + line.lineTotalMillimes);

  factory PendingOrder.fromCart(List<CartLine> cart, {required int ticketNumber}) {
    final now = DateTime.now().toUtc();
    return PendingOrder(
      // Local-only identifier; only needs to be unique on this device.
      localId: now.microsecondsSinceEpoch.toString(),
      ticketNumber: ticketNumber,
      createdAt: now,
      lines: cart
          .map(
            (line) => PendingOrderLine(
              menuItemId: line.menuItem.id!,
              category: line.menuItem.category,
              name: line.menuItem.name,
              priceMillimesSnapshot: line.menuItem.priceMillimes,
              quantity: line.quantity,
            ),
          )
          .toList(),
    );
  }

  factory PendingOrder.fromJson(Map<String, dynamic> json) => PendingOrder(
    localId: json['localId'] as String,
    // Queued before this field existed, on disk from an older app version:
    // 0 is an obviously-provisional placeholder rather than a crash.
    ticketNumber: json['ticketNumber'] as int? ?? 0,
    createdAt: DateTime.parse(json['createdAt'] as String),
    lines: (json['lines'] as List<dynamic>)
        .map((line) => PendingOrderLine.fromJson(line as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'localId': localId,
    'ticketNumber': ticketNumber,
    'createdAt': createdAt.toIso8601String(),
    'lines': lines.map((line) => line.toJson()).toList(),
  };
}
