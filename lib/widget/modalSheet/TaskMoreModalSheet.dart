import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:project/widget/calendar/calendarMarker.dart';
import 'package:project/widget/modalSheet/DateTimeModalSheet.dart';
import 'package:project/widget/modalSheet/TaskSettingModalSheet.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskMoreModalSheet extends StatefulWidget {
  TaskMoreModalSheet({
    super.key,
    required this.recordBox,
    required this.groupBox,
    required this.taskBox,
    required this.taskItem,
    required this.selectedDateTime,
  });

  RecordBox? recordBox;
  GroupBox groupBox;
  TaskBox taskBox;
  TaskItemClass taskItem;
  DateTime selectedDateTime;

  @override
  State<TaskMoreModalSheet> createState() => _TaskMoreModalSheetState();
}

class _TaskMoreModalSheetState extends State<TaskMoreModalSheet> {
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

    ColorClass color = getColorClass(widget.groupBox.colorName);
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
            padding: const EdgeInsets.only(top: 18, bottom: 3),
            child: CalendarMarker(
              size: 25,
              day: '${dateTime.day}',
              isLight: isLight,
              color: color,
            ),
          ),
          mark != null
              ? svgAsset(name: 'mark-$mark', width: 15, color: color.s300)
              : const CommonNull()
        ],
      );
    }

    return null;
  }

  onEdit() {
    navigatorPop(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskSettingModalSheet(
        initTask: widget.taskItem.task,
        taskBox: widget.taskBox,
      ),
    );
  }

  onDateTime(TaskDateTimeInfoClass taskDateTimeInfo) async {
    widget.taskBox.dateTimeType = taskDateTimeInfo.type;
    widget.taskBox.dateTimeList = taskDateTimeInfo.dateTimeList;

    await widget.taskBox.save();

    navigatorPop(context);
    setState(() {});
  }

  onRepeat() {
    DateTime now = DateTime.now();
    ColorClass color = getColorClass(widget.groupBox.colorName);

    // 날짜
    TaskDateTimeInfoClass taskDateTimeInfo = TaskDateTimeInfoClass(
      type: widget.taskBox.dateTimeType,
      dateTimeList: widget.taskBox.dateTimeList,
    );

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => DateTimeModalSheet(
        color: color,
        taskDateTimeInfo: taskDateTimeInfo,
        onSelection: (selectionDays) {
          taskDateTimeInfo.type = taskDateTimeType.selection;
          taskDateTimeInfo.dateTimeList = selectionDays;

          onDateTime(taskDateTimeInfo);
        },
        onWeek: (weekDays) {
          taskDateTimeInfo.type = taskDateTimeType.everyWeek;
          taskDateTimeInfo.dateTimeList = weekDays
              .where((weekDay) => weekDay.isVisible)
              .map((weekday) =>
                  now.subtract(Duration(days: now.weekday - weekday.id)))
              .toList();

          onDateTime(taskDateTimeInfo);
        },
        onMonth: (monthDays) {
          taskDateTimeInfo.type = taskDateTimeType.everyMonth;
          taskDateTimeInfo.dateTimeList = monthDays
              .where((monthDay) => monthDay.isVisible)
              .map((monthDay) => DateTime(now.year, 1, monthDay.id))
              .toList();

          onDateTime(taskDateTimeInfo);
        },
      ),
    );
  }

  onRemove() async {
    UserBox user = userRepository.user;

    widget.recordBox?.taskMarkList?.removeWhere(
      (taskMark) => taskMark['id'] == widget.taskItem.id,
    );
    // taskItem.task.dateTimeList = [];

    // user.groupOrderList?.forEach((groupInfo) {
    //   if (groupInfo['id'] == groupBox.id) {
    //     groupInfo['list'].remove(taskBox.id);
    //   }
    // });

    await taskRepository.taskBox.delete(widget.taskBox.id);
    await widget.recordBox?.save();

    // if (isEmptyRecord(recordBox)) {
    //   await recordRepository.recordBox
    //       .delete(dateTimeKey(selectedDateTime));
    // }

    navigatorPop(context);
  }

  Widget? defaultBuilder(bool isLight, DateTime dateTime) {
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? Colors.black
                : Colors.white;

    return Column(
      children: [
        CommonSpace(height: 22),
        CommonText(text: '${dateTime.day}', color: color, isNotTr: true),
      ],
    );
  }

  Widget? dowBuilder(bool isLight, DateTime dateTime) {
    String locale = context.locale.toString();
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? Colors.black
                : Colors.white;

    return CommonText(
      text: eFormatter(locale: locale, dateTime: dateTime),
      color: color,
      fontSize: 13,
      isNotTr: true,
    );
  }

  Widget? todayBuilder(bool isLight, DateTime dateTime) {
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? Colors.black
                : Colors.white;

    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        children: [
          CommonText(
            text: '${dateTime.day}',
            color: color,
            isNotTr: true,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
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
    ColorClass color = getColorClass(widget.groupBox.colorName);

    return CommonModalSheet(
      title: widget.taskItem.name,
      isNotTr: true,
      height: 680,
      child: Column(
        children: [
          CommonContainer(
            innerPadding: EdgeInsets.all(5),
            height: 480,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
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
                  sixWeekMonthsEnforced: true,
                  locale: locale,
                  rowHeight: 64,
                  headerVisible: false,
                  focusedDay: focusedDay,
                  firstDay: DateTime(2000, 1, 1),
                  lastDay: DateTime(3000, 1, 1),
                  calendarStyle: CalendarStyle(cellAlignment: Alignment.center),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (btx, dateTime, _) => markerBuilder(
                      locale,
                      dateTime,
                      isLight,
                    ),
                    defaultBuilder: (cx, dateTime, _) =>
                        defaultBuilder(isLight, dateTime),
                    dowBuilder: (cx, dateTime) => dowBuilder(isLight, dateTime),
                    todayBuilder: (cx, dateTime, __) =>
                        todayBuilder(isLight, dateTime),
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
                actionText: '할 일 수정',
                isBold: !isLight,
                color: isLight ? textColor : darkTextColor,
                onTap: onEdit,
              ),
              CommonSpace(width: 5),
              ModalButton(
                svgName: 'bnb-calendar',
                actionText: '반복 설정',
                isBold: !isLight,
                color: isLight ? textColor : darkTextColor,
                onTap: onRepeat,
              ),
              CommonSpace(width: 5),
              ModalButton(
                svgName: 'remove',
                actionText: '할 일 삭제',
                isBold: !isLight,
                color: red.s200,
                onTap: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
