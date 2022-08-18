import 'package:animated_round_button_flutter/animated_round_button_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scanner_app/screens/auth_screen.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';
import './dachboard.dart';

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
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool card = false;
  int counter = 0;

  void _incrementCounter() {
    setState(
      () {
        counter++;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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

                        if (result.value == null) {
                          Scaffold.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No Card detected'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else {
                          _incrementCounter;
                          print('ok');
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
                    MaterialPageRoute(builder: (context) => DachBoard(counter)),
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
    print('start reading');
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        final ndef = Ndef.from(tag);
        if (ndef == null) throw ('Tag is not ndef.');
        print(String.fromCharCodes(
          ndef.cachedMessage!.records[0].identifier,
        ));

        Map tagNfca = tag.data['ndef'];
        setState(() {
          counter++;
          result.value = tag.data['ndef'];
        });

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
