import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/main.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/containerView/TaskView.dart';
import 'package:provider/provider.dart';

class ContentView extends StatelessWidget {
  ContentView({super.key, required this.groupInfo});

  GroupInfoClass groupInfo;

  onReorder({
    required int oldIndex,
    required int newIndex,
    required List<TaskInfoClass> taskInfoList,
    required DateTime selectedDateTime,
  }) async {
    List<String> taskInfoIdList =
        taskInfoList.map((taskInfo) => taskInfo.tid).toList();

    if (oldIndex < newIndex) newIndex -= 1;

    String id = taskInfoIdList.removeAt(oldIndex);
    taskInfoIdList.insert(newIndex, id);

    Map<String, dynamic> newTaskOrder = {
      'dateTimeKey': dateTimeKey(selectedDateTime),
      'list': taskInfoIdList
    };

    if (groupInfo.taskOrderList.isEmpty) {
      groupInfo.taskOrderList.add(newTaskOrder);
    } else {
      int index = groupInfo.taskOrderList.indexWhere((taskOrder) =>
          taskOrder['dateTimeKey'] == dateTimeKey(selectedDateTime));

      index == -1
          ? groupInfo.taskOrderList.add(newTaskOrder)
          : groupInfo.taskOrderList[index]['list'] = taskInfoIdList;
    }

    await groupMethod.updateGroup(gid: groupInfo.gid, groupInfo: groupInfo);
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    int index = groupInfo.taskOrderList.indexWhere(
      (taskOrder) => taskOrder['dateTimeKey'] == dateTimeKey(selectedDateTime),
    );

    List<String>? taskOrderList =
        index != -1 ? groupInfo.taskOrderList[index]['list'] : null;

    return StreamBuilder<QuerySnapshot>(
      stream: taskMethod.stream(gid: groupInfo.gid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CommonNull();

        List<TaskInfoClass> taskInfoList = taskMethod.getTaskInfoList(
          gid: groupInfo.gid,
          snapshot: snapshot,
        );

        taskInfoList = getTaskList(
          locale: locale,
          groupId: groupInfo.gid,
          taskInfoList: taskInfoList,
          targetDateTime: selectedDateTime,
          taskOrderList: taskOrderList,
        );

        return ReorderableListView.builder(
          itemCount: taskInfoList.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          onReorder: (oldIndex, newIndex) => onReorder(
            oldIndex: oldIndex,
            newIndex: newIndex,
            taskInfoList: taskInfoList,
            selectedDateTime: selectedDateTime,
          ),
          itemBuilder: (context, index) {
            TaskInfoClass taskInfo = taskInfoList[index];

            return TaskView(
              key: Key(taskInfo.tid),
              selectedDateTime: selectedDateTime,
              groupInfo: groupInfo,
              taskInfo: taskInfo,
            );
          },
        );
      },
    );
  }
}
