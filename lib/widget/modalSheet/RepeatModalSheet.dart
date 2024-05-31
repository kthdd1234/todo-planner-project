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
import 'package:table_calendar/table_calendar.dart';

class RepeatModalSheet extends StatefulWidget {
  const RepeatModalSheet({super.key});

  @override
  State<RepeatModalSheet> createState() => _RepeatModalSheetState();
}

class _RepeatModalSheetState extends State<RepeatModalSheet> {
  String selectedRepeat = repeat.everyWeek;

  @override
  Widget build(BuildContext context) {
    onRepeat(String newValue) {
      setState(() => selectedRepeat = newValue);
    }

    onCompleted() {
      //
    }

    Widget child = {
      repeat.everyWeek: EveryWeekRepeatDay(),
      repeat.everyMonth: EveryMonthRepeatDay(),
    }[selectedRepeat]!;

    return CommonModalSheet(
      title: '반복',
      isBack: true,
      height: selectedRepeat == repeat.everyWeek ? 350 : 540,
      child: Column(
        children: [
          Expanded(
            child: CommonContainer(
              child: Column(
                children: [
                  RepeatButtonContainer(
                    selectedRepeat: selectedRepeat,
                    onTap: onRepeat,
                  ),
                  child
                ],
              ),
            ),
          ),
          CommonButton(
            text: '완료',
            textColor: Colors.white,
            buttonColor: buttonColor,
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

class RepeatButtonContainer extends StatelessWidget {
  RepeatButtonContainer({
    super.key,
    required this.selectedRepeat,
    required this.onTap,
  });

  String selectedRepeat;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          RepeatButton(
            text: '매주',
            type: repeat.everyWeek,
            selectedRepeat: selectedRepeat,
            onTap: onTap,
          ),
          CommonSpace(width: 5),
          RepeatButton(
            text: '매달',
            type: repeat.everyMonth,
            selectedRepeat: selectedRepeat,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class EveryWeekRepeatDay extends StatefulWidget {
  const EveryWeekRepeatDay({super.key});

  @override
  State<EveryWeekRepeatDay> createState() => _EveryWeekRepeatDayState();
}

class _EveryWeekRepeatDayState extends State<EveryWeekRepeatDay> {
  List<WeekDayClass> weekDaydays = List.generate(
    weekDays.length,
    (index) => WeekDayClass(id: index, name: weekDays[index], isVisible: true),
  ).toList();

  onDay(WeekDayClass weekDay) {
    bool isVisible = !weekDay.isVisible;

    if (isVisible == false) {
      bool isOverTwice =
          weekDaydays.where((item) => item.isVisible).toList().length > 1;

      if (isOverTwice == false) return;
    }

    setState(() {
      weekDaydays = weekDaydays.map((item) {
        if (item.id == weekDay.id) {
          item.isVisible = isVisible;
        }

        return item;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: weekDaydays
          .map((item) => Expanded(
                child: CommonButton(
                  text: item.name,
                  fontSize: 13,
                  isBold: item.isVisible,
                  textColor: item.isVisible ? Colors.white : grey.s400,
                  buttonColor: item.isVisible ? indigo.s200 : whiteBgBtnColor,
                  verticalPadding: 10,
                  outerPadding: EdgeInsets.only(
                      right: item.id == weekDaydays.last.id ? 0 : 5),
                  borderRadius: 7,
                  onTap: () => onDay(item),
                ),
              ))
          .toList(),
    );
  }
}

class EveryMonthRepeatDay extends StatefulWidget {
  const EveryMonthRepeatDay({super.key});

  @override
  State<EveryMonthRepeatDay> createState() => _EveryMonthRepeatDayState();
}

class _EveryMonthRepeatDayState extends State<EveryMonthRepeatDay> {
  List<MonthDayClass> monthDays = [for (var i = 1; i <= 31; i++) i]
      .map((id) => MonthDayClass(id: id, isVisible: DateTime.now().day == id))
      .toList();

  onDay(MonthDayClass monthDay) {
    bool isVisible = !monthDay.isVisible;

    if (isVisible == false) {
      bool isOverTwice =
          monthDays.where((item) => item.isVisible).toList().length > 1;

      if (isOverTwice == false) return;
    }

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
                      outerPadding: EdgeInsets.only(left: 0),
                      borderRadius: 7,
                      onTap: () => onDay(monthDay),
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
