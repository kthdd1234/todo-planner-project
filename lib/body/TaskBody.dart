// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';
import 'package:project/widget/container/MemoContainer.dart';
import 'package:project/widget/container/TaskContainer.dart';
import 'package:project/widget/containerView/taskCalendarView.dart';
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
      child: MultiValueListenableBuilder(
        valueListenables: valueListenables,
        builder: (btx, list, w) {
          return Column(
            children: [
              TaskAppBar(
                calendarFormat: calendarFormat,
                onCalendarFormat: onCalendarFormat,
              ),
              ContentView(calendarFormat: calendarFormat)
            ],
          );
        },
      ),
    );
  }
}

class ContentView extends StatefulWidget {
  ContentView({super.key, required this.calendarFormat});

  CalendarFormat calendarFormat;

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    int recordKey = dateTimeKey(selectedDateTime);
    RecordBox? recordBox = recordRepository.recordBox.get(recordKey);

    List<GroupBox> groupList = getGroupOrderList(groupRepository.groupList);

    return Expanded(
      child: ListView(
        children: [
          TaskCalendarView(calendarFormat: widget.calendarFormat),
          MemoContainer(
            recordBox: recordBox,
            selectedDateTime: selectedDateTime,
          ),
          Column(
            children: groupList
                .map((groupBox) => TaskContainer(
                      groupBox: groupBox,
                      recordBox: recordBox,
                      selectedDateTime: selectedDateTime,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
