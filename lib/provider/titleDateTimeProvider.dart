import 'package:flutter/material.dart';

class TitleDateTimeProvider extends ChangeNotifier {
  DateTime titleDateTime = DateTime.now();

  void changeTitleDateTime({required DateTime dateTime}) {
    titleDateTime = dateTime;
    notifyListeners();
  }
}
