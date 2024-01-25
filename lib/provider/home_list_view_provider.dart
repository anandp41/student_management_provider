import 'package:flutter/material.dart';

class HomeListViewProvider extends ChangeNotifier {
  bool isListOn = true;

  void toggleView() {
    isListOn = !isListOn;
    notifyListeners();
  }
}
