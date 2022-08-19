import 'package:flutter/material.dart';

class Clicks with ChangeNotifier {
  int counter = 0;
  getCounter() => counter;
  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
