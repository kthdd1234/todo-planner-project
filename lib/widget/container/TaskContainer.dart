import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/containerView/ContentView.dart';
import 'package:project/widget/containerView/AddView.dart';
import 'package:project/widget/containerView/TitleView.dart';
import 'package:project/widget/modalSheet/TaskSettingModalSheet.dart';
import 'package:project/widget/modalSheet/TitleSettingModalSheet.dart';

class TaskContainer extends StatefulWidget {
  TaskContainer({
    super.key,
    required this.groupBox,
    required this.recordBox,
    required this.selectedDateTime,
  });

  DateTime selectedDateTime;
  GroupBox groupBox;
  RecordBox? recordBox;

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  UserBox user = userRepository.user;
  Box<TaskBox> taskBox = taskRepository.taskBox;

  onTitle(String taskTitle, String taskColorName) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleSettingModalSheet(groupBox: widget.groupBox),
    );
  }

  onOpen() async {
    bool isOpen = widget.groupBox.isOpen;
    widget.groupBox.isOpen = !isOpen;

    await widget.groupBox.save();
  }

  onReorder(int oldIdx, int newIdx, List<TaskBox> taskFilterList) async {
    String groupId = widget.groupBox.id;
    int recordKey = dateTimeKey(widget.selectedDateTime);
    RecordBox? recordBox = recordRepository.recordBox.get(recordKey);
    List<Map<String, dynamic>> recordOrderList =
        recordBox?.recordOrderList ?? [];
    List<String> taskFilterIdList =
        taskFilterList.map((task) => task.id).toList();

    if (oldIdx < newIdx) newIdx -= 1;

    String id = taskFilterIdList.removeAt(oldIdx);
    taskFilterIdList.insert(newIdx, id);

    Map<String, Object> newRecordOrder = {
      'id': groupId,
      'list': taskFilterIdList
    };

    if (recordBox == null) {
      recordRepository.updateRecord(
        key: recordKey,
        record: RecordBox(
          createDateTime: widget.selectedDateTime,
          recordOrderList: [newRecordOrder],
        ),
      );
    } else {
      int index = recordOrderList
          .indexWhere((recordOrder) => recordOrder['id'] == groupId);

      index == -1
          ? recordBox.recordOrderList!.add(newRecordOrder)
          : recordBox.recordOrderList![index]['list'] = taskFilterIdList;

      await recordBox.save();
    }
  }

  onText(TaskBox? taskBox, String text) async {
    UserBox user = userRepository.user;
    String newTaskId = uuid();

    if (taskBox == null) {
      await taskRepository.taskBox.put(
        newTaskId,
        TaskBox(
          groupId: widget.groupBox.id,
          id: newTaskId,
          name: text,
          taskType: tTodo.type,
          isHighlighter: false,
          colorName: widget.groupBox.colorName,
          dateTimeType: taskDateTimeType.selection,
          dateTimeList: [widget.selectedDateTime],
        ),
      );

      await user.save();
    } else {
      taskBox.name = text;
      await taskBox.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isOpen = widget.groupBox.isOpen;
    List<TaskBox> taskFilterList = getTaskList(
      groupId: widget.groupBox.id,
      locale: locale,
      taskList: taskBox.values.toList(),
      targetDateTime: widget.selectedDateTime,
    );

    return CommonContainer(
      outerPadding: EdgeInsets.fromLTRB(7, 0, 7, isOpen ? 30 : 10),
      child: Column(
        children: [
          TitleView(
            title: widget.groupBox.name,
            colorName: widget.groupBox.colorName,
            isOpen: isOpen,
            onTitle: onTitle,
            onOpen: onOpen,
          ),
          isOpen
              ? Column(
                  children: [
                    ContentView(
                      groupBox: widget.groupBox,
                      recordBox: widget.recordBox,
                      selectedDateTime: widget.selectedDateTime,
                      taskFilterList: taskFilterList,
                      onReorder: onReorder,
                    ),
                    AddView(
                      colorName: widget.groupBox.colorName,
                      onText: onText,
                    )
                  ],
                )
              : const CommonNull(),
        ],
      ),
    );
  }
}
