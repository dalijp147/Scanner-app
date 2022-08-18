import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scanner_app/screens/scan_screen.dart';
import './dachboard.dart';

class FileScreen extends StatelessWidget {
  ValueNotifier<dynamic>? result = ValueNotifier(null);

  FileScreen(this.result);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.blue])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              'Data',
              textAlign: TextAlign.justify,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.blue])),
          child: Column(
            children: [
              Expanded(
                child: SafeArea(
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.all(4),
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.purple, Colors.blue],
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder<dynamic>(
                        valueListenable: result!,
                        builder: (context, value, _) => result!.value == null
                            ? Center(
                                child: Text('there is no data '),
                              )
                            : Text(
                                '${value}',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                      ),
                    ),
                  ),
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
                onPressed: () {
                  Navigator.pushNamed(context, '/scanscreen');
                },
                icon: Icon(
                  Icons.wifi_find,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.book_rounded,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
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
}
