// ignore_for_file: prefer_const_constructors
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';
import 'package:project/widget/container/MemoContainer.dart';
import 'package:project/widget/container/TaskContainer.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskBody extends StatelessWidget {
  const TaskBody({super.key});

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

    return GestureDetector(
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: MultiValueListenableBuilder(
        valueListenables: valueListenables,
        builder: (btx, list, w) {
          return Column(children: [TaskAppBar(), ContentView()]);
        },
      ),
    );
  }
}

class ContentView extends StatefulWidget {
  ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    UserBox? user = userRepository.user;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    int recordKey = dateTimeKey(selectedDateTime);
    RecordBox? recordBox = recordRepository.recordBox.get(recordKey);
    CalendarFormat calendarFormat = calendarFormatInfo[user.calendarFormat]!;

    List<GroupBox> groupList = groupRepository.groupList;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TaskCalendar(calendarFormat: calendarFormat),
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
      ),
    );
  }
}
