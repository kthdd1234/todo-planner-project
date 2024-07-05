import 'package:flutter/material.dart';

class KeywordProvider extends ChangeNotifier {
  String keyword = '';

  void changeKeyword(String newKeyword) {
    keyword = newKeyword;
    notifyListeners();
  }
}
