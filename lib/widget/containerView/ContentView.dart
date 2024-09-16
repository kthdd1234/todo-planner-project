import 'package:flutter/material.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/containerView/ItemView.dart';

class ContentView extends StatelessWidget {
  ContentView({
    super.key,
    required this.groupBox,
    required this.recordBox,
    required this.selectedDateTime,
    required this.taskFilterList,
    required this.onReorder,
  });

  List<TaskBox> taskFilterList;
  DateTime selectedDateTime;
  GroupBox groupBox;
  RecordBox? recordBox;
  Function(int, int, List<TaskBox>) onReorder;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: taskFilterList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        TaskBox taskBox = taskFilterList[index];

        return ItemView(
          key: Key(taskBox.id),
          recordBox: recordBox,
          taskBox: taskBox,
          taskItem: TaskItemClass(
            groupId: groupBox.id,
            id: taskBox.id,
            name: taskBox.name,
            mark: getTaskInfo(
              key: 'mark',
              recordBox: recordBox,
              taskId: taskBox.id,
            ),
            memo: getTaskInfo(
              key: 'memo',
              recordBox: recordBox,
              taskId: taskBox.id,
            ),
            isHighlight: taskBox.isHighlighter == true,
            task: TaskClass(
              groupId: groupBox.id,
              type: taskBox.taskType,
              name: getTaskClass(taskBox.taskType).name,
              dateTimeType: taskBox.dateTimeType,
              dateTimeList: taskBox.dateTimeList,
              dateTimeLabel: getTaskClass(taskBox.taskType).dateTimeLabel,
            ),
            color: getColorClass(taskBox.colorName),
          ),
          selectedDateTime: selectedDateTime,
        );
      },
      onReorder: (oldIdx, newIdx) => onReorder(
        oldIdx,
        newIdx,
        taskFilterList,
      ),
    );
  }
}
