// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalItem.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonOutlineInputField.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonSwitch.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/listView/ColorListView.dart';
import 'package:project/widget/modalSheet/DateTimeModalSheet.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class TaskSettingModalSheet extends StatefulWidget {
  TaskSettingModalSheet({
    super.key,
    required this.initTask,
    this.taskBox,
  });

  TaskClass initTask;
  TaskBox? taskBox;

  @override
  State<TaskSettingModalSheet> createState() => _TaskSettingModalSheetState();
}

class _TaskSettingModalSheetState extends State<TaskSettingModalSheet> {
  // 형광색
  bool isHighlighter = false;

  // 색상
  String selectedColorName = '남색';

  // 날짜
  TaskDateTimeInfoClass taskDateTimeInfo = TaskDateTimeInfoClass(
    type: taskDateTimeType.selection,
    dateTimeList: [DateTime.now()],
  );

  // 할 일
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    TaskBox? taskBox = widget.taskBox;

    if (taskBox != null) {
      isHighlighter = taskBox.isHighlighter == true;
      selectedColorName = taskBox.colorName;
      taskDateTimeInfo.type = taskBox.dateTimeType;
      taskDateTimeInfo.dateTimeList = taskBox.dateTimeList;
      controller.text = taskBox.name;
    } else {
      taskDateTimeInfo.dateTimeList = widget.initTask.dateTimeList;
    }

    super.initState();
  }

  onHighlighter(bool newValue) {
    setState(() => isHighlighter = newValue);
  }

  onColor(String colorName) {
    setState(() => selectedColorName = colorName);
  }

  onClose() {
    setState(() {});
    navigatorPop(context);
  }

  onDateTime() {
    DateTime now = DateTime.now();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => DateTimeModalSheet(
        color: getColorClass(selectedColorName),
        taskDateTimeInfo: taskDateTimeInfo,
        onSelection: (selectionDays) {
          taskDateTimeInfo.type = taskDateTimeType.selection;
          taskDateTimeInfo.dateTimeList = selectionDays;

          onClose();
        },
        onWeek: (weekDays) {
          taskDateTimeInfo.type = taskDateTimeType.everyWeek;
          taskDateTimeInfo.dateTimeList = weekDays
              .where((weekDay) => weekDay.isVisible)
              .map((weekday) =>
                  now.subtract(Duration(days: now.weekday - weekday.id)))
              .toList();

          onClose();
        },
        onMonth: (monthDays) {
          taskDateTimeInfo.type = taskDateTimeType.everyMonth;
          taskDateTimeInfo.dateTimeList = monthDays
              .where((monthDay) => monthDay.isVisible)
              .map((monthDay) => DateTime(now.year, 1, monthDay.id))
              .toList();

          onClose();
        },
      ),
    );
  }

  displayDateTime(String locale) {
    if (taskDateTimeInfo.type == taskDateTimeType.selection) {
      String result = ymdeFormatter(
        locale: locale,
        dateTime: taskDateTimeInfo.dateTimeList[0],
      );

      taskDateTimeInfo.dateTimeList
          .sort((dtA, dtB) => ymdToInt(dtA).compareTo(ymdToInt(dtB)));

      return '$result${taskDateTimeInfo.dateTimeList.length > 1 ? '....+${taskDateTimeInfo.dateTimeList.length - 1}' : ''}';
    } else if (taskDateTimeInfo.type == taskDateTimeType.everyWeek) {
      String join = taskDateTimeInfo.dateTimeList
          .map((dateTime) => eFormatter(locale: locale, dateTime: dateTime))
          .join(', ');

      return '매주 - $join';
    } else if (taskDateTimeInfo.type == taskDateTimeType.everyMonth) {
      List<String> list = taskDateTimeInfo.dateTimeList
          .map((dateTime) => dFormatter(locale: locale, dateTime: dateTime))
          .toList();
      String join = '';
      join = list.length > 5
          ? '${list.sublist(0, 5).join(', ')}...'
          : list.join(', ');

      return '매달 - $join';
    }
  }

  onSaveTask(String id) async {
    if (widget.taskBox == null) {
      await taskRepository.taskBox.put(
        id,
        TaskBox(
          groupId: widget.initTask.groupId,
          id: id,
          name: controller.text,
          taskType: widget.initTask.type,
          isHighlighter: isHighlighter,
          colorName: selectedColorName,
          dateTimeType: taskDateTimeInfo.type,
          dateTimeList: taskDateTimeInfo.dateTimeList,
        ),
      );
    } else {
      TaskBox taskBox = widget.taskBox!;

      taskBox.groupId = widget.initTask.groupId;
      taskBox.isHighlighter = isHighlighter;
      taskBox.colorName = selectedColorName;
      taskBox.dateTimeType = taskDateTimeInfo.type;
      taskBox.dateTimeList = taskDateTimeInfo.dateTimeList;
      taskBox.name = controller.text;

      await taskBox.save();
    }

    navigatorPop(context);
  }

  onGroup() {
    //
  }

  onEditingComplete() async {
    if (controller.text == '') {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '한 글자 이상 입력해주세요',
          buttonText: '확인',
          height: 155,
          onTap: () => navigatorPop(context),
        ),
      );
    } else {
      String uid = uuid();
      Color backgroundColor = getColorClass(selectedColorName).s300;
      Fluttertoast.showToast(
        msg: "추가 되었습니다".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      await onSaveTask(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    bool isLight = context.watch<ThemeProvider>().isLight;

    GroupBox? groupBox = groupRepository.groupBox.get(widget.initTask.groupId);
    ColorClass groupColor = getColorClass(groupBox?.colorName);

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: CommonModalSheet(
        title:
            '${widget.initTask.name} ${widget.taskBox == null ? '추가' : '수정'}',
        height: 325,
        child: CommonContainer(
          innerPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: ListView(
            children: [
              CommonModalItem(
                title: '형광색',
                onTap: () => onHighlighter(!isHighlighter),
                child: CommonSwitch(
                  activeColor: isLight
                      ? getColorClass(selectedColorName).s200
                      : getColorClass(selectedColorName).s300,
                  value: isHighlighter,
                  onChanged: onHighlighter,
                ),
              ),
              CommonModalItem(
                title: '날짜',
                onTap: onDateTime,
                child: CommonSvgText(
                  text: displayDateTime(locale),
                  isNotTr: true,
                  fontSize: 14,
                  textColor: isLight ? textColor : Colors.white,
                  svgColor: grey.s400,
                  // svgName: 'dir-right',
                  svgWidth: 7,
                  svgLeft: 7,
                  svgDirection: SvgDirectionEnum.right,
                  onTap: onDateTime,
                ),
              ),
              CommonModalItem(
                title: '그룹',
                onTap: onGroup,
                child: CommonTag(
                  text: groupBox?.name ?? '',
                  textColor: groupColor.original,
                  bgColor: groupColor.s50,
                  fontSize: 12,
                  onTap: onGroup,
                ),
              ),
              CommonSpace(height: 17.5),
              CommonOutlineInputField(
                controller: controller,
                hintText: '할 일을 입력해주세요',
                selectedColor: isLight
                    ? getColorClass(selectedColorName).s200
                    : getColorClass(selectedColorName).s300,
                onSuffixIcon: onEditingComplete,
                onEditingComplete: onEditingComplete,
                onChanged: (_) => setState(() {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
