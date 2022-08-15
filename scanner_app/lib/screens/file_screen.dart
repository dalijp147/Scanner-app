import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class FileScreen extends StatelessWidget {
  ValueNotifier<dynamic>? result = ValueNotifier(null);

  FileScreen(this.result);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 120,
                width: 50,
                margin: EdgeInsets.all(4),
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(border: Border.all()),
                child: SingleChildScrollView(
                  child: ValueListenableBuilder<dynamic>(
                    valueListenable: result!,
                    builder: (context, value, _) => Text(
                      '${value ?? ''}',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
