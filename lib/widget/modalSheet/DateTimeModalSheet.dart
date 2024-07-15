// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSwitch.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/DateTimeButton.dart';
import 'package:project/widget/calendar/calendarMarker.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DateTimeModalSheet extends StatefulWidget {
  DateTimeModalSheet({
    super.key,
    required this.color,
    required this.taskDateTimeInfo,
    required this.onSelection,
    required this.onWeek,
    required this.onMonth,
  });

  ColorClass color;
  TaskDateTimeInfoClass taskDateTimeInfo;
  Function(List<DateTime>) onSelection;
  Function(List<WeekDayClass>) onWeek;
  Function(List<MonthDayClass>) onMonth;

  @override
  State<DateTimeModalSheet> createState() => _DateTimeModalSheetState();
}

class _DateTimeModalSheetState extends State<DateTimeModalSheet> {
  String selectedType = taskDateTimeType.selection;
  DateTime focusedDay = DateTime.now();
  bool isMultiSelection = false;
  List<DateTime> selectionDays = [DateTime.now()];
  List<WeekDayClass> weekDays = List.generate(
    dayLabels.length,
    (index) => WeekDayClass(
      id: index + 1,
      name: dayLabels[index],
      isVisible: false,
    ),
  ).toList();
  List<MonthDayClass> monthDays = [for (var i = 1; i <= 31; i++) i]
      .map((id) => MonthDayClass(id: id, isVisible: false))
      .toList();

  @override
  void initState() {
    List<DateTime> dateTimeList = widget.taskDateTimeInfo.dateTimeList;
    selectedType = widget.taskDateTimeInfo.type;

    if (selectedType == taskDateTimeType.selection) {
      selectionDays = dateTimeList;
      focusedDay = selectionDays[0];
      isMultiSelection = selectionDays.length > 1;
    } else if (selectedType == taskDateTimeType.everyWeek) {
      dateTimeList.forEach(
        (dateTime) => weekDays[dateTime.weekday - 1].isVisible = true,
      );
    } else if (selectedType == taskDateTimeType.everyMonth) {
      dateTimeList
          .forEach((dateTime) => monthDays[dateTime.day - 1].isVisible = true);
    }

    super.initState();
  }

  onChangeType(String type) {
    DateTime now = DateTime.now();

    setState(() {
      if (type == taskDateTimeType.everyWeek && isEmptyWeekDays(weekDays)) {
        weekDays[now.weekday - 1].isVisible = true;
      } else if (type == taskDateTimeType.everyMonth &&
          isEmptyMonthDays(monthDays)) {
        monthDays[now.day - 1].isVisible = true;
      }

      selectedType = type;
    });
  }

  onChangeMultiSelection(bool newValue) {
    setState(() {
      if (newValue == false) {
        DateTime now = DateTime.now();
        selectionDays = [now];
        focusedDay = now;
      }

      isMultiSelection = newValue;
    });
  }

  onSelectionDay(DateTime dateTime) {
    int idx = isContainIdxDateTime(
      locale: context.locale.toString(),
      selectionList: selectionDays,
      targetDateTime: dateTime,
    );

    setState(() {
      focusedDay = dateTime;

      if (isMultiSelection) {
        idx != -1 ? selectionDays.removeAt(idx) : selectionDays.add(dateTime);
      } else {
        selectionDays = [];
        selectionDays.add(dateTime);
      }
    });
  }

  onWeekDay(WeekDayClass weekDay) {
    setState(() {
      weekDays = weekDays.map((item) {
        if (item.id == weekDay.id) {
          item.isVisible = !weekDay.isVisible;
        }

        return item;
      }).toList();
    });
  }

  onMonthDay(MonthDayClass monthDay) {
    bool isVisible = !monthDay.isVisible;

    setState(() {
      monthDays = monthDays.map((item) {
        if (item.id == monthDay.id) {
          item.isVisible = isVisible;
        }

        return item;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCompletedSelection = selectionDays.isNotEmpty;
    bool isCompletedWeek =
        weekDays.where((item) => item.isVisible).toList().isNotEmpty;
    bool isCompletedMonth =
        monthDays.where((item) => item.isVisible).toList().isNotEmpty;

    bool isSelection = selectedType == taskDateTimeType.selection;
    bool isWeek = selectedType == taskDateTimeType.everyWeek;
    bool isMonth = selectedType == taskDateTimeType.everyMonth;

    bool isLight = context.watch<ThemeProvider>().isLight;
    Color notTextColor = isLight ? grey.s400 : Colors.white;
    Color notBgColor = isLight ? whiteBgBtnColor : darkNotSelectedBgColor;

    textColor(bool isVisible) {
      return isVisible ? widget.color.s50 : notTextColor;
    }

    buttonColor(bool isVisible) {
      return isVisible
          ? isLight
              ? widget.color.s200
              : widget.color.s300
          : notBgColor;
    }

    textCompletedColor() {
      return textColor(
        isSelection
            ? isCompletedSelection
            : isWeek
                ? isCompletedWeek
                : isCompletedMonth,
      );
    }

    buttonCompletedColor() {
      return buttonColor(
        isSelection
            ? isCompletedSelection
            : isWeek
                ? isCompletedWeek
                : isCompletedMonth,
      );
    }

    onCompleted() {
      if (isSelection) {
        isCompletedSelection ? widget.onSelection(selectionDays) : null;
      } else if (isWeek) {
        isCompletedWeek ? widget.onWeek(weekDays) : null;
      } else if (isMonth) {
        isCompletedMonth ? widget.onMonth(monthDays) : null;
      }
    }

    Widget child = {
      taskDateTimeType.selection: SelectionDay(
        focusedDay: focusedDay,
        isMultiSelection: isMultiSelection,
        selectionDays: selectionDays,
        color: widget.color,
        onChangeMultiSelection: onChangeMultiSelection,
        onSelectionDay: onSelectionDay,
      ),
      taskDateTimeType.everyWeek: WeekDay(
        weekDays: weekDays,
        textColor: textColor,
        buttonColor: buttonColor,
        onWeekDay: onWeekDay,
      ),
      taskDateTimeType.everyMonth: MonthDay(
        monthDays: monthDays,
        textColor: textColor,
        buttonColor: buttonColor,
        onMonthDay: onMonthDay,
      ),
    }[selectedType]!;

    double height = {
      taskDateTimeType.selection: 675.0,
      taskDateTimeType.everyWeek: 350.0,
      taskDateTimeType.everyMonth: 560.0,
    }[selectedType]!;

    return CommonModalSheet(
      title: '날짜',
      isBack: true,
      height: height,
      child: Column(
        children: [
          Expanded(
            child: CommonContainer(
              child: Column(
                children: [
                  DateTimeContainer(
                    color: widget.color,
                    selectedType: selectedType,
                    onTap: onChangeType,
                  ),
                  child
                ],
              ),
            ),
          ),
          CommonButton(
            text: '완료',
            textColor: textCompletedColor(),
            buttonColor: buttonCompletedColor(),
            outerPadding: const EdgeInsets.only(top: 15),
            verticalPadding: 15,
            borderRadius: 100,
            onTap: onCompleted,
          )
        ],
      ),
    );
  }
}

class DateTimeContainer extends StatelessWidget {
  DateTimeContainer({
    super.key,
    required this.color,
    required this.selectedType,
    required this.onTap,
  });

  ColorClass color;
  String selectedType;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          DateTimeButton(
            text: '선택',
            color: color,
            type: taskDateTimeType.selection,
            selectedType: selectedType,
            onTap: onTap,
          ),
          CommonSpace(width: 5),
          DateTimeButton(
            text: '매주',
            color: color,
            type: taskDateTimeType.everyWeek,
            selectedType: selectedType,
            onTap: onTap,
          ),
          CommonSpace(width: 5),
          DateTimeButton(
            text: '매달',
            color: color,
            type: taskDateTimeType.everyMonth,
            selectedType: selectedType,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class SelectionDay extends StatefulWidget {
  SelectionDay(
      {super.key,
      required this.color,
      required this.focusedDay,
      required this.isMultiSelection,
      required this.selectionDays,
      required this.onSelectionDay,
      required this.onChangeMultiSelection});

  ColorClass color;
  DateTime focusedDay;
  bool isMultiSelection;
  List<DateTime> selectionDays;
  Function(DateTime) onSelectionDay;
  Function(bool) onChangeMultiSelection;

  @override
  State<SelectionDay> createState() => _SelectionDayState();
}

class _SelectionDayState extends State<SelectionDay> {
  Widget? markerBuilder(
    String locale,
    DateTime dateTime,
    bool isLight,
  ) {
    if (isContainIdxDateTime(
          locale: locale,
          selectionList: widget.selectionDays,
          targetDateTime: dateTime,
        ) !=
        -1) {
      return CalendarMarker(
        size: 35,
        day: '${dateTime.day}',
        isLight: isLight,
        color: widget.color,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Expanded(
      child: CommonContainer(
        innerPadding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TableCalendar(
              locale: locale,
              headerStyle: calendarHeaderStyle(isLight),
              calendarStyle: calendarDetailStyle(isLight),
              daysOfWeekStyle: calendarDaysOfWeekStyle(isLight),
              focusedDay: widget.focusedDay,
              firstDay: DateTime(2000, 1, 1),
              lastDay: DateTime(3000, 1, 1),
              onDaySelected: (dateTime, _) => widget.onSelectionDay(dateTime),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (btx, dateTime, _) => markerBuilder(
                  locale,
                  dateTime,
                  isLight,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonText(text: '여러 날짜 선택하기', isBold: !isLight),
                CommonSpace(width: 10),
                CommonSwitch(
                  activeColor: isLight ? widget.color.s200 : widget.color.s300,
                  value: widget.isMultiSelection,
                  onChanged: widget.onChangeMultiSelection,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WeekDay extends StatelessWidget {
  WeekDay({
    super.key,
    required this.textColor,
    required this.buttonColor,
    required this.weekDays,
    required this.onWeekDay,
  });

  List<WeekDayClass> weekDays;
  Function(WeekDayClass) onWeekDay;
  Function(bool) textColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: weekDays
                .map((item) => Expanded(
                      child: CommonButton(
                        text: item.name,
                        fontSize: 13,
                        isBold: item.isVisible,
                        textColor: textColor(item.isVisible),
                        buttonColor: buttonColor(item.isVisible),
                        verticalPadding: 10,
                        outerPadding: EdgeInsets.only(
                          right: item.id == weekDays.last.id ? 0 : 5,
                        ),
                        borderRadius: 7,
                        onTap: () => onWeekDay(item),
                      ),
                    ))
                .toList(),
          ),
          Spacer(),
          InfoText(text: '매주 선택 시 내일 할래요 기능을 사용할 수 없어요.')
        ],
      ),
    );
  }
}

class MonthDay extends StatelessWidget {
  MonthDay({
    super.key,
    required this.textColor,
    required this.buttonColor,
    required this.monthDays,
    required this.onMonthDay,
  });

  List<MonthDayClass> monthDays;
  Function(MonthDayClass) onMonthDay;
  Function(bool) textColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CommonSpace(height: 5),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
            ),
            children: monthDays
                .map((monthDay) => CommonButton(
                      text: monthDay.id.toString(),
                      isNotTr: true,
                      isBold: monthDay.isVisible,
                      textColor: textColor(monthDay.isVisible),
                      buttonColor: buttonColor(monthDay.isVisible),
                      verticalPadding: 10,
                      borderRadius: 7,
                      onTap: () => onMonthDay(monthDay),
                    ))
                .toList(),
          ),
          const Spacer(),
          InfoText(text: '매달 선택 시 내일 할래요 기능을 사용할 수 없어요.')
        ],
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  InfoText({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.info_outline,
          size: 11,
          color: isLight ? grey.s400 : Colors.white,
        ),
        CommonSpace(width: 5),
        CommonText(
          text: text,
          color: isLight ? grey.original : Colors.white,
          fontSize: 11,
        ),
      ],
    );
  }
}
