import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonCalendar.dart';
import 'package:project/common/CommonImage.dart';
import 'package:project/common/CommonMask.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/VerticalBorder.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  CalendarView({
    super.key,
    required this.selectedSegment,
    required this.selectedGroupId,
    this.todayColor,
  });

  SegmentedTypeEnum selectedSegment;
  String selectedGroupId;
  Color? todayColor;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  onDaySelected(DateTime dateTime) {
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: dateTime);
  }

  onPageChanged(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);
  }

  Widget? todayBuilder(bool isLight, DateTime dateTime) {
    GroupBox? selectedGroup =
        groupRepository.groupBox.get(widget.selectedGroupId);
    Color todayColor = getColorClass(selectedGroup?.colorName ?? '남색').s200;

    return Column(
      children: [
        CommonSpace(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 27.5,
              height: 27.5,
              decoration: BoxDecoration(
                color: isLight ? todayColor : calendarSelectedDateTimeBgColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            CommonText(
              text: '${dateTime.day}',
              color: isLight ? Colors.white : calendarSelectedDateTimeTextColor,
              isBold: isLight,
              isNotTr: true,
            )
          ],
        ),
      ],
    );
  }

  Widget? barBuilder(bool isLight, DateTime dateTime) {
    String locale = context.locale.toString();
    // int recordKey = dateTimeKey(dateTime);
    // RecordBox? recordBox = recordRepository.recordBox.get(recordKey);
    // List<TaskBox> taskList = getTaskList(
    //   groupId: widget.selectedGroupId,
    //   locale: locale,
    //   taskList: taskRepository.taskList,
    //   targetDateTime: dateTime,
    // );

    Color? highlighterColor(TaskBox taskBox) {
      ColorClass color = getColorClass(taskBox.colorName);
      String? mark =
          getRecordInfo(recordInfoList: [], targetDateTime: dateTime)?.mark;

      return mark != null && mark != 'E'
          ? isLight
              ? color.s50
              : color.original
          : null;
    }

    return [].isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 40, right: 5, left: 5),
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: []
                      .map(
                        (task) => IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: highlighterColor(task),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 0,
                                    child: VerticalBorder(
                                      width: 2,
                                      right: 3,
                                      color: isLight
                                          ? getColorClass(task.colorName).s200
                                          : getColorClass(task.colorName).s300,
                                    ),
                                  ),
                                  Flexible(
                                    child: CommonText(
                                      text: task.name,
                                      overflow: TextOverflow.clip,
                                      isBold: !isLight,
                                      fontSize: 9,
                                      softWrap: false,
                                      textAlign: TextAlign.start,
                                      isNotTr: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        : const CommonNull();
  }

  Widget? memoBuilder(bool isLight, DateTime dateTime) {
    int recordKey = dateTimeKey(dateTime);
    RecordBox? recordBox = recordRepository.recordBox.get(recordKey);
    List<Uint8List>? imageList = recordBox?.imageList ?? [];

    if (imageList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Center(
              child: CommonImage(
                uint8List: imageList[0],
                radious: 3,
                width: 35,
                height: 50,
                onTap: (_) {},
              ),
            ),
            Center(child: CommonMask(width: 35, height: 50, opacity: 0.2)),
            CommonText(text: '')
            // Center(
            //   child: Container(
            //     padding: const EdgeInsets.all(3),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(100),
            //     ),
            //     child: CommonText(
            //       text: '${dateTime.day}',
            //       isNotTr: true,
            //       color: Colors.white,
            //       isBold: true,
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }

    return const CommonNull();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    bool isTodo = widget.selectedSegment == SegmentedTypeEnum.todo;

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: CommonCalendar(
            selectedDateTime: selectedDateTime,
            calendarFormat: CalendarFormat.month,
            shouldFillViewport: true,
            markerBuilder: isTodo ? barBuilder : memoBuilder,
            todayBuilder: todayBuilder,
            onPageChanged: onPageChanged,
            onDaySelected: onDaySelected,
            onFormatChanged: (_) {},
          ),
        ),
      ),
    );
  }
}
