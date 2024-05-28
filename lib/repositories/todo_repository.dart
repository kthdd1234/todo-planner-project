import 'package:hive/hive.dart';
import 'package:project/model/todo_box/todo_box.dart';
import 'package:project/repositories/init_hive.dart';

class TodoRepository {
  Box<TodoBox>? _todoBox;

  Box<TodoBox> get todoBox {
    _todoBox ??= Hive.box<TodoBox>(InitHiveBox.todoBox);
    return _todoBox!;
  }

  List<TodoBox> get todoList {
    return todoBox.values.toList();
  }
}
