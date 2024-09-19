// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
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
  // 색상
  String selectedColorName = '남색';

  // 날짜
  TaskDateTimeInfoClass taskDateTimeInfo = TaskDateTimeInfoClass(
    type: taskDateTimeType.selection,
    dateTimeList: [DateTime.now()],
  );

  // 할 일
  TextEditingController controller = TextEditingController();

  // 그룹
  GroupBox? groupBox;

  @override
  void initState() {
    TaskBox? taskBox = widget.taskBox;

    controller.text = taskBox?.name ?? '';
    selectedColorName = groupBox?.colorName ?? '남색';

    super.initState();
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
        },
        onWeek: (weekDays) {
          taskDateTimeInfo.type = taskDateTimeType.everyWeek;
          taskDateTimeInfo.dateTimeList = weekDays
              .where((weekDay) => weekDay.isVisible)
              .map((weekday) =>
                  now.subtract(Duration(days: now.weekday - weekday.id)))
              .toList();
        },
        onMonth: (monthDays) {
          taskDateTimeInfo.type = taskDateTimeType.everyMonth;
          taskDateTimeInfo.dateTimeList = monthDays
              .where((monthDay) => monthDay.isVisible)
              .map((monthDay) => DateTime(now.year, 1, monthDay.id))
              .toList();
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
      widget.taskBox?.name = controller.text;
      await widget.taskBox?.save();
    }

    navigatorPop(context);
  }

  @override
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    bool isLight = context.watch<ThemeProvider>().isLight;
    ColorClass groupColor = getColorClass(groupBox?.colorName);

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: CommonModalSheet(
        title:
            '${widget.initTask.name} ${widget.taskBox == null ? '추가' : '수정'}',
        height: 120,
        child: CommonContainer(
          outerPadding: const EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: controller,
            autofocus: true,
            cursorColor: groupColor.s400,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: '할 일을 입력해주세요.',
              hintStyle: TextStyle(fontSize: 14, color: grey.s400),
              contentPadding: const EdgeInsets.all(0),
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
              ),
            ),
            onEditingComplete: onEditingComplete,
          ),
        ),
      ),
    );
  }
}

  // CommonModalItem(
              //   title: '형광색',
              //   onTap: () => onHighlighter(!isHighlighter),
              //   child: CommonSwitch(
              //     activeColor: isLight ? groupColor.s200 : groupColor.s300,
              //     value: isHighlighter,
              //     onChanged: onHighlighter,
              //   ),
              // ),
              // CommonModalItem(
              //   title: '날짜',
              //   onTap: onDateTime,
              //   child: CommonSvgText(
              //     text: displayDateTime(locale),
              //     isNotTr: true,
              //     fontSize: 14,
              //     textColor: isLight ? textColor : Colors.white,
              //     svgColor: grey.s400,
              //     // svgName: 'dir-right',
              //     svgWidth: 7,
              //     svgLeft: 7,
              //     svgDirection: SvgDirectionEnum.right,
              //     onTap: onDateTime,
              //   ),
              // ),
              // CommonModalItem(
              //   title: '그룹',
              //   onTap: onGroup,
              //   child: CommonTag(
              //     text: groupBox?.name ?? '',
              //     textColor: groupColor.original,
              //     bgColor: groupColor.s50,
              //     fontSize: 12,
              //     onTap: onGroup,
              //   ),
              // ),
              // CommonSpace(height: 17.5),



          // CommonOutlineInputField(
          //   controller: controller,
          //   hintText: '할 일을 입력해주세요',
          //   selectedColor: isLight ? groupColor.s200 : groupColor.s300,
          //   // onSuffixIcon: onEditingComplete,
          //   onEditingComplete: onEditingComplete,
          //   onChanged: (_) => setState(() {}),
          // ),