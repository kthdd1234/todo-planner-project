import 'package:hive/hive.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/repositories/init_hive.dart';

class TaskRepository {
  Box<TaskBox>? _taskBox;

  Box<TaskBox> get taskBox {
    _taskBox ??= Hive.box<TaskBox>(InitHiveBox.taskBox);
    return _taskBox!;
  }

  List<TaskBox> get taskList {
    return taskBox.values.toList();
  }
}
