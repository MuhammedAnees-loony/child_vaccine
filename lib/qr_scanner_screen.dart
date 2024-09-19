import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (BarcodeCapture barcodeCapture) {
          // Extract the first barcode value if available
          final String code = barcodeCapture.barcodes.isNotEmpty
              ? barcodeCapture.barcodes.first.rawValue ?? 'Unknown'
              : 'No QR code detected';

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('QR Code Scanned'),
              content: Text('Code: $code'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
