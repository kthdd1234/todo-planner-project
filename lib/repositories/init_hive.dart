import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/todo_box/todo_box.dart';
import 'package:project/model/user_box/user_box.dart';

class InitHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserBoxAdapter());
    Hive.registerAdapter(RecordBoxAdapter());
    Hive.registerAdapter(GroupBoxAdapter());
    Hive.registerAdapter(TodoBoxAdapter());

    await Hive.openBox<UserBox>(InitHiveBox.userBox);
    await Hive.openBox<RecordBox>(InitHiveBox.recordBox);
    await Hive.openBox<GroupBox>(InitHiveBox.groupBox);
    await Hive.openBox<TodoBox>(InitHiveBox.todoBox);
  }
}

class InitHiveBox {
  static const String userBox = 'userBox';
  static const String recordBox = 'recordBox';
  static const String groupBox = 'groupBox';
  static const String todoBox = 'todoBox';
}
