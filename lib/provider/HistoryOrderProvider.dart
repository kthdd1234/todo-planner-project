import 'package:flutter/material.dart';

class HistoryOrderProvider with ChangeNotifier {
  bool isRecent = true;

  setOrder(bool newValue) {
    isRecent = newValue;
    notifyListeners();
  }
}
