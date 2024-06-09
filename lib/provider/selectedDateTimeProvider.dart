import 'package:flutter/material.dart';

class SelectedDateTimeProvider extends ChangeNotifier {
  DateTime seletedDateTime = DateTime.now();

  void changeSelectedDateTime({required DateTime dateTime}) {
    seletedDateTime = dateTime;
    notifyListeners();
  }
}
