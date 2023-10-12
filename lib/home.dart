import 'package:flutter/material.dart';
import 'qr_code_scanner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QRScannerScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.green, // Text color
            padding: const EdgeInsets.all(12), // Button padding
          ),
          child: const Text(
            'Scan QR',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
