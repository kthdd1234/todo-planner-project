import 'package:flutter/material.dart';

class ReloadProvider extends ChangeNotifier {
  bool isReload = false;

  setReload(bool state) {
    isReload = state;
    notifyListeners();
  }
}
