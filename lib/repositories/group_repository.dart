import 'package:hive/hive.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/repositories/init_hive.dart';

class GroupRepository {
  Box<GroupBox>? _groupBox;

  Box<GroupBox> get groupBox {
    _groupBox ??= Hive.box<GroupBox>(InitHiveBox.groupBox);
    return _groupBox!;
  }

  List<GroupBox> get groupList {
    return groupBox.values.toList();
  }
}
