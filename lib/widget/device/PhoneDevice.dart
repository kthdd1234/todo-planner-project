import 'package:flutter/cupertino.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/page/homePage.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/widget/ad/BannerAd.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';
import 'package:project/widget/view/GroupView.dart';
import 'package:project/widget/view/MemoView.dart';
import 'package:project/widget/view/TaskCalendarView.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class PhoneDevice extends StatelessWidget {
  PhoneDevice({
    super.key,
    required this.calendarFormat,
    required this.groupInfoList,
    required this.memoInfoList,
    required this.onHorizontalDragEnd,
    required this.onCalendarFormat,
  });

  CalendarFormat calendarFormat;
  List<GroupInfoClass> groupInfoList;
  List<MemoInfoClass> memoInfoList;
  Function(DragEndDetails) onHorizontalDragEnd;
  Function() onCalendarFormat;

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    return GestureDetector(
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: Column(
        children: [
          TaskAppBar(
            memoInfoList: memoInfoList,
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
          !isPremium ? const BannerAdWidget() : const CommonNull(),
        ],
      ),
    );
  }
}
