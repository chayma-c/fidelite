import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

import '../money/millimes_formatting.dart';
import 'receipt.dart';
import 'receipt_printer.dart';

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
class RawBtReceiptPrinter implements ReceiptPrinter {
  const RawBtReceiptPrinter();

  static const _paperColumns = 32;

  @override
  Future<void> printReceipt(Receipt receipt) async {
    final uri = Uri.parse(
      'rawbt:base64,${base64Encode(_buildEscPosBytes(receipt))}',
    );
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      throw ReceiptPrintException(
        'Could not reach the RawBT app. Is it installed and is a printer '
        'configured in it?',
      );
    }
  }

  List<int> _buildEscPosBytes(Receipt receipt) {
    final bytes = <int>[];

    void raw(List<int> b) => bytes.addAll(b);
    // Latin-1, not ASCII: item names/descriptions are French and may
    // contain accents (é, è, ç, ...), which ESC/POS printers generally
    // support via their default codepage but plain ASCII would reject.
    void text(String s) => bytes.addAll(latin1.encode(s));

    raw([0x1B, 0x40]); // Initialize printer.

    raw([0x1B, 0x61, 0x01]); // Center align.
    raw([0x1B, 0x21, 0x30]); // Double height + width.
    text('A&A\n');
    raw([0x1B, 0x21, 0x00]); // Normal text.
    text('${'-' * _paperColumns}\n');

    raw([0x1B, 0x61, 0x00]); // Left align.
    text('Order #${receipt.orderId}\n');
    text('${_formatDateTime(receipt.createdAt)}\n');
    text('${'-' * _paperColumns}\n');

    for (final line in receipt.lines) {
      text('${line.quantity}x ${line.name}\n');
      raw([0x1B, 0x61, 0x02]); // Right align.
      text('${line.lineTotalMillimes.asDinars}\n');
      raw([0x1B, 0x61, 0x00]); // Back to left align.
    }
    text('${'-' * _paperColumns}\n');

    raw([0x1B, 0x21, 0x10]); // Double height.
    text('Total: ${receipt.totalMillimes.asDinars}\n');
    raw([0x1B, 0x21, 0x00]); // Normal text.
    text('\n');

    raw([0x1B, 0x61, 0x01]); // Center align.
    raw(_qrCodeCommand(receipt.claimQrPayload));
    text('\nScan to earn cashback\n');

    text('\n\n\n');
    raw([0x1D, 0x56, 0x41, 0x03]); // Feed and partial cut.

    return bytes;
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
