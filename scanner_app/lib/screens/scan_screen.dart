import 'dart:developer';

import 'package:animated_round_button_flutter/animated_round_button_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scanner_app/screens/auth_screen.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';
import './dachboard.dart';
import 'package:provider/provider.dart';
import '../providers/click.dart';
import 'package:scanner_app/screens/file_screen.dart';
import 'package:ndef/ndef.dart' as ndef;

class SCanScreen extends StatefulWidget {
  @override
  State<SCanScreen> createState() => _SCanScreenState();
}

class _SCanScreenState extends State<SCanScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  late final AnimationController _controller;

  @override
  bool card = false;

  @override
  Widget build(BuildContext context) {
    void _incrementCounter(BuildContext context) {
      Provider.of<Clicks>(context, listen: false).incrementCounter();
    }

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.blue])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: NfcManager.instance.isAvailable(),
          builder: (context, ss) => Column(
            children: [
              const SizedBox(
                height: 110,
              ),
              const Text(
                'Place the card near your phone',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Lato'),
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await _tagRead();

                        if (result.value != null) {
                          _incrementCounter(context);
                          Scaffold.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No Card detected'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      child: Lottie.network(
                        'https://assets8.lottiefiles.com/packages/lf20_0akluyjw.json',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.wifi_find,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/filescreen');
                },
                icon: Icon(
                  Icons.book_rounded,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DachBoard()),
                  );
                },
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _tagRead() async {
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        final ndef = Ndef.from(tag);
        if (ndef == null) throw ('Tag is not ndef.');

        Map tagNfca = tag.data['nfca'];
        setState(() {
          result.value = tag.data['nfca'];
        });

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
