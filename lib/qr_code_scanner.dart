import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'mogo/mongo.dart';
class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});
  

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();

}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey= GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String scannedCode = '';

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
      children: <Widget>[
      Expanded(flex: 5,
      child: QRView(
        key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Text( 
            'Scanned Code: $scannedCode',
            style:  const TextStyle(fontSize: 20),
            )
             ),
      ),
      ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back to HomeScreen
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
                padding: const EdgeInsets.all(12), // Button padding
              ),
              child: const Text('Go Back to Home'),
              
            ),
            ElevatedButton(
        onPressed: () {
          //showSuccessPopup(context);
          updateAttendance(scannedCode, context);
          setState(() {
            scannedCode = '';
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          padding: const EdgeInsets.all(12),
        ),
        child: const Text('Mark Present'),
      ),
     ]),

    );
  }


Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }




  void _onQRViewCreated(QRViewController controller){
    this.controller= controller;
    controller.scannedDataStream.listen((scanData) { 
      setState(() {
        scannedCode=scanData.code!;
      });
    });
  }
}