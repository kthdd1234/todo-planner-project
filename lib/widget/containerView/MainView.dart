import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/main.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/provider/UserInfoProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/containerView/GroupView.dart';
import 'package:project/widget/containerView/MemoView.dart';
import 'package:project/widget/containerView/taskCalendarView.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MainView extends StatelessWidget {
  MainView({super.key, required this.calendarFormat});

  CalendarFormat calendarFormat;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    int recordKey = dateTimeKey(selectedDateTime);
    RecordBox? recordBox = recordRepository.recordBox.get(recordKey);

    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<String> groupOrderList = userInfo.groupOrderList;

    return Expanded(
      child: ListView(
        children: [
          TaskCalendarView(calendarFormat: calendarFormat),
          MemoView(
            recordBox: recordBox,
            selectedDateTime: selectedDateTime,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: groupMethod.stream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CommonNull();

              List<GroupInfoClass> groupInfoList =
                  groupMethod.getGroupInfoList(snapshot: snapshot);
              groupInfoList =
                  getGroupInfoOrderList(groupOrderList, groupInfoList);

              return Column(
                children: groupInfoList
                    .map((groupInfo) => GroupView(groupInfo: groupInfo))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
