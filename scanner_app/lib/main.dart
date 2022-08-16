import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scanner_app/screens/file_screen.dart';
import 'package:scanner_app/screens/scan_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ValueNotifier<dynamic>? result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SCanScreen()
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
        );
  }
}
