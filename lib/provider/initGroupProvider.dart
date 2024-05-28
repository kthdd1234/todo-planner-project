import 'package:flutter/material.dart';
import 'package:project/util/class.dart';

class InitGroupProvider extends ChangeNotifier {
  String id = '', name = '', desc = '', colorName = '';
  List<TodoClass> todoList = [];

  void initGroupInfo() {
    id = '';
    name = '';
    desc = '';
    colorName = '';
    todoList = [];

    notifyListeners();
  }

  void changeGroupInfo({
    required String newId,
    required String newName,
    required String newColorName,
  }) {
    id = newId;
    name = newName;
    colorName = newColorName;

    notifyListeners();
  }

  void addTodo({required TodoClass todo}) {
    todoList.add(todo);
    notifyListeners();
  }

  void editTodo({required TodoClass todo}) {
    todoList =
        todoList.map((info) => info.id == todo.id ? todo : info).toList();
    notifyListeners();
  }

  void removeTodo({required TodoClass todo}) {
    todoList.removeWhere((info) => info.id == todo.id);
    notifyListeners();
  }

  void changeOrderTodo(int oldIdx, int newIdx) {
    if (oldIdx < newIdx) {
      newIdx -= 1;
    }

    todoList.insert(newIdx, todoList.removeAt(oldIdx));
    notifyListeners();
  }
}
