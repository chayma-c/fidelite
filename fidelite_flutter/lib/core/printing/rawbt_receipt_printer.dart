import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

import '../money/millimes_formatting.dart';
import 'receipt.dart';
import 'receipt_printer.dart';
import 'redemption_receipt.dart';

/// Thrown when the RawBT app can't be reached to fulfil a print job (not
/// installed, or the device rejected the intent).
class ReceiptPrintException implements Exception {
  ReceiptPrintException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Prints via [RawBT](https://www.rawbt.ru/) -- an Android app that owns the
/// actual Bluetooth/USB connection to the receipt printer and accepts a raw
/// ESC/POS byte stream through a `rawbt:` URL intent. This keeps the app
/// itself hardware-agnostic (RawBT supports a wide range of ESC/POS
/// printers); swap this class if the restaurant ever moves off RawBT.
///
/// The byte stream is sent base64-encoded (`rawbt:base64,<...>`) rather than
/// as raw percent-encoded text: the ticket embeds genuine binary ESC/POS
/// command blocks (notably the QR "store data" command, which is
/// length-prefixed binary, not text), and base64 sidesteps any ambiguity in
/// how those bytes survive URL/UTF-8 encoding.
///
/// One order print job produces two sections, separated by a real partial
/// cut (not just a printed line) -- a staff/kitchen copy (ticket number +
/// what to prepare, no prices) followed by the customer's copy (ticket
/// number, priced items, total, cashback QR, thank-you line). A partial
/// cut leaves a small uncut tab holding the two halves together (exactly
/// like a perforation) rather than fully separating them, so they tear
/// apart cleanly by hand instead of needing scissors. A reward redemption
/// (see [printRedemptionReceipt]) isn't an order -- nothing to prepare,
/// nothing left to scan afterward -- so it's just one plain ticket.
class RawBtReceiptPrinter implements ReceiptPrinter {
  const RawBtReceiptPrinter();

  static const _paperColumns = 32;

  @override
  Future<void> printReceipt(Receipt receipt) =>
      _send(_buildOrderEscPosBytes(receipt));

  @override
  Future<void> printRedemptionReceipt(RedemptionReceipt receipt) =>
      _send(_buildRedemptionEscPosBytes(receipt));

  Future<void> _send(List<int> escPosBytes) async {
    final uri = Uri.parse('rawbt:base64,${base64Encode(escPosBytes)}');
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      throw ReceiptPrintException(
        'Could not reach the RawBT app. Is it installed and is a printer '
        'configured in it?',
      );
    }
  }

  List<int> _buildOrderEscPosBytes(Receipt receipt) {
    final bytes = <int>[];
    final raw = bytes.addAll;
    void text(String s) => bytes.addAll(latin1.encode(s));

    _initialize(raw);

    _printHeader(raw, text);
    _printStaffSection(raw, text, receipt);

    text('\n');
    _partialCut(raw);
    text('\n');

    _printHeader(raw, text);
    _printCustomerSection(raw, text, receipt);

    text('\n\n\n');
    _fullCut(raw);

    return bytes;
  }

  List<int> _buildRedemptionEscPosBytes(RedemptionReceipt receipt) {
    final bytes = <int>[];
    final raw = bytes.addAll;
    void text(String s) => bytes.addAll(latin1.encode(s));

    _initialize(raw);
    _printHeader(raw, text);

    raw([0x1B, 0x61, 0x01]); // Center align.
    raw([0x1B, 0x21, 0x30]); // Double height + width.
    text('Reward redeemed\n');
    raw([0x1B, 0x21, 0x00]); // Normal text.
    text('${_formatDateTime(receipt.createdAt)}\n');
    text('${'-' * _paperColumns}\n');

    raw([0x1B, 0x61, 0x00]); // Left align.
    text('${receipt.rewardName}\n');
    raw([0x1B, 0x61, 0x02]); // Right align.
    text('-${receipt.pointsCostMillimes.asDinars}\n');
    text('${'-' * _paperColumns}\n');

    text('New balance: ${receipt.customerNewBalanceMillimes.asDinars}\n');

    raw([0x1B, 0x61, 0x01]); // Center align.
    text('\nThank you for your visit\n');
    text('\n\n\n');
    _fullCut(raw);

    return bytes;
  }

  void _initialize(void Function(List<int>) raw) {
    raw([0x1B, 0x40]); // Initialize printer.
    // Explicitly select a character table instead of leaving it to
    // whatever the printer's own NVRAM default happens to be -- without
    // this, character interpretation is up to per-printer/per-firmware
    // state, which is exactly the kind of thing that produces an
    // unexplained stray glyph on some units but not others. WPC1252 is
    // the closest match to the Latin-1 bytes `text()` encodes above (they
    // agree on every byte value this app actually prints).
    raw([0x1B, 0x74, 0x10]);
  }

  void _printHeader(void Function(List<int>) raw, void Function(String) text) {
    raw([0x1B, 0x61, 0x01]); // Center align.
    raw([0x1B, 0x21, 0x30]); // Double height + width.
    text('A&A\n');
    raw([0x1B, 0x21, 0x00]); // Normal text.
    text('${'-' * _paperColumns}\n');
  }

  /// Kitchen/staff copy: just the ticket number to call out and what to
  /// prepare -- no prices, no total, nothing the kitchen doesn't need.
  void _printStaffSection(
    void Function(List<int>) raw,
    void Function(String) text,
    Receipt receipt,
  ) {
    raw([0x1B, 0x61, 0x01]); // Center align.
    text('Staff copy\n');
    raw([0x1B, 0x21, 0x30]); // Double height + width.
    text('Ticket #${receipt.ticketNumber}\n');
    raw([0x1B, 0x21, 0x00]); // Normal text.
    text('${_formatDateTime(receipt.createdAt)}\n');
    text('${'-' * _paperColumns}\n');

    raw([0x1B, 0x61, 0x00]); // Left align.
    for (final line in receipt.lines) {
      text('${line.quantity}x ${line.category}: ${line.name}\n');
    }

    _printDeliveryDetails(raw, text, receipt);
  }

  /// Printed on both the staff and customer copies -- staff need it to
  /// actually dispatch the order, and the customer gets it as a receipt of
  /// what they entered. No-op for a pickup or counter order.
  void _printDeliveryDetails(
    void Function(List<int>) raw,
    void Function(String) text,
    Receipt receipt,
  ) {
    final address = receipt.deliveryAddress;
    final phone = receipt.deliveryPhone;
    if (!receipt.isOnlineOrder || address == null || phone == null) return;

    text('${'-' * _paperColumns}\n');
    raw([0x1B, 0x21, 0x08]); // Emphasized (bold).
    text('DELIVERY\n');
    raw([0x1B, 0x21, 0x00]); // Normal text.
    text('$address\n');
    text('Tel: $phone\n');
  }

  /// Customer's copy: their number (so they don't forget it), the priced
  /// items, total, a scannable cashback QR, and a closing thank-you line.
  void _printCustomerSection(
    void Function(List<int>) raw,
    void Function(String) text,
    Receipt receipt,
  ) {
    raw([0x1B, 0x61, 0x01]); // Center align.
    raw([0x1B, 0x21, 0x30]); // Double height + width -- this is the number
    // staff and the customer call out, so it needs to be readable from
    // across the counter, not buried in small print.
    text('Ticket #${receipt.ticketNumber}\n');
    raw([0x1B, 0x21, 0x00]); // Normal text.

    raw([0x1B, 0x61, 0x00]); // Left align.
    text(
      receipt.orderId == null
          ? 'Order: pending sync\n'
          : 'Order #${receipt.orderId}\n',
    );
    text('${_formatDateTime(receipt.createdAt)}\n');
    text('${'-' * _paperColumns}\n');

    for (final line in receipt.lines) {
      text('${line.quantity}x ${line.category}: ${line.name}\n');
      raw([0x1B, 0x61, 0x02]); // Right align.
      text('${line.lineTotalMillimes.asDinars}\n');
      raw([0x1B, 0x61, 0x00]); // Back to left align.
    }
    if (receipt.deliveryFeeMillimes > 0) {
      text('Delivery fee\n');
      raw([0x1B, 0x61, 0x02]); // Right align.
      text('${receipt.deliveryFeeMillimes.asDinars}\n');
      raw([0x1B, 0x61, 0x00]); // Back to left align.
    }
    text('${'-' * _paperColumns}\n');

    raw([0x1B, 0x21, 0x10]); // Double height.
    text('Total: ${receipt.totalMillimes.asDinars}\n');
    raw([0x1B, 0x21, 0x00]); // Normal text.

    if (receipt.isOnlineOrder) {
      raw([0x1B, 0x61, 0x01]); // Center align.
      text(
        receipt.paidWithPoints
            ? 'PAID WITH POINTS -- nothing due\n'
            : 'Pay ${receipt.totalMillimes.asDinars} on pickup/delivery\n',
      );
    }
    text('\n');

    raw([0x1B, 0x61, 0x01]); // Center align.
    if (receipt.claimQrPayload case final payload?) {
      raw(_qrCodeCommand(payload));
      text('\nScan to earn cashback\n');
    } else if (receipt.orderId == null) {
      // No connectivity at submit time -- the order queued locally and the
      // real single-use QR token doesn't exist until it syncs (see
      // Receipt's doc comment). Print a plain notice instead of a QR that
      // would just be wrong/missing. An online order (always isOnlineOrder)
      // never has a claim QR by design -- its cashback, if any, is already
      // credited at placement time -- so it just prints nothing here.
      text('Cashback QR pending -- ask staff once your order syncs\n');
    }

    _printDeliveryDetails(raw, text, receipt);

    text('\nThank you for your visit\n');
  }

  /// Leaves a small uncut tab holding the two halves together, like a
  /// perforation, instead of fully separating the roll -- exactly what
  /// makes tearing the staff copy off by hand easy without scissors. Also
  /// prints a dashed guide line right at the cut, so it's still obvious
  /// where to tear even on a printer that silently ignores partial cut
  /// and treats this as a no-op.
  void _partialCut(void Function(List<int>) raw) {
    raw([0x1B, 0x61, 0x01]); // Center align.
    void text(String s) => raw(latin1.encode(s));
    text('${'- ' * (_paperColumns ~/ 2)}\n');
    raw([0x1D, 0x56, 0x42, 0x00]); // GS V 66 n -- partial cut, no extra feed.
  }

  void _fullCut(void Function(List<int>) raw) {
    raw([0x1D, 0x56, 0x41, 0x00]); // GS V 65 n -- full cut, no extra feed.
  }

  /// Standard Epson ESC/POS 2D-symbol command set (`GS ( k`), implemented by
  /// essentially every ESC/POS-compatible thermal printer, RawBT included.
  List<int> _qrCodeCommand(String data) {
    final payload = ascii.encode(data);
    final storeLength = payload.length + 3;

    return [
      // Select model 2 (the common default).
      0x1D, 0x28, 0x6B, 0x04, 0x00, 0x31, 0x41, 0x32, 0x00,
      // Module size.
      0x1D, 0x28, 0x6B, 0x03, 0x00, 0x31, 0x43, 0x06,
      // Error correction level M (~15%).
      0x1D, 0x28, 0x6B, 0x03, 0x00, 0x31, 0x45, 0x31,
      // Store data.
      0x1D, 0x28, 0x6B, storeLength & 0xFF, (storeLength >> 8) & 0xFF, 0x31,
      0x50, 0x30, ...payload,
      // Print the stored symbol.
      0x1D, 0x28, 0x6B, 0x03, 0x00, 0x31, 0x51, 0x30,
    ];
  }

  String _formatDateTime(DateTime dt) {
    final local = dt.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(local.day)}/${two(local.month)}/${local.year} '
        '${two(local.hour)}:${two(local.minute)}';
  }
}
