import 'package:flutter/material.dart';

class SelectedDateTimeProvider extends ChangeNotifier {
  DateTime seletedDateTime = DateTime.now();

  SelectedDateTimeProvider();

  void changeSelectedDateTime({required DateTime dateTime}) {
    seletedDateTime = dateTime;
    notifyListeners();
  }
}
