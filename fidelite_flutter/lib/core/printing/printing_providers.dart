import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'receipt_printer.dart';

final receiptPrinterProvider = Provider<ReceiptPrinter>(
  (ref) => const NoOpReceiptPrinter(),
);
