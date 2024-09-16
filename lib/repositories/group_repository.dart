import 'dart:developer';

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

  void addGroup(GroupBox group) async {
    int key = await groupBox.add(group);

    log('[addGroup] add (key:$key) $group');
    log('result ${groupList.toList()}');
  }

  void updateGroup({required dynamic key, required GroupBox group}) async {
    await groupBox.put(key, group);
    log('[updateGroup] update (key:$key) $group');
  }

  void deleteGroup(int key) async {
    await groupBox.delete(key);

    log('[deleteGroup] delete (key:$key)');
    log('result $groupList');
  }
}
