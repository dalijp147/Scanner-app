import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../helpers/db_helpers.dart';
import './scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Clicks with ChangeNotifier {
  int counter = 0;
  ValueNotifier<dynamic> result = ValueNotifier('0');

  List<SCan> data = [];
  bool idExist = false;
  getResult() => result;
  getCounter() => counter;
  void incrementCounter() {
    counter++;
    try {
      DBHelper.insert('SCAN_NUM', {'scannum': counter});
    } catch (eror) {
      print('eror her ');
    }

    notifyListeners();
  }

  checkLiked(result) async {
    print("calling fetch");
    DocumentReference ref =
        FirebaseFirestore.instance.collection("card").doc('id');
    List<dynamic>? list;
    await ref.get().then((value) {
      list = value['ids'];
    });
    idExist = list!.contains(result);
    print("idExist changed to $idExist");
    notifyListeners();
  }

  Future<void> ftechAndSetPlaces() async {
    final dataList = await DBHelper.getData('SCAN_NUM');
    data = dataList
        .map(
          (data) => SCan(
            id: data['id'],
            scannum: data['scannum'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
