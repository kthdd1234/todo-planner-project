import 'package:flutter/material.dart';
import 'package:project/util/class.dart';

class InitGroupProvider extends ChangeNotifier {
  String id = '', name = '', desc = '', colorName = '';
  List<TodoClass> todoList = [];

  void changeGroupInfo({
    required String newId,
    required String newName,
    required String newDesc,
    required String newColorName,
  }) {
    id = newId;
    name = newName;
    desc = newDesc;
    colorName = newColorName;

    notifyListeners();
  }

  void addTodo({required TodoClass todo}) {
    todoList.add(todo);

    notifyListeners();
  }
}
