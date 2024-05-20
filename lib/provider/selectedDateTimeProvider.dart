import 'package:flutter/material.dart';

class SelectedDateTimeProvider extends ChangeNotifier {
  DateTime seletedDateTime = DateTime.now();

  void changeSeletedDateTime({required DateTime dateTime}) {
    seletedDateTime = dateTime;
    notifyListeners();
  }
}
