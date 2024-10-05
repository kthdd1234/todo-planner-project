import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/provider/GroupInfoListProvider.dart';
import 'package:project/provider/MemoInfoListProvider.dart';
import 'package:project/provider/UserInfoProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/appBar/CalendarAppBar.dart';
import 'package:project/widget/view/CalendarGroupView.dart';
import 'package:project/widget/view/CalendarView.dart';
import 'package:project/widget/popup/CalendarPopup.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  SegmentedTypeEnum selectedSegment = SegmentedTypeEnum.todo;
  int selectedGroupInfoIndex = 0;

  onCalendar(DateTime dateTime) {
    showDialog(
      context: context,
      builder: (context) => CalendarPopup(
        view: DateRangePickerView.year,
        initialdDateTime: dateTime,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) async {
          context
              .read<TitleDateTimeProvider>()
              .changeTitleDateTime(dateTime: args.value);
          context
              .read<SelectedDateTimeProvider>()
              .changeSelectedDateTime(dateTime: args.value);

          navigatorPop(context);
        },
      ),
    );
  }

  onSegmentedChanged(segment) {
    setState(() => selectedSegment = segment);
  }

  onSelectedGroupInfoIndex(int index) {
    setState(() => selectedGroupInfoIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;
    List<MemoInfoClass> memoInfoList =
        context.watch<MemoInfoListProvider>().memoInfoList;

    groupInfoList =
        getGroupInfoOrderList(userInfo.groupOrderList, groupInfoList);

    return Column(
      children: [
        CalendarAppBar(
          selectedSegment: selectedSegment,
          onCalendar: onCalendar,
          onSegmentedChanged: onSegmentedChanged,
        ),
        CalendarView(
          selectedSegment: selectedSegment,
          groupInfoList: groupInfoList,
          memoInfoList: memoInfoList,
          selectedGroupInfoIndex: selectedGroupInfoIndex,
        ),
        GroupListView(
          selectedSegment: selectedSegment,
          groupInfoList: groupInfoList,
          selectedGroupInfoIndex: selectedGroupInfoIndex,
          onSelectedGroupInfoIndex: onSelectedGroupInfoIndex,
        ),
      ],
    );
  }
}
