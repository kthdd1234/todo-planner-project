import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonCalendar.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/page/PremiumPage.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/CalendarPopup.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskAppBar extends StatelessWidget {
  const TaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        UserBox? user = userRepository.user;
        CalendarFormat calendarFormat =
            calendarFormatInfo[user.calendarFormat]!;
        return TaskTitle(locale: locale, calendarFormat: calendarFormat);
      },
    );
  }
}

class TaskTitle extends StatefulWidget {
  TaskTitle({super.key, required this.locale, required this.calendarFormat});

  CalendarFormat calendarFormat;
  String locale;

  @override
  State<TaskTitle> createState() => _TaskTitleState();
}

class _TaskTitleState extends State<TaskTitle> {
  onCalendarFormat() async {
    UserBox? user = userRepository.user;
    user.calendarFormat =
        nextCalendarFormats[widget.calendarFormat]!.toString();
    await user.save();
  }

  onToday() {
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: DateTime.now());
  }

  onPremiumPage() {
    movePage(context: context, page: const PremiumPage());
  }

  @override
  Widget build(BuildContext context) {
    bool isWeek = availableCalendarFormats[widget.calendarFormat]! == 'week';
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TitleDateTime(),
          Row(
            children: [
              CommonTag(
                isImage: true,
                text: '광고 제거',
                isBold: true,
                fontSize: 10,
                textColor: Colors.white,
                bgColor: isLight ? indigo.s300 : darkButtonColor,
                onTap: onPremiumPage,
              ),
              CommonSpace(width: 5),
              CommonTag(
                text: isWeek ? '일주일' : '한 달',
                isBold: true,
                fontSize: 10,
                textColor: Colors.white,
                bgColor: isLight ? indigo.s300 : darkButtonColor,
                onTap: onCalendarFormat,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TaskCalendar extends StatefulWidget {
  TaskCalendar({
    super.key,
    required this.locale,
    required this.calendarFormat,
  });

  String locale;
  CalendarFormat calendarFormat;

  @override
  State<TaskCalendar> createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
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

  onFormatChanged(CalendarFormat calendarFormat) async {
    String month = CalendarFormat.month.toString();
    String twoWeeks = CalendarFormat.twoWeeks.toString();
    String week = CalendarFormat.week.toString();
    String nextFormat = {
      month: week,
      twoWeeks: month,
      week: month,
    }[calendarFormat.toString()]!;

    UserBox? user = userRepository.user;
    user.calendarFormat = nextFormat;

    await user.save();
  }

  List<TaskBox> onTaskList(DateTime calendarDateTime) {
    int recordKey = dateTimeKey(calendarDateTime);
    List<String>? taskOrderList =
        recordRepository.recordBox.get(recordKey)?.taskOrderList;
    List<TaskBox> taskList = getTaskList(
      locale: context.locale.toString(),
      taskList: taskRepository.taskBox.values.toList(),
      targetDateTime: calendarDateTime,
      orderList: taskOrderList,
    );

    return taskList;
  }

  Widget? stickerBuilder(bool isLight, DateTime dateTime) {
    List<ColorClass?> colorList = [];

    for (var taskBox in onTaskList(dateTime)) {
      if (colorList.length == 9) break;
      colorList.add(getColorClass(taskBox.colorName));
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

  Widget? dowBuilder(bool isLight, DateTime dateTime) {
    String locale = context.locale.toString();
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? textColor
                : Colors.white;

    return CommonText(
      text: eFormatter(locale: locale, dateTime: dateTime),
      color: color,
      fontSize: 13,
      isBold: !isLight,
    );
  }

  Widget? defaultBuilder(bool isLight, DateTime dateTime) {
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? textColor
                : Colors.white;

    return Column(
      children: [
        CommonSpace(height: 13.5),
        CommonText(text: '${dateTime.day}', color: color, isBold: !isLight),
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
      onFormatChanged: onFormatChanged,
    );
  }
}

class TitleDateTime extends StatefulWidget {
  const TitleDateTime({super.key});

  @override
  State<TitleDateTime> createState() => _TitleDateTimeState();
}

class _TitleDateTimeState extends State<TitleDateTime> {
  onDateTime(DateTime dateTime) {
    showDialog(
      context: context,
      builder: (context) => CalendarPopup(
        view: DateRangePickerView.year,
        initialdDateTime: dateTime,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) async {
          context
              .read<TitleDateTimeProvider>()
              .changeTitleDateTime(dateTime: args.value);
          context
              .read<SelectedDateTimeProvider>()
              .changeSelectedDateTime(dateTime: args.value);

          navigatorPop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonSvgText(
      text: yMFormatter(locale: locale, dateTime: titleDateTime),
      fontSize: 18,
      isNotTr: true,
      isBold: !isLight,
      svgName: isLight ? 'dir-down' : 'dir-down-bold',
      svgWidth: 14,
      svgColor: isLight ? textColor : Colors.white,
      svgDirection: SvgDirectionEnum.right,
      onTap: () => onDateTime(titleDateTime),
    );
  }
}
