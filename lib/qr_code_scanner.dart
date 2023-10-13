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
            style:  const TextStyle(fontSize: 15),
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
          // Call the updateAttendance function with the scannedCode
          updateAttendance(scannedCode);
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


  void _onQRViewCreated(QRViewController controller){
    this.controller= controller;
    controller.scannedDataStream.listen((scanData) { 
      setState(() {
        scannedCode=scanData.code!;
      });
    });
  }
}