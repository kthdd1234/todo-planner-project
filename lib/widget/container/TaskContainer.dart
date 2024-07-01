import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonEmpty.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:project/widget/border/VerticalBorder.dart';
import 'package:project/widget/modalSheet/TaskSettingModalSheet.dart';
import 'package:project/widget/modalSheet/TitleSettingModalSheet.dart';
import 'package:project/widget/popup/MarkPopup.dart';
import 'package:provider/provider.dart';

class TaskContainer extends StatefulWidget {
  TaskContainer({
    super.key,
    required this.locale,
    required this.selectedDateTime,
    required this.recordBox,
  });

  String locale;
  DateTime selectedDateTime;
  RecordBox? recordBox;

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  UserBox user = userRepository.user;
  Box<TaskBox> taskBox = taskRepository.taskBox;

  onTaskTitle(String taskTitle, String taskColorName) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleSettingModalSheet(
        title: taskTitle,
        colorName: taskColorName,
        onCompleted: (String title_, String colorName_) async {
          user.taskTitleInfo = {'title': title_, 'colorName': colorName_};
          await user.save();
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

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String locale = context.locale.toString();
    List<TaskBox> taskFilterList = getTaskList(
      locale: locale,
      taskList: taskBox.values.toList(),
      targetDateTime: widget.selectedDateTime,
      orderList: widget.recordBox?.taskOrderList,
    );
    Map<String, dynamic> taskTitleInfo = user.taskTitleInfo;
    String taskTitle = taskTitleInfo['title'];
    String colorName = taskTitleInfo['colorName'];

    return CommonContainer(
      outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 60),
      innerPadding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTag(
            text: taskTitle,
            isBold: !isLight,
            textColor: isLight
                ? getColorClass(colorName).original
                : getColorClass(colorName).s50,
            bgColor: isLight
                ? getColorClass(colorName).s50
                : getColorClass(colorName).s400,
            innerPadding: const EdgeInsets.only(bottom: 5),
            onTap: () => onTaskTitle(taskTitle, colorName),
          ),
          taskFilterList.isNotEmpty
              ? ReorderableListView.builder(
                  itemCount: taskFilterList.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    TaskBox taskBox = taskFilterList[index];

                    return TaskItem(
                      key: Key(taskBox.id),
                      recordBox: widget.recordBox,
                      taskBox: taskBox,
                      taskItem: TaskItemClass(
                        id: taskBox.id,
                        name: taskBox.name,
                        mark: getTaskInfo(
                          key: 'mark',
                          recordBox: widget.recordBox,
                          taskId: taskBox.id,
                        ),
                        memo: getTaskInfo(
                          key: 'memo',
                          recordBox: widget.recordBox,
                          taskId: taskBox.id,
                        ),
                        isHighlight: taskBox.isHighlighter == true,
                        task: TaskClass(
                          type: taskBox.taskType,
                          name: getTaskClass(taskBox.taskType).name,
                          dateTimeType: taskBox.dateTimeType,
                          dateTimeList: taskBox.dateTimeList,
                          dateTimeLabel:
                              getTaskClass(taskBox.taskType).dateTimeLabel,
                        ),
                        color: getColorClass(taskBox.colorName),
                      ),
                      selectedDateTime: widget.selectedDateTime,
                    );
                  },
                  onReorder: (oldIdx, newIdx) => onReorder(
                    oldIdx,
                    newIdx,
                    taskFilterList,
                  ),
                )
              : CommonEmpty(
                  height: 300,
                  line_1: '할 일, 루틴이 없어요.',
                  line_2: '+ 버튼을 눌러 추가해보세요.',
                ),
        ],
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  TaskItem({
    super.key,
    required this.recordBox,
    required this.taskBox,
    required this.taskItem,
    required this.selectedDateTime,
  });

  RecordBox? recordBox;
  TaskBox taskBox;
  TaskItemClass taskItem;
  DateTime selectedDateTime;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  wAction({
    required String svgName,
    required Color actionColor,
    required double width,
    required Function() onTap,
  }) {
    return Expanded(
      flex: 0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 5),
          child: CommonSvgButton(
            width: width,
            name: svgName,
            color: actionColor,
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  onMark() {
    showDialog(
      context: context,
      builder: (context) => MarkPopup(
        taskBox: widget.taskBox,
        recordBox: widget.recordBox,
        selectedDateTime: widget.selectedDateTime,
      ),
    );
  }

  onMore() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => CommonModalSheet(
        title: widget.taskItem.name,
        height: 187,
        child: Row(
          children: [
            ModalButton(
              svgName: 'highlighter',
              actionText: '${widget.taskItem.task.name} 수정',
              color: textColor,
              onTap: () {
                navigatorPop(context);
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => TaskSettingModalSheet(
                    initTask: widget.taskItem.task,
                    taskBox: widget.taskBox,
                  ),
                );
              },
            ),
            CommonSpace(width: 5),
            ModalButton(
              svgName: 'remove',
              actionText: '${widget.taskItem.task.name} 삭제',
              color: red.s200,
              onTap: () async {
                navigatorPop(context);

                widget.recordBox?.taskMarkList?.removeWhere(
                  (taskMark) => taskMark['id'] == widget.taskItem.id,
                );
                widget.taskItem.task.dateTimeList = [];

                await taskRepository.taskBox.delete(widget.taskBox.id);
                await widget.recordBox?.save();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isMark = getTaskInfo(
          key: 'mark',
          recordBox: widget.recordBox,
          taskId: widget.taskBox.id,
        ) !=
        null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      child: IntrinsicHeight(
        child: Row(
          children: [
            VerticalBorder(
              color: isLight
                  ? widget.taskItem.color.s100
                  : widget.taskItem.color.s400,
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: onMore,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: widget.taskItem.name,
                      textAlign: TextAlign.start,
                      highlightColor: widget.taskItem.isHighlight == true
                          ? isLight
                              ? widget.taskItem.color.s50
                              : widget.taskItem.color.s400
                          : null,
                      decoration: isMark ? TextDecoration.lineThrough : null,
                      decorationColor:
                          isMark ? widget.taskItem.color.s300 : null,
                      isBold: !isLight,
                    ),
                    widget.taskItem.memo != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: CommonText(
                              text: widget.taskItem.memo!,
                              color: grey.original,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          )
                        : const CommonNull()
                  ],
                ),
              ),
            ),
            wAction(
              svgName: 'mark-${widget.taskItem.mark ?? 'E'}',
              width: 25,
              actionColor: widget.taskItem.mark == null
                  ? isLight
                      ? widget.taskItem.color.s300
                      : widget.taskItem.color.s400
                  : isLight
                      ? widget.taskItem.color.s200
                      : widget.taskItem.color.s300,
              onTap: onMark,
            ),
          ],
        ),
      ),
    );
  }
}

// widget.taskItem.task.dateTimeList.removeWhere((dateTime) {
// String taskType = widget.taskItem.task.type;
// String taskDateTimeType = widget.taskItem.task.dateTimeType;

// if (taskType == tTodo.type) {
//   return dateTimeKey(dateTime) ==
//       dateTimeKey(widget.selectedDateTime);
// } else if (taskType == tRoutin.type) {
//   return taskDateTimeType == dateTimeType.everyWeek
//       ? eFormatter(locale: locale, dateTime: dateTime) ==
//           eFormatter(
//             locale: locale,
//             dateTime: widget.selectedDateTime,
//           )
//       : dateTime.day == widget.selectedDateTime.day;
// }

// return false;
// });
