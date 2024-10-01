import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonCalendar extends StatefulWidget {
  CommonCalendar({
    super.key,
    required this.selectedDateTime,
    required this.calendarFormat,
    required this.shouldFillViewport,
    required this.markerBuilder,
    this.todayBuilder,
    required this.onPageChanged,
    required this.onDaySelected,
    required this.onFormatChanged,
    this.rowHeight,
  });

  DateTime selectedDateTime;
  CalendarFormat calendarFormat;
  bool shouldFillViewport;
  double? rowHeight;
  Function(bool, DateTime) markerBuilder;
  Function(bool, DateTime)? todayBuilder;
  Function(DateTime) onPageChanged, onDaySelected;
  Function(CalendarFormat) onFormatChanged;

  @override
  State<CommonCalendar> createState() => _CommonCalendarState();
}

class _CommonCalendarState extends State<CommonCalendar> {
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
      isNotTr: true,
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
        CommonText(
          text: '${dateTime.day}',
          color: color,
          isBold: !isLight,
          isNotTr: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;

    tableCalendar() {
      return TableCalendar(
        locale: locale,
        rowHeight: widget.rowHeight ?? 52,
        shouldFillViewport: widget.shouldFillViewport,
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(14),
          cellAlignment: widget.shouldFillViewport
              ? Alignment.topCenter
              : Alignment.center,
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
        availableGestures: widget.shouldFillViewport
            ? AvailableGestures.horizontalSwipe
            : AvailableGestures.all,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (cx, dateTime, _) =>
              defaultBuilder(isLight, dateTime),
          dowBuilder: (cx, dateTime) => dowBuilder(isLight, dateTime),
          markerBuilder: (cx, dateTime, _) =>
              widget.markerBuilder(isLight, dateTime),
          todayBuilder: widget.todayBuilder != null
              ? (cx, dateTime, _) => widget.todayBuilder!(isLight, dateTime)
              : null,
        ),
        headerVisible: false,
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(3000, 1, 1),
        currentDay: widget.selectedDateTime,
        focusedDay: widget.selectedDateTime,
        calendarFormat: widget.calendarFormat,
        availableCalendarFormats: availableCalendarFormats,
        onPageChanged: widget.onPageChanged,
        onDaySelected: (dateTime, _) => widget.onDaySelected(dateTime),
        onFormatChanged: widget.onFormatChanged,
      );
    }

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
        height: widget.shouldFillViewport
            ? MediaQuery.of(context).size.height / 1.4
            : null,
        child: tableCalendar(),
      ),
    );
  }
}
