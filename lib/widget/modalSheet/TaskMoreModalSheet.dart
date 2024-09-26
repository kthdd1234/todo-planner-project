import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/main.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:project/widget/calendar/CalendarMarker.dart';
import 'package:project/widget/modalSheet/DateTimeModalSheet.dart';
import 'package:project/widget/modalSheet/TaskSettingModalSheet.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskMoreModalSheet extends StatefulWidget {
  TaskMoreModalSheet({
    super.key,
    required this.groupInfo,
    required this.taskInfo,
    required this.selectedDateTime,
  });

  GroupInfoClass groupInfo;
  TaskInfoClass taskInfo;
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
      selectionList: widget.taskInfo.dateTimeList,
      targetDateTime: dateTime,
      dateTimeType: widget.taskInfo.dateTimeType,
    );
    String colorName = widget.groupInfo.colorName;
    ColorClass color = getColorClass(colorName);
    String? mark = getRecordInfo(
      recordList: widget.taskInfo.recordList,
      targetDateTime: dateTime,
    )?.mark;

    if (idx != -1) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 3),
            child: CalendarMarker(
              size: 25,
              day: '${dateTime.day}',
              isLight: isLight,
              color: color,
              borderRadius: 5,
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
        groupInfo: widget.groupInfo,
        taskInfo: widget.taskInfo,
      ),
    );
  }

  onDateTime(TaskDateTimeInfoClass taskDateTimeInfo) async {
    widget.taskInfo.dateTimeType = taskDateTimeInfo.type;
    widget.taskInfo.dateTimeList = taskDateTimeInfo.dateTimeList;

    await taskMethod.updateTask(
      gid: widget.groupInfo.gid,
      tid: widget.taskInfo.tid,
      taskInfo: widget.taskInfo,
    );

    navigatorPop(context);
    setState(() {});
  }

  onRepeat() {
    DateTime now = DateTime.now();
    String colorName = widget.groupInfo.colorName;
    ColorClass color = getColorClass(colorName);

    // 날짜
    TaskDateTimeInfoClass taskDateTimeInfo = TaskDateTimeInfoClass(
      type: widget.taskInfo.dateTimeType,
      dateTimeList: widget.taskInfo.dateTimeList,
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
    await taskMethod.deleteTask(
      gid: widget.groupInfo.gid,
      tid: widget.taskInfo.tid,
      groupInfo: widget.groupInfo,
      dateTime: widget.selectedDateTime,
    );

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
      padding: const EdgeInsets.only(top: 21),
      child: Column(
        children: [
          CommonText(
            text: '${dateTime.day}',
            color: color,
            isNotTr: true,
            fontSize: 15,
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
        widget.taskInfo.dateTimeType != taskDateTimeType.everyMonth
            ? widget.taskInfo.dateTimeList[0]
            : DateTime(
                widget.selectedDateTime.year,
                widget.selectedDateTime.month,
                widget.taskInfo.dateTimeList[0].day,
              );
    ColorClass color = getColorClass(widget.groupInfo.colorName);

    return CommonModalSheet(
      title: widget.taskInfo.name,
      isNotTr: true,
      height: 680,
      child: Column(
        children: [
          CommonContainer(
            innerPadding: const EdgeInsets.all(5),
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
                        text: taskDateTimeLabel[widget.taskInfo.dateTimeType]!,
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
                  calendarStyle:
                      const CalendarStyle(cellAlignment: Alignment.center),
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
