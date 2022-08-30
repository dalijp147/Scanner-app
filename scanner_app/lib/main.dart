import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/dachboard.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scanner_app/screens/file_screen.dart';
import 'package:scanner_app/screens/scan_screen.dart';
import './providers/click.dart';
import 'package:provider/provider.dart';
import './widget/tabs_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ValueNotifier<dynamic>? result = ValueNotifier(null);
  final int counter = 0;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Clicks(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
          '/scanscreen': (context) => SCanScreen(),
          '/filescreen': (context) => FileScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/dashboard': (context) => DachBoard(),
        },

        /*SafeArea(
            child: FutureBuilder<bool>(
              future: NfcManager.instance.isAvailable(),
              builder: (context, ss) => Flex(
                direction: Axis.vertical,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(4),
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(border: Border.all()),
                      child: SingleChildScrollView(
                        child: ValueListenableBuilder<dynamic>(
                          valueListenable: result,
                          builder: (context, value, _) => Text('${value ?? ''}'),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: GridView.count(
                      padding: EdgeInsets.all(4),
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                              child: Text('Tag Read'), onPressed: _tagRead),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),*/
      ),
    );
  }
}
