import 'package:flutter/material.dart';

class YearDateTimeProvider extends ChangeNotifier {
  DateTime yearDateTime = DateTime.now();

  void changeYearDateTime({required DateTime dateTime}) {
    yearDateTime = dateTime;
    notifyListeners();
  }
}
