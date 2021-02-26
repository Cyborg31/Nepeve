import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  GlobalKey qrkey = GlobalKey();
  var qrText = "";

  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Code'),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 5,
            child: QRView(
                key: qrkey,
                overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderColor: Colors.blue,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300),
                onQRViewCreated: _onQrViewCreate),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text("Scan result: $qrText"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQrViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }
}
