import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Clicks with ChangeNotifier {
  int counter = 0;
  List<Clicks> data = [];

  getCounter() => counter;
  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
