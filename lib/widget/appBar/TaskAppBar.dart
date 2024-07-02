import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/VerticalBorder.dart';
import 'package:project/widget/popup/CalendarPopup.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskAppBar extends StatelessWidget {
  TaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        UserBox? user = userRepository.user;
        CalendarFormat calendarFormat =
            calendarFormatInfo[user.calendarFormat]!;

        return Column(
          children: [
            TaskTitle(locale: locale, calendarFormat: calendarFormat),
            TaskCalendar(locale: locale, calendarFormat: calendarFormat),
          ],
        );
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
  onDateTime(DateTime dateTime) {
    showDialog(
      context: context,
      builder: (context) => CalendarPopup(
        view: DateRangePickerView.year,
        initialdDateTime: dateTime,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) async {
          UserBox? user = userRepository.user;
          context
              .read<TitleDateTimeProvider>()
              .changeTitleDateTime(dateTime: args.value);
          context
              .read<SelectedDateTimeProvider>()
              .changeSelectedDateTime(dateTime: args.value);

          user.calendarFormat = CalendarFormat.month.toString();
          await user.save();

          navigatorPop(context);
        },
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;
    bool isWeek = availableCalendarFormats[widget.calendarFormat]! == 'week';
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonSvgText(
            text: yMFormatter(locale: widget.locale, dateTime: titleDateTime),
            fontSize: 18,
            isBold: !isLight,
            svgName: isLight ? 'dir-down' : 'dir-down-bold',
            svgWidth: 14,
            svgColor: isLight ? textColor : Colors.white,
            svgDirection: SvgDirectionEnum.right,
            onTap: () => onDateTime(titleDateTime),
          ),
          CommonTag(
            text: isWeek ? '일주일' : '한 달',
            isBold: true,
            fontSize: 10,
            textColor: Colors.white,
            bgColor: isLight ? indigo.s200 : darkButtonColor,
            onTap: onCalendarFormat,
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
  onDaySelected(DateTime dateTime, _) {
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: dateTime);
  }

  onPageChanged(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);
  }

  List<TaskBox> onTasList(DateTime calendarDateTime) {
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

  Widget? stickerBuilder(bool isLight, DateTime dateTime) {
    List<ColorClass?> colorList = [];

    for (var taskBox in onTasList(dateTime)) {
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

  Widget? barBuilder(bool isLight, DateTime dateTime) {
    List<TaskBox> taskList = onTasList(dateTime);

    Color? highlighterColor(TaskBox task) {
      bool isHighlighter = task.isHighlighter == true;

      return isHighlighter
          ? isLight
              ? getColorClass(task.colorName).s50
              : getColorClass(task.colorName).original
          : null;
    }

    return taskList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 40, right: 5, left: 5),
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: taskList
                      .map(
                        (task) => IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: highlighterColor(task),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 0,
                                    child: VerticalBorder(
                                      width: 2,
                                      right: 3,
                                      color: isLight
                                          ? getColorClass(task.colorName).s200
                                          : getColorClass(task.colorName).s300,
                                    ),
                                  ),
                                  Flexible(
                                    child: CommonText(
                                      text: task.name,
                                      overflow: TextOverflow.clip,
                                      isBold: !isLight,
                                      fontSize: 9,
                                      softWrap: false,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        : const CommonNull();
  }

  Widget? todayBuilder(bool isLight, DateTime dateTime) {
    return Column(
      children: [
        CommonSpace(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 27.5,
              height: 27.5,
              decoration: BoxDecoration(
                color: isLight ? indigo.s200 : calendarSelectedDateTimeBgColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            CommonText(
              text: '${dateTime.day}',
              color: isLight ? Colors.white : calendarSelectedDateTimeTextColor,
              isBold: isLight,
            )
          ],
        ),
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
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isMonth = widget.calendarFormat == CalendarFormat.month;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CommonContainer(
        color: isLight ? Colors.white : darkBgColor,
        innerPadding: isLight
            ? const EdgeInsets.symmetric(vertical: 15)
            : const EdgeInsets.all(0),
        outerPadding: isLight
            ? const EdgeInsets.symmetric(horizontal: 7)
            : const EdgeInsets.only(bottom: 15),
        height: isMonth ? MediaQuery.of(context).size.height / 1.3 : null,
        child: TableCalendar(
          locale: widget.locale,
          shouldFillViewport: isMonth,
          calendarStyle: CalendarStyle(
            cellMargin: const EdgeInsets.all(14),
            cellAlignment: isMonth ? Alignment.topCenter : Alignment.center,
            todayDecoration: BoxDecoration(
              color: isLight ? indigo.s200 : calendarSelectedDateTimeBgColor,
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              color: isLight ? Colors.white : calendarSelectedDateTimeTextColor,
              fontWeight: isLight ? FontWeight.bold : null,
              fontSize: 13,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (cx, dateTime, _) =>
                defaultBuilder(isLight, dateTime),
            dowBuilder: (cx, dateTime) => dowBuilder(isLight, dateTime),
            markerBuilder: (cx, dateTime, _) => isMonth
                ? barBuilder(isLight, dateTime)
                : stickerBuilder(isLight, dateTime),
            todayBuilder: isMonth
                ? (cx, dateTime, _) => todayBuilder(isLight, dateTime)
                : null,
          ),
          headerVisible: false,
          firstDay: DateTime.utc(2000, 1, 1),
          lastDay: DateTime.utc(3000, 1, 1),
          currentDay: selectedDateTime,
          focusedDay: selectedDateTime,
          calendarFormat: widget.calendarFormat,
          availableCalendarFormats: availableCalendarFormats,
          onPageChanged: onPageChanged,
          onDaySelected: onDaySelected,
          onFormatChanged: onFormatChanged,
        ),
      ),
    );
  }
}

// dayBuilder(context, day, events) {
//   return Container(
//     padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
//     decoration: BoxDecoration(
//       color: Colors.indigo.shade100, // const Color(0xffF3F4F9)
//       borderRadius: BorderRadius.circular(3),
//     ),
//     child: CommonText(
//       text: 'D-12',
//       fontSize: 9,
//       color: Colors.white,
//       isBold: true,
//     ),
//   );
// }

  // Row(
   //         children: [
              // CommonSvgButton(
              //   name: '$calendarLabel-${isLight ? 'indigo' : 'white'}',
              //   width: 22,
              //   onTap: onLabel,
              // ),
              // CommonSpace(width: 15),
              // CommonSvgButton(
              //   name: 'setting-${isLight ? 'indigo' : 'white'}',
              //   color: isLight ? indigo.s200 : Colors.white,
              //   width: 20,
              //   onTap: onSetting,
              // ),
          //  ],
     //     )