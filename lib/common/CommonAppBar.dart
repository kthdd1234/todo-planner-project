// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/repositories/user_repository.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/VerticalBorder.dart';
import 'package:project/widget/popup/MonthPopup.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonAppBar extends StatefulWidget {
  const CommonAppBar({super.key});

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    UserBox? user = UserRepository().user;
    CalendarFormat calendarFormat = calendarFormatInfo[user.calendarFormat]!;

    return Column(
      children: [
        AppBarTitle(locale: locale, calendarFormat: calendarFormat),
        AppBarCalendar(locale: locale, calendarFormat: calendarFormat),
      ],
    );
  }
}

class AppBarTitle extends StatefulWidget {
  AppBarTitle({super.key, required this.locale, required this.calendarFormat});

  CalendarFormat calendarFormat;
  String locale;

  @override
  State<AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  onDateTime(DateTime dateTime) {
    showDialog(
      context: context,
      builder: (context) => MonthPopup(
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

  onLabel() async {
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
    String calendarLabel = availableCalendarFormats[widget.calendarFormat]!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonSvgText(
            text: yMFormatter(locale: widget.locale, dateTime: titleDateTime),
            fontSize: 18,
            svgName: 'dir-down',
            svgWidth: 14,
            svgDirection: SvgDirectionEnum.right,
            onTap: () => onDateTime(titleDateTime),
          ),
          Row(
            children: [
              CommonSvgButton(
                name: calendarLabel,
                width: 22.5,
                onTap: onLabel,
              ),
              CommonSpace(width: 15),
              CommonSvgButton(
                name: 'setting-indigo',
                color: indigo.s200,
                width: 20,
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AppBarCalendar extends StatefulWidget {
  AppBarCalendar({
    super.key,
    required this.locale,
    required this.calendarFormat,
  });

  String locale;
  CalendarFormat calendarFormat;

  @override
  State<AppBarCalendar> createState() => _AppBarCalendarState();
}

class _AppBarCalendarState extends State<AppBarCalendar> {
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

  Widget? stickerBuilder(btx, calendarDateTime, _) {
    List<ColorClass?> colorList = [];

    for (var taskBox in onTasList(calendarDateTime)) {
      if (colorList.length == 9) break;
      colorList.add(getColorClass(taskBox.colorName));
    }

    while (colorList.length < 9) {
      colorList.add(null);
    }

    wCircle(ColorClass? color) {
      return CommonCircle(
        color: color?.s200 ?? Colors.transparent,
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

  Widget? barBuilder(btx, calendarDateTime, _) {
    List<TaskBox> taskList = onTasList(calendarDateTime);

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
                                color: task.isHighlighter == true
                                    ? getColorClass(task.colorName).s50
                                    : null,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 0,
                                    child: VerticalBorder(
                                      width: 2,
                                      right: 3,
                                      color: getColorClass(task.colorName).s200,
                                    ),
                                  ),
                                  Flexible(
                                    child: CommonText(
                                      text: task.name,
                                      overflow: TextOverflow.clip,
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

  Widget? todayBuilder(context, DateTime day, focusedDay) {
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
                color: indigo.s200,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            CommonText(text: '${day.day}', color: Colors.white, isBold: true)
          ],
        ),
      ],
    );
  }

  Widget? dowBuilder(BuildContext context, DateTime weekNumber) {
    String locale = context.locale.toString();
    Color color = weekNumber.weekday == 6
        ? blue.original
        : weekNumber.weekday == 7
            ? red.original
            : textColor;

    return CommonText(
      text: eFormatter(locale: locale, dateTime: weekNumber),
      color: color,
      fontSize: 13,
    );
  }

  Widget? defaultBuilder(BuildContext btx, DateTime dateTime, _) {
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : textColor;

    return SizedBox(
      child: Column(
        children: [
          CommonSpace(height: 13.5),
          CommonText(text: '${dateTime.day}', color: color),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    bool isMonth = widget.calendarFormat == CalendarFormat.month;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CommonContainer(
        innerPadding: const EdgeInsets.symmetric(vertical: 15),
        outerPadding: const EdgeInsets.symmetric(horizontal: 7),
        height: isMonth ? MediaQuery.of(context).size.height / 1.3 : null,
        child: TableCalendar(
          locale: widget.locale,
          shouldFillViewport: isMonth,
          // startingDayOfWeek: StartingDayOfWeek.monday
          calendarStyle: CalendarStyle(
            cellMargin: const EdgeInsets.all(14),
            cellAlignment: isMonth ? Alignment.topCenter : Alignment.center,
            todayDecoration: BoxDecoration(
              color: indigo.s200,
              shape: BoxShape.circle,
            ),
            todayTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: defaultBuilder,
            dowBuilder: dowBuilder,
            markerBuilder: isMonth ? barBuilder : stickerBuilder,
            todayBuilder: isMonth ? todayBuilder : null,
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
