import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  String theme = 'light';

  String themeValue() {
    return theme;
  }

  setThemeValue(String newValue) {
    theme = newValue;
    notifyListeners();
  }

  bool get isLight {
    return theme == 'light';
  }
}
