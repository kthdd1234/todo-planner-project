import 'package:flutter/material.dart';

class BottomTabIndexProvider extends ChangeNotifier {
  int seletedIdx;

  BottomTabIndexProvider({this.seletedIdx = 0});

  void changeSeletedIdx({required int newIndex}) {
    seletedIdx = newIndex;
    notifyListeners();
  }
}
