import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class SCanScreen extends StatefulWidget {
  @override
  State<SCanScreen> createState() => _SCanScreenState();
}

class _SCanScreenState extends State<SCanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('scnner app')),
      body: Center(
        child: ElevatedButton(
          child: const Text(
            'Scan',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 200),
            shape: const CircleBorder(),
          ),
        ),
      ),
    );
  }
}
