import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectedDayModalSheet extends StatefulWidget {
  SelectedDayModalSheet({
    super.key,
    required this.color,
    required this.initDateTimeList,
    required this.onCompleted,
  });

  ColorClass color;
  List<DateTime> initDateTimeList;
  Function(List<DateTime>) onCompleted;

  @override
  State<SelectedDayModalSheet> createState() => _SelectedDayModalSheetState();
}

class _SelectedDayModalSheetState extends State<SelectedDayModalSheet> {
  List<DateTime> dateTimeList = [DateTime.now()];
  DateTime focusedDay = DateTime.now();
  bool isMultiSelection = false;

  @override
  initState() {
    dateTimeList = widget.initDateTimeList;
    focusedDay = widget.initDateTimeList[0];
    isMultiSelection = dateTimeList.length > 1;

    super.initState();
  }

  onDaySelected(String locale, DateTime dateTime) {
    int idx = isContainIdxDateTime(
      locale: locale,
      selectionList: dateTimeList,
      targetDateTime: dateTime,
    );

    setState(() {
      focusedDay = dateTime;

      if (isMultiSelection) {
        idx != -1 ? dateTimeList.removeAt(idx) : dateTimeList.add(dateTime);
      } else {
        dateTimeList = [];
        dateTimeList.add(dateTime);
      }
    });
  }

  onChanged(bool newValue) {
    setState(() {
      if (newValue == false) {
        DateTime now = DateTime.now();

        dateTimeList = [now];
        focusedDay = now;
      }

      isMultiSelection = newValue;
    });
  }

  Widget? markerBuilder(
    String locale,
    DateTime dateTime,
    bool isLight,
  ) {
    if (isContainIdxDateTime(
          locale: locale,
          selectionList: dateTimeList,
          targetDateTime: dateTime,
        ) !=
        -1) {
      return Center(
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: isLight ? widget.color.s200 : widget.color.s300,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 0, top: 0),
            child: Center(
              child: CommonText(
                fontSize: 13,
                text: '${dateTime.day}',
                color: isLight ? Colors.white : widget.color.s50,
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
    bool isCompleted = dateTimeList.isNotEmpty;
    bool isLight = context.watch<ThemeProvider>().isLight;

    Color notCompletedBgColor = isLight ? grey.s300 : darkContainerColor;
    Color notCompletedTextColor = isLight ? grey.s400 : const Color(0xff616261);

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
                      titleTextStyle: TextStyle(
                        color: isLight ? Colors.black : Colors.white,
                        fontWeight: isLight ? null : FontWeight.bold,
                      ),
                      formatButtonVisible: false,
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: isLight ? buttonColor : Colors.white,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: isLight ? buttonColor : Colors.white,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(
                        color: isLight ? Colors.black : darkTextColor,
                        fontWeight: isLight ? null : FontWeight.bold,
                      ),
                      weekendTextStyle: TextStyle(
                        color: isLight ? Colors.black : red.s300,
                        fontWeight: isLight ? null : FontWeight.bold,
                      ),
                      todayDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      todayTextStyle: TextStyle(
                        color: isLight ? Colors.black : darkTextColor,
                        fontWeight: isLight ? null : FontWeight.bold,
                      ),
                      outsideDaysVisible: false,
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        fontSize: 13,
                        color: isLight ? Colors.black : darkTextColor,
                        fontWeight: isLight ? null : FontWeight.bold,
                      ),
                      weekendStyle: TextStyle(
                        fontSize: 13,
                        color: red.s300,
                        fontWeight: isLight ? null : FontWeight.bold,
                      ),
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
                        activeColor:
                            isLight ? widget.color.s200 : widget.color.s300,
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
            textColor: isCompleted ? widget.color.s50 : notCompletedTextColor,
            buttonColor: isCompleted ? widget.color.s300 : notCompletedBgColor,
            outerPadding: const EdgeInsets.only(top: 15),
            verticalPadding: 15,
            borderRadius: 100,
            onTap: () => isCompleted ? widget.onCompleted(dateTimeList) : null,
          )
        ],
      ),
    );
  }
}
