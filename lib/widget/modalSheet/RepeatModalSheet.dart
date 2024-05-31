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
      height: selectedRepeat == repeat.everyWeek ? 350 : 500,
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
  List<WeekDayClass> days = List.generate(
    weekDays.length,
    (index) => WeekDayClass(idx: index, name: weekDays[index], isVisible: true),
  ).toList();

  onDay(WeekDayClass selectedItem) {
    setState(() {
      days = days.map((item) {
        if (item.idx == selectedItem.idx) {
          item.isVisible = !selectedItem.isVisible;
        }

        return item;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: days
          .map((item) => Expanded(
                child: CommonButton(
                  text: item.name,
                  fontSize: 13,
                  isBold: item.isVisible,
                  textColor: item.isVisible ? Colors.white : grey.s400,
                  buttonColor: item.isVisible ? indigo.s200 : whiteBgBtnColor,
                  verticalPadding: 10,
                  outerPadding: const EdgeInsets.only(right: 5),
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
  List<MonthDayClass> days = [for (var i = 1; i <= 31; i++) i]
      .map((id) => MonthDayClass(id: id, isVisible: false))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(children: []);
  }
}
