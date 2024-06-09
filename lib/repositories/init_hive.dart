import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';

class InitHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserBoxAdapter());
    Hive.registerAdapter(RecordBoxAdapter());
    Hive.registerAdapter(TaskBoxAdapter());

    await Hive.openBox<UserBox>(InitHiveBox.userBox);
    await Hive.openBox<RecordBox>(InitHiveBox.recordBox);
    await Hive.openBox<TaskBox>(InitHiveBox.taskBox);
  }
}

class InitHiveBox {
  static const String userBox = 'userBox';
  static const String recordBox = 'recordBox';
  static const String taskBox = 'taskBox';
}
