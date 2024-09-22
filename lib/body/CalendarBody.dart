import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/appBar/CalendarAppBar.dart';
import 'package:project/widget/containerView/CalendarGroupView.dart';
import 'package:project/widget/containerView/CalendarView.dart';
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
  String selectedGroupId = '';

  @override
  void initState() {
    selectedGroupId = groupRepository.groupList[0].id;
    super.initState();
  }

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

  onSelectedGroupId(String id) {
    setState(() => selectedGroupId = id);
  }

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        return Column(
          children: [
            CalendarAppBar(
              selectedSegment: selectedSegment,
              onCalendar: onCalendar,
              onSegmentedChanged: onSegmentedChanged,
            ),
            CalendarView(
              selectedSegment: selectedSegment,
              selectedGroupId: selectedGroupId,
            ),
            CalendarGroupView(
              selectedGroupId: selectedGroupId,
              onSelectedGroupId: onSelectedGroupId,
            ),
          ],
        );
      },
    );
  }
}
