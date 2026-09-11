import 'receipt.dart';

/// Sends a [Receipt] to whatever hardware the restaurant ends up using.
/// Deliberately abstract: the printer model isn't chosen yet (Bluetooth
/// ESC/POS, paper width, etc. all TBD -- see SETUP.md), so the rest of the
/// order-taking flow is built and testable against this interface now, and
/// only [NoOpReceiptPrinter] needs replacing once hardware is picked.
abstract interface class ReceiptPrinter {
  Future<void> printReceipt(Receipt receipt);
}

/// Placeholder used until real printer hardware is wired up. The order
/// confirmation screen already shows the full receipt content on-screen,
/// so this intentionally does nothing rather than simulate output.
class NoOpReceiptPrinter implements ReceiptPrinter {
  const NoOpReceiptPrinter();

  @override
  Future<void> printReceipt(Receipt receipt) async {}
}
