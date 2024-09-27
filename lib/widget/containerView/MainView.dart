import 'package:flutter/material.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';
import 'package:project/widget/containerView/GroupView.dart';
import 'package:project/widget/containerView/MemoView.dart';
import 'package:project/widget/containerView/TaskCalendarView.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MainView extends StatefulWidget {
  MainView({super.key, required this.groupInfoList});

  List<GroupInfoClass> groupInfoList;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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
        selectedDateTime = selectedDateTime.subtract(const Duration(days: 1));
      } else if (primaryVelocity < 0) {
        selectedDateTime = selectedDateTime.add(const Duration(days: 1));
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TaskCalendarView(
                    groupInfoList: widget.groupInfoList,
                    calendarFormat: calendarFormat,
                  ),
                  MemoView(),
                  Column(
                    children: widget.groupInfoList
                        .map((groupInfo) => GroupView(groupInfo: groupInfo))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
