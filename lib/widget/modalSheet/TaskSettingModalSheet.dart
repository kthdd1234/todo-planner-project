// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalItem.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonOutlineInputField.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/modalSheet/ColorModalsheet.dart';
import 'package:project/widget/modalSheet/RepeatModalSheet.dart';
import 'package:project/widget/modalSheet/SelectedDayModalSheet.dart';
import 'package:project/widget/popup/AlertPopup.dart';

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

  // 날짜 / 반복
  TaskDateTimeInfoClass taskDateTimeInfo = TaskDateTimeInfoClass(
    type: taskDateTimeType.selection,
    dateTimeList: [DateTime.now()],
  );

  // 할 일 / 루틴 이름
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
      selectedColorName = widget.initTask.type == tTodo.type ? '남색' : '청록색';

      taskDateTimeInfo.type = widget.initTask.dateTimeType;
      taskDateTimeInfo.dateTimeList = widget.initTask.dateTimeList;
    }

    super.initState();
  }

  onHighlighter(bool newValue) {
    setState(() => isHighlighter = newValue);
  }

  onColor(String colorName) {
    setState(() => selectedColorName = colorName);
    // showModalBottomSheet(
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) => ColorModalSheet(
    //     selectedColorName: selectedColorName,
    //     onTap: (String colorName) {
    //       setState(() => selectedColorName = colorName);
    //       navigatorPop(context);
    //     },
    //   ),
    // );
  }

  onSelectedDay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SelectedDayModalSheet(
        initDateTimeList: taskDateTimeInfo.dateTimeList,
        onCompleted: (List<DateTime> dateTimeList) {
          setState(() => taskDateTimeInfo.dateTimeList = dateTimeList);
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
        taskDateTimeInfo: taskDateTimeInfo,
        onCompletedEveryWeek: (weekDays) {
          taskDateTimeInfo.type = taskDateTimeType.everyWeek;
          taskDateTimeInfo.dateTimeList = weekDays
              .where((weekDay) => weekDay.isVisible)
              .map((weekday) =>
                  now.subtract(Duration(days: now.weekday - weekday.id)))
              .toList();

          navigatorPop(context);
          setState(() {});
        },
        onCompletedEveryMonth: (monthDays) {
          taskDateTimeInfo.type = taskDateTimeType.everyMonth;
          taskDateTimeInfo.dateTimeList = monthDays
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
      dateTime: taskDateTimeInfo.dateTimeList[0],
    );

    taskDateTimeInfo.dateTimeList
        .sort((dtA, dtB) => ymdToInt(dtA).compareTo(ymdToInt(dtB)));

    return '$result${taskDateTimeInfo.dateTimeList.length > 1 ? '....+${taskDateTimeInfo.dateTimeList.length - 1}' : ''}';
  }

  displayRepeatDateTime(String locale) {
    if (taskDateTimeInfo.type == taskDateTimeType.everyWeek) {
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

  Future<bool> onSaveTask(String id) async {
    bool isEmptyTaskBox = widget.taskBox == null;

    if (isEmptyTaskBox) {
      await taskRepository.taskBox.put(
        id,
        TaskBox(
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

      taskBox.isHighlighter = isHighlighter;
      taskBox.colorName = selectedColorName;
      taskBox.dateTimeType = taskDateTimeInfo.type;
      taskBox.dateTimeList = taskDateTimeInfo.dateTimeList;
      taskBox.name = controller.text;

      await taskBox.save();
      navigatorPop(context);
    }

    return true;
  }

  onInitState() {
    Color backgroundColor = getColorClass(selectedColorName).s200;

    // isHighlighter = false;
    // selectedColorName = widget.initTask.type == tTodo.type ? '남색' : '청록색';
    // taskDateTimeInfo.type = widget.initTask.dateTimeType;
    // taskDateTimeInfo.dateTimeList = widget.initTask.dateTimeList;
    controller.text = '';

    setState(() {});

    Fluttertoast.showToast(
      msg: "추가 되었습니다",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  onEditingComplete() async {
    bool isEmptyTaskBox = widget.taskBox == null;

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
      await onSaveTask(uuid());

      if (isEmptyTaskBox) {
        onInitState();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isTodo = widget.initTask.type == tTodo.type;
    double bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: CommonModalSheet(
        title:
            '${widget.initTask.name} ${widget.taskBox == null ? '추가' : '수정'}',
        height: 330,
        child: CommonContainer(
          innerPadding: const EdgeInsets.only(
            left: 15,
            top: 0,
            right: 15,
            bottom: 0,
          ),
          child: ListView(
            children: [
              CommonModalItem(
                title: '형광색',
                onTap: () => onHighlighter(!isHighlighter),
                child: CupertinoSwitch(
                  activeColor: getColorClass(selectedColorName).s300,
                  value: isHighlighter,
                  onChanged: onHighlighter,
                ),
              ),
              CommonModalItem(
                title: '색상',
                onTap: () {},
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 30,
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: colorList
                          .map(
                            (color) => Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: GestureDetector(
                                onTap: () => onColor(color.colorName),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    CommonCircle(color: color.s100, size: 30),
                                    selectedColorName == color.colorName
                                        ? svgAsset(
                                            name: 'mark-V',
                                            width: 15,
                                            color: color.s300)
                                        : const CommonNull(),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList()),
                ), //

                // CommonTag(
                //   text: getColorClass(selectedColorName).colorName,
                //   textColor: getColorClass(selectedColorName).original,
                //   bgColor: getColorClass(selectedColorName).s50,
                //   onTap: onColor,
                // ),
              ),
              CommonModalItem(
                title: widget.initTask.dateTimeLabel,
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
