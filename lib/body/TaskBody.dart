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
import 'package:project/widget/device/PhoneDevice.dart';
import 'package:project/widget/device/TabletDevice.dart';
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

    return isTablet
        ? TabletDevice(
            calendarFormat: calendarFormat,
            groupInfoList: groupInfoList,
            memoInfoList: memoInfoList,
            onHorizontalDragEnd: onHorizontalDragEnd,
            onCalendarFormat: onCalendarFormat,
          )
        : PhoneDevice(
            calendarFormat: calendarFormat,
            groupInfoList: groupInfoList,
            memoInfoList: memoInfoList,
            onHorizontalDragEnd: onHorizontalDragEnd,
            onCalendarFormat: onCalendarFormat,
          );
  }
}
