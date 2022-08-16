import 'package:animated_round_button_flutter/animated_round_button_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scanner_app/screens/auth_screen.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';

import 'package:scanner_app/screens/file_screen.dart';

class SCanScreen extends StatefulWidget {
  @override
  State<SCanScreen> createState() => _SCanScreenState();
}

class _SCanScreenState extends State<SCanScreen>
    with SingleTickerProviderStateMixin {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  late final AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool card = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade600,
      body: FutureBuilder(
        future: NfcManager.instance.isAvailable(),
        builder: (context, ss) => Column(
          children: [
            SizedBox(
              height: 110,
            ),
            Text(
              'Place the card near your phone',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Lato'),
            ),
            SizedBox(
              height: 130,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await _tagRead();
                  print('end tagread');
                  if (result.value != null)
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('No Card detected'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                },
                child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_0akluyjw.json',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _tagRead() async {
    print('start reading');
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        final ndef = Ndef.from(tag);
        if (ndef == null) throw ('Tag is not ndef.');
        print(String.fromCharCodes(
          ndef.cachedMessage!.records[0].identifier,
        ));

        Map tagNfca = tag.data['ndef'];
        result.value = tag.data['ndef'];
        print('read: ${tagNfca}');

        print(result.value);
        NfcManager.instance.stopSession();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FileScreen(
              result,
            ),
          ),
        );
      },
    );
    print('end reading');
  }
}
