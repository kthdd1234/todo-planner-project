// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonCalendar.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/ad/BannerAd.dart';
import 'package:project/widget/appBar/CalendarAppBar.dart';
import 'package:project/widget/border/VerticalBorder.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) => Column(
        children: [
          CalendarAppBar(),
          Expanded(child: SingleChildScrollView(child: ContentView())),
        ],
      ),
    );
  }
}

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
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
                color: isLight ? indigo.s200 : calendarSelectedDateTimeBgColor,
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

  List<TaskBox> onTaskList(DateTime calendarDateTime) {
    int recordKey = dateTimeKey(calendarDateTime);
    List<String>? taskOrderList =
        recordRepository.recordBox.get(recordKey)?.taskOrderList;
    List<TaskBox> taskList = getTaskList(
      locale: context.locale.toString(),
      taskList: taskRepository.taskBox.values.toList(),
      targetDateTime: calendarDateTime,
      orderList: taskOrderList,
    );

    return taskList;
  }

  Widget? barBuilder(bool isLight, DateTime dateTime) {
    List<TaskBox> taskList = onTaskList(dateTime);

    Color? highlighterColor(TaskBox task) {
      bool isHighlighter = task.isHighlighter == true;

      return isHighlighter
          ? isLight
              ? getColorClass(task.colorName).s50
              : getColorClass(task.colorName).original
          : null;
    }

    return taskList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 40, right: 5, left: 5),
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: taskList
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

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: CommonCalendar(
        selectedDateTime: selectedDateTime,
        calendarFormat: CalendarFormat.month,
        shouldFillViewport: true,
        markerBuilder: barBuilder,
        todayBuilder: todayBuilder,
        onPageChanged: onPageChanged,
        onDaySelected: onDaySelected,
        onFormatChanged: (_) {},
      ),
    );
  }
}
