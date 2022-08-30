import 'dart:convert';
import 'dart:developer';

import 'package:animated_round_button_flutter/animated_round_button_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:nfc_manager/nfc_manager.dart';

import 'package:provider/provider.dart';
import '../providers/click.dart';

class SCanScreen extends StatefulWidget {
  @override
  State<SCanScreen> createState() => _SCanScreenState();
}

class _SCanScreenState extends State<SCanScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    var result = Provider.of<Clicks>(context).result;
    void incrementCounter(BuildContext context) {
      Provider.of<Clicks>(context, listen: false).incrementCounter();
    }

    Future<void> _tagRead() async {
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          //final ndef = Ndef.from(tag);
          // if (ndef == null) throw ('Tag is not ndef.');
          /* var convert = json.decode(tag.data.toString());
          List<int> charCodes = convert['ndef']['identifier'];
          print(new String.fromCharCodes(charCodes));*/
          var mytag = tag.data["nfca"]["identifier"]
              .map((e) => e.toRadixString(16).padLeft(2, '0'))
              .join('');

          result.value = mytag;
          print(result.value);
          /*    Map tagNfca = tag.data['nfca'];
          setState(() {
            
          });
*/
          /*if (ndef is Ndef) {
            final cachedMessage = ndef.cachedMessage;
            final canMakeReadOnly =
                ndef.additionalData['canMakeReadOnly'] as bool?;
            final type = ndef.additionalData['type'] as String?;
            if (type != null)
              result.value.add(FormRow(
                title: Text('Size'),
                subtitle: Text(
                    '${cachedMessage?.byteLength ?? 0} / ${ndef.maxSize} bytes'),
              ));*/
          /* result.value.add(FormRow(
              title: Text('Writable'),
              subtitle: Text('${ndef.isWritable}'),
            ));
            if (canMakeReadOnly != null)
              result.value.add(FormRow(
                title: Text('Can Make Read Only'),
                subtitle: Text('$canMakeReadOnly'),
              ));*/

          NfcManager.instance.stopSession();
          incrementCounter(context);
        },
      );

      print('end reading');
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
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _tagRead();

                      if (result.value == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            title: Text('Error'),
                            content: Text('No card found'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.purple,
                                    ),
                                  )),
                            ],
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
            ],
          ),
        ),
      ),
    );
  }
}
