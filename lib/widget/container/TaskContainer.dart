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
import 'package:project/widget/calendar/calendarMarker.dart';
import 'package:project/widget/modalSheet/TaskSettingModalSheet.dart';
import 'package:project/widget/modalSheet/TitleSettingModalSheet.dart';
import 'package:project/widget/popup/MarkPopup.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

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

  onAddTask(DateTime initDateTime) {
    tTodo.dateTimeList = [initDateTime];

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskSettingModalSheet(
        initTask: tTodo,
      ),
    );
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
            isNotTr: true,
            isBold: !isLight,
            textColor: isLight
                ? getColorClass(colorName).original
                : getColorClass(colorName).s200,
            bgColor: isLight ? getColorClass(colorName).s50 : darkButtonColor,
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
                  line_1: '추가된 할 일이 없어요.',
                  line_2: '+ 버튼을 눌러 추가해보세요.',
                  onTap: () => onAddTask(widget.selectedDateTime),
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

  Widget? markerBuilder(
    String locale,
    DateTime dateTime,
    bool isLight,
  ) {
    int idx = isContainIdxDateTime(
      locale: locale,
      selectionList: widget.taskBox.dateTimeList,
      targetDateTime: dateTime,
      dateTimeType: widget.taskBox.dateTimeType,
    );

    ColorClass color = getColorClass(widget.taskBox.colorName);
    int key = dateTimeKey(dateTime);
    RecordBox? recordBox = recordRepository.recordBox.get(key);
    String? mark = getTaskInfo(
      key: 'mark',
      recordBox: recordBox,
      taskId: widget.taskBox.id,
    );

    if (idx != -1) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 7),
            child: CalendarMarker(
              size: 26,
              day: '${dateTime.day}',
              isLight: isLight,
              color: color,
            ),
          ),
          mark != null
              ? svgAsset(name: 'mark-$mark', width: 12, color: color.s300)
              : const CommonNull()
        ],
      );
    }

    return null;
  }

  onMore(bool isLight) {
    String locale = context.locale.toString();
    String title = yMFormatter(locale: locale, dateTime: DateTime.now());
    DateTime focusedDay =
        widget.taskBox.dateTimeType != taskDateTimeType.everyMonth
            ? widget.taskBox.dateTimeList[0]
            : DateTime(
                widget.selectedDateTime.year,
                widget.selectedDateTime.month,
                widget.taskBox.dateTimeList[0].day,
              );
    ColorClass color = getColorClass(widget.taskBox.colorName);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => CommonModalSheet(
        title: widget.taskItem.name,
        isNotTr: true,
        height: 620,
        child: Column(
          children: [
            CommonContainer(
              height: 420,
              innerPadding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(text: title, fontSize: 16, isNotTr: true),
                        CommonTag(
                          text: taskDateTimeLabel[widget.taskBox.dateTimeType]!,
                          isBold: true,
                          textColor: Colors.white,
                          bgColor: color.s200,
                          fontSize: 11,
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  TableCalendar(
                    locale: locale,
                    rowHeight: 60,
                    headerVisible: false,
                    daysOfWeekStyle: calendarDaysOfWeekStyle(isLight),
                    calendarStyle: calendarDetailStyle(isLight),
                    focusedDay: focusedDay,
                    firstDay: DateTime(2000, 1, 1),
                    lastDay: DateTime(3000, 1, 1),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (btx, dateTime, _) => markerBuilder(
                        locale,
                        dateTime,
                        isLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CommonSpace(height: 10),
            Row(
              children: [
                ModalButton(
                  svgName: 'highlighter',
                  actionText: '${widget.taskItem.task.name} 수정',
                  isBold: !isLight,
                  color: isLight ? textColor : darkTextColor,
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
                  isBold: !isLight,
                  color: red.s200,
                  onTap: () async {
                    widget.recordBox?.taskMarkList?.removeWhere(
                      (taskMark) => taskMark['id'] == widget.taskItem.id,
                    );
                    widget.taskItem.task.dateTimeList = [];

                    await taskRepository.taskBox.delete(widget.taskBox.id);
                    await widget.recordBox?.save();

                    if (isEmptyRecord(widget.recordBox)) {
                      await recordRepository.recordBox
                          .delete(dateTimeKey(widget.selectedDateTime));
                    }

                    navigatorPop(context);
                  },
                ),
              ],
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

    return Container(
      color: isLight ? Colors.white : darkContainerColor,
      child: Padding(
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
                  onTap: () => onMore(isLight),
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
                        isNotTr: true,
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
                                isBold: !isLight,
                                isNotTr: true,
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
