import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/containerView/ContentView.dart';
import 'package:project/widget/containerView/EmptyView.dart';
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

  onGroupTitle(String taskTitle, String taskColorName) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleSettingModalSheet(
        title: taskTitle,
        colorName: taskColorName,
        onCompleted: (String title_, String colorName_) async {
          //

          navigatorPop(context);
        },
      ),
    );
  }

  onReorder(int oldIdx, int newIdx, List<TaskBox> taskFilterList) async {
    RecordBox? recordBox = widget.recordBox;
    List<String> taskFilterIdList =
        taskFilterList.map((task) => task.id).toList();

    if (oldIdx < newIdx) {
      newIdx -= 1;
    }

    String id = taskFilterIdList.removeAt(oldIdx);
    taskFilterIdList.insert(newIdx, id);

    if (recordBox == null) {
      recordRepository.updateRecord(
        key: dateTimeKey(widget.selectedDateTime),
        record: RecordBox(
          createDateTime: widget.selectedDateTime,
          taskOrderList: taskFilterIdList,
        ),
      );
    } else {
      widget.recordBox!.taskOrderList = taskFilterIdList;
    }

    await widget.recordBox?.save();
    setState(() {});
  }

  onAddTask() {
    tTodo.dateTimeList = [widget.selectedDateTime];
    tTodo.groupId = widget.groupBox.id;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskSettingModalSheet(initTask: tTodo),
    );
  }

  @override
  Widget build(BuildContext context) {
    // List<TaskBox> taskFilterList = getTaskList(
    //   locale: locale,
    //   taskList: taskBox.values.toList(),
    //   targetDateTime: widget.selectedDateTime,
    //   orderList: widget.recordBox?.taskOrderList,
    // );

    return CommonContainer(
      outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleView(
            title: widget.groupBox.name,
            colorName: widget.groupBox.colorName,
            onTitle: onGroupTitle,
          ),
          ContentView(
            groupBox: widget.groupBox,
            recordBox: widget.recordBox,
            selectedDateTime: widget.selectedDateTime,
            taskFilterList: [],
            onReorder: onReorder,
          ),
          AddView(
            colorName: widget.groupBox.colorName,
            onTap: onAddTask,
          )
        ],
      ),
    );
  }
}
