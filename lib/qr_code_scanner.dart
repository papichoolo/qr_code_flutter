import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
            style:  const TextStyle(fontSize: 10),
            )
             ),
      )
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