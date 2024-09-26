// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';
import 'package:project/widget/containerView/MainView.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskBody extends StatefulWidget {
  const TaskBody({super.key});

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  CalendarFormat calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    onHorizontalDragEnd(DragEndDetails dragEndDetails) {
      double? primaryVelocity = dragEndDetails.primaryVelocity;

      if (primaryVelocity == null) {
        return;
      } else if (primaryVelocity > 0) {
        selectedDateTime = selectedDateTime.subtract(Duration(days: 1));
      } else if (primaryVelocity < 0) {
        selectedDateTime = selectedDateTime.add(Duration(days: 1));
      }

      context
          .read<SelectedDateTimeProvider>()
          .changeSelectedDateTime(dateTime: selectedDateTime);
      context
          .read<TitleDateTimeProvider>()
          .changeTitleDateTime(dateTime: selectedDateTime);
    }

    onCalendarFormat() {
      setState(() => calendarFormat = nextCalendarFormats[calendarFormat]!);
    }

    return GestureDetector(
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: Column(
        children: [
          TaskAppBar(
            calendarFormat: calendarFormat,
            onCalendarFormat: onCalendarFormat,
          ),
          MainView(calendarFormat: calendarFormat)
        ],
      ),
    );
  }
}
