import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:scanner_app/screens/scan_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import './dachboard.dart';
import 'package:provider/provider.dart';
import '../providers/click.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/fire.dart';
import 'package:firebase_core/firebase_core.dart';

class FileScreen extends StatefulWidget {
  static const routeName = '/filescreen';
  String t = '07f6b337';
  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  @override
  Widget build(BuildContext context) {
    //final List<FireBAS> _list = <FireBAS>[];
    bool x = Provider.of<Clicks>(context).idExist;
    var result = Provider.of<Clicks>(context).result;
    /*  getCardi(result) {
      bool x = Provider.of<Clicks>(context).idExist;
      List<dynamic> names = [];
      FirebaseFirestore.instance
          .collection("card")
          .doc('id')
          .get()
          .then((value) {
        // first add the data to the Offset object
        // List.from(value.data()!.values).forEach((element) {
        //   //then add the data to the List<Offset>, now we have a type Offset

        //   _list.add(element);

        //   // print(value.data()!.values);
        // });

        names = value.data()!["ids"];
        if (names.contains(result)) {
          print('ok');
        }

        x = names.contains(result);
      });
      print(names);
    }*/

    String vv = '06b337';
    final v = Provider.of<Clicks>(context).getResult();

    Provider.of<Clicks>(context).checkLiked(result.value);
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
          elevation: 0.0,
          title: Center(
            child: Text(
              'Data',
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.bold),
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
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF04589A),
                          offset: Offset(-7, 7),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder<dynamic>(
                        valueListenable: result,
                        builder: (context, value, _) =>
                            Provider.of<Clicks>(context).idExist
                                ? const Center(
                                    child: Text(
                                      'your   good',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'your not  good',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(255, 255, 0, 0),
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
      ),
    );
  }
}
