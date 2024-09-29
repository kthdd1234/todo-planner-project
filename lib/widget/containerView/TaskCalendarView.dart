import 'package:flutter/material.dart';
import 'package:project/common/CommonCalendar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskCalendarView extends StatefulWidget {
  TaskCalendarView({
    super.key,
    required this.groupInfoList,
    required this.calendarFormat,
    required this.onFormatChanged,
  });

  List<GroupInfoClass> groupInfoList;
  CalendarFormat calendarFormat;
  Function() onFormatChanged;

  @override
  State<TaskCalendarView> createState() => _TaskCalendarViewState();
}

class _TaskCalendarViewState extends State<TaskCalendarView> {
  onDaySelected(DateTime dateTime) {
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: dateTime);
  }

  onPageChanged(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);
  }

  // onFormatChanged(CalendarFormat calendarFormat) async {

  // String month = CalendarFormat.month.toString();
  // String twoWeeks = CalendarFormat.twoWeeks.toString();
  // String week = CalendarFormat.week.toString();
  // String nextFormat = {
  //   month: week,
  //   twoWeeks: month,
  //   week: month,
  // }[calendarFormat.toString()]!;

  // UserBox? user = userRepository.user;
  // user.calendarFormat = nextFormat;

  // await user.save();
  // }

  Widget? stickerBuilder(bool isLight, DateTime dateTime) {
    String locale = context.locale.toString();
    List<ColorClass?> colorList = [];

    for (var groupInfo in widget.groupInfoList) {
      List<TaskInfoClass> taskInfoList = getTaskInfoList(
        locale: locale,
        groupInfo: groupInfo,
        targetDateTime: dateTime,
      );

      bool isRecord = taskInfoList.any((taskInfo) {
        return taskInfo.recordInfoList.any((record) =>
            (record.dateTimeKey == dateTimeKey(dateTime)) &&
            (record.mark != null));
      });

      if (colorList.length != 9 && isRecord) {
        colorList.add(getColorClass(groupInfo.colorName));
      }
    }

    while (colorList.length < 9) {
      colorList.add(null);
    }

    wCircle(ColorClass? color) {
      return CommonCircle(
        color: (isLight ? color?.s200 : color?.s300) ?? Colors.transparent,
        size: 5,
        padding: const EdgeInsets.symmetric(horizontal: 1),
      );
    }

    wRow(List<ColorClass?> list) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list.map((color) => wCircle(color)).toList(),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: ListView(
        children: [
          wRow(colorList.sublist(0, 3)),
          CommonSpace(height: 2),
          wRow(colorList.sublist(3, 6)),
          CommonSpace(height: 2),
          wRow(colorList.sublist(6, 9)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return CommonCalendar(
      selectedDateTime: selectedDateTime,
      calendarFormat: widget.calendarFormat,
      shouldFillViewport: false,
      markerBuilder: stickerBuilder,
      onPageChanged: onPageChanged,
      onDaySelected: onDaySelected,
      onFormatChanged: (_) => widget.onFormatChanged(),
    );
  }
}
