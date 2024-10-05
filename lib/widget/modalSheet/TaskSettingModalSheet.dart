// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/page/FontPage.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class TaskSettingModalSheet extends StatefulWidget {
  TaskSettingModalSheet({
    super.key,
    required this.groupInfo,
    required this.taskInfo,
  });

  GroupInfoClass groupInfo;
  TaskInfoClass taskInfo;

  @override
  State<TaskSettingModalSheet> createState() => _TaskSettingModalSheetState();
}

class _TaskSettingModalSheetState extends State<TaskSettingModalSheet> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.taskInfo.name;
    super.initState();
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
      String groupId = widget.groupInfo.gid;

      widget.taskInfo.name = controller.text;
      groupMethod.updateGroup(gid: groupId, groupInfo: widget.groupInfo);
    }

    navigatorPop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    double bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: CommonModalSheet(
        title: '할 일 수정',
        height: 120,
        child: CommonContainer(
          outerPadding: const EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: controller,
            autofocus: true,
            cursorColor: isLight ? darkButtonColor : Colors.white,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: '할 일을 입력해주세요.'.tr(),
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

  // onDateTime() {
  //   DateTime now = DateTime.now();

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) => DateTimeModalSheet(
  //       color: getColorClass(selectedColorName),
  //       taskDateTimeInfo: taskDateTimeInfo,
  //       onSelection: (selectionDays) {
  //         taskDateTimeInfo.type = taskDateTimeType.selection;
  //         taskDateTimeInfo.dateTimeList = selectionDays;
  //       },
  //       onWeek: (weekDays) {
  //         taskDateTimeInfo.type = taskDateTimeType.everyWeek;
  //         taskDateTimeInfo.dateTimeList = weekDays
  //             .where((weekDay) => weekDay.isVisible)
  //             .map((weekday) =>
  //                 now.subtract(Duration(days: now.weekday - weekday.id)))
  //             .toList();
  //       },
  //       onMonth: (monthDays) {
  //         taskDateTimeInfo.type = taskDateTimeType.everyMonth;
  //         taskDateTimeInfo.dateTimeList = monthDays
  //             .where((monthDay) => monthDay.isVisible)
  //             .map((monthDay) => DateTime(now.year, 1, monthDay.id))
  //             .toList();
  //       },
  //     ),
  //   );
  // }

  // displayDateTime(String locale) {
  //   if (taskDateTimeInfo.type == taskDateTimeType.selection) {
  //     String result = ymdeFormatter(
  //       locale: locale,
  //       dateTime: taskDateTimeInfo.dateTimeList[0],
  //     );

  //     taskDateTimeInfo.dateTimeList
  //         .sort((dtA, dtB) => ymdToInt(dtA).compareTo(ymdToInt(dtB)));

  //     return '$result${taskDateTimeInfo.dateTimeList.length > 1 ? '....+${taskDateTimeInfo.dateTimeList.length - 1}' : ''}';
  //   } else if (taskDateTimeInfo.type == taskDateTimeType.everyWeek) {
  //     String join = taskDateTimeInfo.dateTimeList
  //         .map((dateTime) => eFormatter(locale: locale, dateTime: dateTime))
  //         .join(', ');

  //     return '매주 - $join';
  //   } else if (taskDateTimeInfo.type == taskDateTimeType.everyMonth) {
  //     List<String> list = taskDateTimeInfo.dateTimeList
  //         .map((dateTime) => dFormatter(locale: locale, dateTime: dateTime))
  //         .toList();
  //     String join = '';
  //     join = list.length > 5
  //         ? '${list.sublist(0, 5).join(', ')}...'
  //         : list.join(', ');

  //     return '매달 - $join';
  //   }
  // }