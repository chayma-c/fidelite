import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

/// Generic camera-based QR scanner, shared by every feature that needs to
/// scan one (a customer scanning an order ticket now; staff scanning a
/// customer's wallet QR from Phase 3 on). Pops with the raw scanned string
/// once found -- payload parsing (the `FIDCLAIM1:`/`FIDWALLET1:` formats)
/// stays feature-local since the formats are domain-specific, not this
/// page's concern.
class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key, required this.title});

  final String title;

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController _controller = MobileScannerController();
  bool _handled = false;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _ensurePermission();
  }

  Future<void> _ensurePermission() async {
    final status = await Permission.camera.request();
    if (mounted && !status.isGranted) {
      setState(() => _permissionDenied = true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final value = capture.barcodes.firstOrNull?.rawValue;
    if (value == null) return;
    _handled = true;
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _permissionDenied
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Camera permission is required to scan a QR code. '
                  'Enable it in system settings and try again.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : MobileScanner(controller: _controller, onDetect: _onDetect),
    );
  }
}
