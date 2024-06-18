// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/RepeatButton.dart';

class RepeatModalSheet extends StatefulWidget {
  RepeatModalSheet({
    super.key,
    required this.taskDateTimeInfo,
    required this.onCompletedEveryWeek,
    required this.onCompletedEveryMonth,
  });

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
    Widget child = {
      taskDateTimeType.everyWeek: EveryWeekRepeatDay(
        weekDays: weekDays,
        onWeekDay: onWeekDay,
      ),
      taskDateTimeType.everyMonth: EveryMonthRepeatDay(
        monthDays: monthDays,
        onMonthDay: onMonthDay,
      ),
    }[selectedRepeatType]!;

    bool isCompletedWeek =
        weekDays.where((item) => item.isVisible).toList().isNotEmpty;

    bool isCompletedMonth =
        monthDays.where((item) => item.isVisible).toList().isNotEmpty;

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
                ? isCompletedWeek
                    ? Colors.white
                    : grey.s400
                : isCompletedMonth
                    ? Colors.white
                    : grey.s400,
            buttonColor: selectedRepeatType == taskDateTimeType.everyWeek
                ? isCompletedWeek
                    ? buttonColor
                    : grey.s300
                : isCompletedMonth
                    ? buttonColor
                    : grey.s300,
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
    required this.selectedRepeatType,
    required this.onTap,
  });

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
            type: taskDateTimeType.everyWeek,
            selectedRepeatType: selectedRepeatType,
            onTap: onTap,
          ),
          CommonSpace(width: 5),
          RepeatButton(
            text: '매달',
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
    required this.weekDays,
    required this.onWeekDay,
  });

  List<WeekDayClass> weekDays;
  Function(WeekDayClass) onWeekDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: weekDays
          .map((item) => Expanded(
                child: CommonButton(
                  text: item.name,
                  fontSize: 13,
                  isBold: item.isVisible,
                  textColor: item.isVisible ? Colors.white : grey.s400,
                  buttonColor: item.isVisible ? indigo.s200 : whiteBgBtnColor,
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
    required this.monthDays,
    required this.onMonthDay,
  });

  List<MonthDayClass> monthDays;
  Function(MonthDayClass) onMonthDay;

  @override
  Widget build(BuildContext context) {
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
                      textColor: monthDay.isVisible ? Colors.white : grey.s400,
                      buttonColor:
                          monthDay.isVisible ? indigo.s200 : whiteBgBtnColor,
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
                    color: grey.original,
                    fontSize: 11,
                  ),
                  CommonText(
                    text: '할 일 화면에 표시되지 않아요.',
                    color: grey.original,
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
