import 'package:flutter/material.dart';
import 'package:project/common/CommonCalendar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskCalendarView extends StatefulWidget {
  TaskCalendarView({
    super.key,
    required this.groupInfoList,
    required this.memoInfoList,
    required this.calendarFormat,
    required this.onFormatChanged,
  });

  List<GroupInfoClass> groupInfoList;
  List<MemoInfoClass> memoInfoList;
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

    while (colorList.length < 6) {
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

    int index = widget.memoInfoList.indexWhere(
      (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(dateTime),
    );
    MemoInfoClass? memoInfo = index != -1 ? widget.memoInfoList[index] : null;
    bool isMemo = (memoInfo?.imgUrl != null) || (memoInfo?.text != null);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isMemo
            ? Container(
                width: 21,
                height: 3,
                decoration: BoxDecoration(
                  color: isLight ? orange.s100 : orange.s300,
                  borderRadius: BorderRadius.circular(3),
                ),
              )
            : const CommonNull(),
        CommonSpace(height: 3),
        Column(
          children: [
            wRow(colorList.sublist(0, 3)),
            CommonSpace(height: 2),
            wRow(colorList.sublist(3, 6)),
          ],
        ),
      ],
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
