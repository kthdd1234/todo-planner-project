// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:project/provider/GroupInfoListProvider.dart';
import 'package:project/provider/MemoInfoListProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/UserInfoProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';
import 'package:project/widget/containerView/GroupView.dart';
import 'package:project/widget/containerView/MemoView.dart';
import 'package:project/widget/containerView/TaskCalendarView.dart';
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
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;
    List<MemoInfoClass> memoInfoList =
        context.watch<MemoInfoListProvider>().memoInfoList;

    groupInfoList =
        getGroupInfoOrderList(userInfo.groupOrderList, groupInfoList);

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
                    groupInfoList: groupInfoList,
                    memoInfoList: memoInfoList,
                    calendarFormat: calendarFormat,
                    onFormatChanged: onCalendarFormat,
                  ),
                  MemoView(memoInfoList: memoInfoList),
                  Column(
                    children: groupInfoList
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

    // StreamBuilder<QuerySnapshot>(
    //   stream: groupMethod.stream(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) return const CommonNull();

    //     List<GroupInfoClass> groupInfoList = groupMethod.getGroupInfoList(
    //       snapshot: snapshot,
    //     );
    //     groupInfoList = getGroupInfoOrderList(
    //       userInfo.groupOrderList,
    //       groupInfoList,
    //     );

    //     return MainView(groupInfoList: groupInfoList);
    //   },
    // );
  }
}
