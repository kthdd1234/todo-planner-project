// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/RepeatButton.dart';
import 'package:provider/provider.dart';

class RepeatModalSheet extends StatefulWidget {
  RepeatModalSheet({
    super.key,
    required this.color,
    required this.taskDateTimeInfo,
    required this.onCompletedEveryWeek,
    required this.onCompletedEveryMonth,
  });

  ColorClass color;
  TaskDateTimeInfoClass taskDateTimeInfo;
  Function(List<WeekDayClass>) onCompletedEveryWeek;
  Function(List<MonthDayClass>) onCompletedEveryMonth;

  @override
  State<RepeatModalSheet> createState() => _RepeatModalSheetState();
}

class _RepeatModalSheetState extends State<RepeatModalSheet> {
  String selectedRepeatType = taskDateTimeType.everyWeek;
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

    selectedRepeatType = widget.taskDateTimeInfo.type;

    if (selectedRepeatType == taskDateTimeType.everyWeek) {
      dateTimeList.forEach(
        (dateTime) => weekDays[dateTime.weekday - 1].isVisible = true,
      );
    } else if (selectedRepeatType == taskDateTimeType.everyMonth) {
      dateTimeList
          .forEach((dateTime) => monthDays[dateTime.day - 1].isVisible = true);
    }

    super.initState();
  }

  onRepeatType(String type) {
    DateTime now = DateTime.now();

    setState(() {
      if (type == taskDateTimeType.everyWeek && isEmptyWeekDays(weekDays)) {
        weekDays[now.weekday - 1].isVisible = true;
      } else if (type == taskDateTimeType.everyMonth &&
          isEmptyMonthDays(monthDays)) {
        monthDays[now.day - 1].isVisible = true;
      }

      selectedRepeatType = type;
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
    bool isCompletedWeek =
        weekDays.where((item) => item.isVisible).toList().isNotEmpty;
    bool isCompletedMonth =
        monthDays.where((item) => item.isVisible).toList().isNotEmpty;

    bool isLight = context.watch<ThemeProvider>().isLight;
    Color notTextColor = isLight ? grey.s400 : Colors.white;
    Color notBgColor = isLight ? whiteBgBtnColor : darkNotSelectedBgColor;

    onTextColor(bool isVisible) {
      return isVisible ? widget.color.s50 : notTextColor;
    }

    onButtonColor(bool isVisible) {
      return isVisible
          ? isLight
              ? widget.color.s200
              : widget.color.s300
          : notBgColor;
    }

    Widget child = {
      taskDateTimeType.everyWeek: EveryWeekRepeatDay(
        textColor: onTextColor,
        buttonColor: onButtonColor,
        weekDays: weekDays,
        onWeekDay: onWeekDay,
      ),
      taskDateTimeType.everyMonth: EveryMonthRepeatDay(
        textColor: onTextColor,
        buttonColor: onButtonColor,
        monthDays: monthDays,
        onMonthDay: onMonthDay,
      ),
    }[selectedRepeatType]!;

    return CommonModalSheet(
      title: '반복',
      isBack: true,
      height: selectedRepeatType == taskDateTimeType.everyWeek ? 350 : 560,
      child: Column(
        children: [
          Expanded(
            child: CommonContainer(
              child: Column(
                children: [
                  RepeatButtonContainer(
                    color: widget.color,
                    selectedRepeatType: selectedRepeatType,
                    onTap: onRepeatType,
                  ),
                  child
                ],
              ),
            ),
          ),
          CommonButton(
            text: '완료',
            textColor: selectedRepeatType == taskDateTimeType.everyWeek
                ? onTextColor(isCompletedWeek)
                : onTextColor(isCompletedMonth),
            buttonColor: selectedRepeatType == taskDateTimeType.everyWeek
                ? onButtonColor(isCompletedWeek)
                : onButtonColor(isCompletedMonth),
            outerPadding: const EdgeInsets.only(top: 15),
            verticalPadding: 15,
            borderRadius: 100,
            onTap: () => selectedRepeatType == taskDateTimeType.everyWeek
                ? isCompletedWeek
                    ? widget.onCompletedEveryWeek(weekDays)
                    : null
                : isCompletedMonth
                    ? widget.onCompletedEveryMonth(monthDays)
                    : null,
          )
        ],
      ),
    );
  }
}

class RepeatButtonContainer extends StatelessWidget {
  RepeatButtonContainer({
    super.key,
    required this.color,
    required this.selectedRepeatType,
    required this.onTap,
  });

  ColorClass color;
  String selectedRepeatType;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          RepeatButton(
            text: '매주',
            color: color,
            type: taskDateTimeType.everyWeek,
            selectedRepeatType: selectedRepeatType,
            onTap: onTap,
          ),
          CommonSpace(width: 5),
          RepeatButton(
            text: '매달',
            color: color,
            type: taskDateTimeType.everyMonth,
            selectedRepeatType: selectedRepeatType,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class EveryWeekRepeatDay extends StatelessWidget {
  EveryWeekRepeatDay({
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
    return Row(
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
    );
  }
}

class EveryMonthRepeatDay extends StatelessWidget {
  EveryMonthRepeatDay({
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
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Expanded(
      child: Column(
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
                      isBold: monthDay.isVisible,
                      textColor: textColor(monthDay.isVisible),
                      buttonColor: buttonColor(monthDay.isVisible),
                      verticalPadding: 10,
                      borderRadius: 7,
                      onTap: () => onMonthDay(monthDay),
                    ))
                .toList(),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 3, top: 1),
                child: Icon(Icons.info_outline, size: 12, color: grey.s400),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonText(
                    text: '30일, 31일을 선택할 경우 해당 일자가 없는 달에는',
                    color: isLight ? grey.original : Colors.white,
                    fontSize: 11,
                  ),
                  CommonText(
                    text: '할 일 화면에 표시되지 않아요.',
                    color: isLight ? grey.original : Colors.white,
                    fontSize: 11,
                    textAlign: TextAlign.end,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
