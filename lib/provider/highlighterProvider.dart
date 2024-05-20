import 'package:flutter/material.dart';

class HighlighterProvider extends ChangeNotifier {
  bool isHighlighter = false;

  void changeHighlighter({required bool newValue}) {
    isHighlighter = newValue;
    notifyListeners();
  }
}
