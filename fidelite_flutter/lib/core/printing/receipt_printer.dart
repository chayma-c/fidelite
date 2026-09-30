import 'receipt.dart';

/// Sends a [Receipt] to whatever hardware the restaurant uses. Kept as an
/// interface (rather than calling [RawBtReceiptPrinter] directly) so the
/// order-taking flow doesn't depend on a specific printing app -- see
/// SETUP.md for why RawBT was chosen.
abstract interface class ReceiptPrinter {
  Future<void> printReceipt(Receipt receipt);
}

/// No-op fallback for platforms/builds with no printer integration (e.g.
/// running the app on a non-Android device, or in tests). The order
/// confirmation screen already shows the full receipt content on-screen,
/// so this intentionally does nothing rather than simulate output.
class NoOpReceiptPrinter implements ReceiptPrinter {
  const NoOpReceiptPrinter();

  @override
  Future<void> printReceipt(Receipt receipt) async {}
}
