import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonModalItem.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonOutlineInputField.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/modalSheet/CategoryModalSheet.dart';
import 'package:project/widget/modalSheet/ColorModalsheet.dart';
import 'package:project/widget/modalSheet/RepeatModalSheet.dart';
import 'package:project/widget/modalSheet/SelectedDayModalSheet.dart';

class TaskSettingModalSheet extends StatefulWidget {
  TaskSettingModalSheet({
    super.key,
    required this.task,
    required this.initDateTime,
  });

  TaskClass task;
  DateTime initDateTime;

  @override
  State<TaskSettingModalSheet> createState() => _TaskSettingModalSheetState();
}

class _TaskSettingModalSheetState extends State<TaskSettingModalSheet> {
  // 형광색
  bool isHighlighter = false;

  // 색상
  String selectedColorName = '파란색';

  // 날짜
  List<DateTime> selectedDateTimeList = [DateTime.now()];

  // 반복
  RepeatInfoClass selectedRepeatInfo = RepeatInfoClass(
    type: repeatType.everyWeek,
    selectedDateTimeList: [DateTime.now()],
  );

  // 할 일/루틴 이름
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    String taskType = widget.task.type;
    if (taskType == tTodo.type) {
      selectedDateTimeList = [widget.initDateTime];
    } else if (taskType == tRoutin.type) {
      selectedRepeatInfo.selectedDateTimeList = [widget.initDateTime];
    }

    super.initState();
  }

  onHighlighter(bool newValue) {
    setState(() => isHighlighter = newValue);
  }

  onColor() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ColorModalSheet(
        selectedColorName: selectedColorName,
        onTap: (String colorName) {
          setState(() => selectedColorName = colorName);
          navigatorPop(context);
        },
      ),
    );
  }

  onSelectedDay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SelectedDayModalSheet(
        initDateTimeList: selectedDateTimeList,
        onCompleted: (List<DateTime> dateTimeList) {
          setState(() => selectedDateTimeList = dateTimeList);
          navigatorPop(context);
        },
      ),
    );
  }

  onRepeatDay() {
    DateTime now = DateTime.now();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => RepeatModalSheet(
        initRepeatInfo: selectedRepeatInfo,
        onCompletedEveryWeek: (weekDays) {
          selectedRepeatInfo.type = repeatType.everyWeek;
          selectedRepeatInfo.selectedDateTimeList = weekDays
              .where((weekDay) => weekDay.isVisible)
              .map((weekday) =>
                  now.subtract(Duration(days: now.weekday - weekday.id)))
              .toList();

          navigatorPop(context);
          setState(() {});
        },
        onCompletedEveryMonth: (monthDays) {
          selectedRepeatInfo.type = repeatType.everyMonth;
          selectedRepeatInfo.selectedDateTimeList = monthDays
              .where((monthDay) => monthDay.isVisible)
              .map((monthDay) => DateTime(now.year, 1, monthDay.id))
              .toList();

          navigatorPop(context);
          setState(() {});
        },
      ),
    );
  }

  displayTodoDateTime(String locale) {
    String result = ymdeFormatter(
      locale: locale,
      dateTime: selectedDateTimeList[0],
    );

    selectedDateTimeList
        .sort((dtA, dtB) => ymdToInt(dtA).compareTo(ymdToInt(dtB)));

    return '$result${selectedDateTimeList.length > 2 ? '....+${selectedDateTimeList.length - 1}' : ''}';
  }

  displayRepeatDateTime(String locale) {
    if (selectedRepeatInfo.type == repeatType.everyWeek) {
      String join = selectedRepeatInfo.selectedDateTimeList
          .map((dateTime) => eFormatter(locale: locale, dateTime: dateTime))
          .join(', ');

      return '매주 - $join';
    } else if (selectedRepeatInfo.type == repeatType.everyMonth) {
      List<String> list = selectedRepeatInfo.selectedDateTimeList
          .map((dateTime) => dFormatter(locale: locale, dateTime: dateTime))
          .toList();
      String join = '';
      join = list.length > 5
          ? '${list.sublist(0, 5).join(', ')}...'
          : list.join(', ');

      return '매달 - $join';
    }
  }

  onEditingComplete() {
    // todo
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isTodo = widget.task.type == tTodo.type;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '${widget.task.name} 추가',
        height: 330,
        child: CommonContainer(
          innerPadding: const EdgeInsets.only(
            left: 15,
            top: 0,
            right: 15,
            bottom: 0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonModalItem(
                title: '형광색',
                onTap: () => onHighlighter(!isHighlighter),
                child: CupertinoSwitch(
                  activeColor: indigo.s300,
                  value: isHighlighter,
                  onChanged: onHighlighter,
                ),
              ),
              CommonModalItem(
                title: '색상',
                onTap: onColor,
                child: CommonTag(
                  text: getColor(selectedColorName).colorName,
                  textColor: getColor(selectedColorName).original,
                  bgColor: getColor(selectedColorName).s50,
                  onTap: onColor,
                ),
              ),
              CommonModalItem(
                title: widget.task.dateTimeLable,
                onTap: isTodo ? onSelectedDay : onRepeatDay,
                child: CommonSvgText(
                  text: isTodo
                      ? displayTodoDateTime(locale)
                      : displayRepeatDateTime(locale),
                  fontSize: 14,
                  textColor: textColor,
                  svgColor: grey.s400,
                  svgName: 'dir-right',
                  svgWidth: 7,
                  svgLeft: 7,
                  svgDirection: SvgDirectionEnum.right,
                  onTap: isTodo ? onSelectedDay : onRepeatDay,
                ),
              ),
              CommonSpace(height: 17.5),
              CommonOutlineInputField(
                hintText: '할 일을 입력해주세요',
                controller: controller,
                onEditingComplete: onEditingComplete,
              )
            ],
          ),
        ),
      ),
    );
  }
}
