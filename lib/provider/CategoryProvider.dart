import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String id = '', name = '', colorName = '';

  void categoryInfo() {
    id = '';
    name = '';
    colorName = '';

    notifyListeners();
  }

  void changeCategoryInfo({
    required String newId,
    required String newName,
    required String newColorName,
  }) {
    id = newId;
    name = newName;
    colorName = newColorName;

    notifyListeners();
  }
}
