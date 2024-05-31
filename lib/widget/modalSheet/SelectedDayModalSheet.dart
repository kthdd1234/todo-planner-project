import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectedDayModalSheet extends StatefulWidget {
  const SelectedDayModalSheet({super.key});

  @override
  State<SelectedDayModalSheet> createState() => _SelectedDayModalSheetState();
}

class _SelectedDayModalSheetState extends State<SelectedDayModalSheet> {
  List<DateTime> selectionList = [DateTime.now()];
  DateTime focusedDay = DateTime.now();
  bool isMultiSelection = false;

  onDaySelected(String locale, DateTime dateTime) {
    int idx = isContainIdxDateTime(
      locale: locale,
      selectionList: selectionList,
      targetDateTime: dateTime,
    );

    setState(() {
      focusedDay = dateTime;

      if (isMultiSelection) {
        if (idx != -1) {
          if (selectionList.length > 1) {
            selectionList.removeAt(idx);
          }
        } else {
          selectionList.add(dateTime);
        }
      } else {
        selectionList = [];
        selectionList.add(dateTime);
      }
    });
  }

  onChanged(bool newValue) {
    setState(() {
      if (newValue == false) {
        DateTime now = DateTime.now();

        selectionList = [now];
        focusedDay = now;
      }

      isMultiSelection = newValue;
    });
  }

  onCompleted() {
    //
  }

  Widget? markerBuilder(
    String locale,
    DateTime dateTime,
  ) {
    int idx = isContainIdxDateTime(
      locale: locale,
      selectionList: selectionList,
      targetDateTime: dateTime,
    );

    if (idx != -1) {
      return Center(
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: indigo.s200,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 0, top: 0),
            child: Center(
              child: CommonText(
                fontSize: 13,
                text: '${dateTime.day}',
                color: Colors.white,
                isBold: true,
                isNotTr: true,
              ),
            ),
          ),
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return CommonModalSheet(
      title: '날짜',
      isBack: true,
      height: 640,
      child: Column(
        children: [
          Expanded(
            child: CommonContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TableCalendar(
                    locale: locale,
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: buttonColor,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: buttonColor,
                      ),
                    ),
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(color: Colors.transparent),
                      todayTextStyle: TextStyle(color: Colors.black),
                      outsideDaysVisible: false,
                    ),
                    focusedDay: focusedDay,
                    firstDay: DateTime(2000, 1, 1),
                    lastDay: DateTime(3000, 1, 1),
                    onDaySelected: (dateTime, _) => onDaySelected(
                      locale,
                      dateTime,
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (btx, dateTime, _) => markerBuilder(
                        locale,
                        dateTime,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonText(text: '날짜 모두 선택하기'),
                      CommonSpace(width: 10),
                      CupertinoSwitch(
                        activeColor: buttonColor,
                        value: isMultiSelection,
                        onChanged: onChanged,
                      )
                    ],
                  )
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
