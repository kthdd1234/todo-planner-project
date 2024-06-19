import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';

SvgPicture svgAsset({
  required String name,
  required double width,
  Color? color,
}) {
  return SvgPicture.asset(
    'assets/svg/$name.svg',
    width: width,
    colorFilter:
        color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
  );
}

Color itemMarkColor({required Color groupColor, required String markType}) {
  if (markType == 'E') {
    return Colors.grey.shade400;
  }

  return {
    'O': Colors.green.shade100,
    'X': Colors.red.shade100,
    'M': Colors.orange.shade100,
    'T': Colors.purple.shade100,
  }[markType]!;
}

String ymdFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMd(locale).format(dateTime);
}

String mdeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMEd(locale).format(dateTime);
}

String mdFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.MMMd(locale).format(dateTime);
}

String ymdeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMMEd(locale).format(dateTime);
}

String ymdeShortFormatter(
    {required String locale, required DateTime dateTime}) {
  return DateFormat.yMEd(locale).format(dateTime);
}

String yMFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMM(locale).format(dateTime);
}

String yFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.y(locale).format(dateTime);
}

String dFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.d(locale).format(dateTime);
}

String eFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.E(locale).format(dateTime);
}

String eeeeFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.EEEE(locale).format(dateTime);
}

ColorClass getColorClass(String name) {
  return colorList.firstWhere((info) => info.colorName == name);
}

TaskClass getTaskClass(String type) {
  return {'todo': tTodo, 'routin': tRoutin}[type]!;
}

String? getTaskInfo({
  required String key,
  required RecordBox? recordBox,
  required String taskId,
}) {
  int? idx = recordBox?.taskMarkList?.indexWhere(
    (element) => element['id'] == taskId,
  );

  if (idx == null || idx == -1) {
    return null;
  }

  return recordBox!.taskMarkList![idx][key];
}

List<TaskBox> getTaskList({
  required String locale,
  required List<TaskBox> taskList,
  required DateTime targetDateTime,
  required List<String>? orderList,
}) {
  List<TaskBox> taskFilterList = taskList.where((task) {
    List<DateTime> dateTimeList = task.dateTimeList;

    if (task.taskType == tTodo.type) {
      return dateTimeList.any(
          (dateTime) => dateTimeKey(dateTime) == dateTimeKey(targetDateTime));
    } else if (task.taskType == tRoutin.type) {
      return dateTimeList.any((dateTime) {
        if (task.dateTimeType == taskDateTimeType.everyWeek) {
          return eFormatter(locale: locale, dateTime: dateTime) ==
              eFormatter(
                locale: locale,
                dateTime: targetDateTime,
              );
        } else if (task.dateTimeType == taskDateTimeType.everyMonth) {
          return dateTime.day == targetDateTime.day;
        }

        return false;
      });
    }

    return false;
  }).toList();

  if (orderList != null) {
    taskFilterList.sort((taskA, taskB) {
      int indexA = orderList.indexOf(taskA.id);
      int indexB = orderList.indexOf(taskB.id);

      indexA = indexA == -1 ? 999999 : indexA;
      indexB = indexB == -1 ? 999999 : indexB;

      return indexA.compareTo(indexB);
    });
  }

  return taskFilterList;
}

void navigatorPop(context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
}

isContainIdxDateTime({
  required String locale,
  required List<DateTime> selectionList,
  required DateTime targetDateTime,
}) {
  String targetYmd = ymdFormatter(dateTime: targetDateTime, locale: locale);

  return selectionList.indexWhere((dateTime) =>
      ymdFormatter(dateTime: dateTime, locale: locale) == targetYmd);
}

int ymdToInt(DateTime? dateTime) {
  if (dateTime == null) {
    return 0;
  }

  DateFormat formatter = DateFormat('yyyyMMdd');
  String strDateTime = formatter.format(dateTime);

  return int.parse(strDateTime);
}

bool isEmptyWeekDays(List<WeekDayClass> weekDays) {
  return weekDays.any((weekDay) => weekDay.isVisible) == false;
}

bool isEmptyMonthDays(List<MonthDayClass> monthDays) {
  return monthDays.any((monthDay) => monthDay.isVisible) == false;
}

int dateTimeKey(DateTime? dateTime) {
  if (dateTime == null) {
    return 0;
  }

  DateFormat formatter = DateFormat('yyyyMMdd');
  String strDateTime = formatter.format(dateTime);

  return int.parse(strDateTime);
}

String uuid() {
  return DateTime.now().microsecondsSinceEpoch.toString();
}

speedDialChildButton({
  required String svg,
  required String lable,
  required ColorClass color,
  required Function() onTap,
}) {
  return SpeedDialChild(
    shape: const CircleBorder(),
    child: svgAsset(name: svg, width: 15, color: Colors.white),
    backgroundColor: color.s200,
    labelWidget: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CommonText(text: lable, color: Colors.white, isBold: true),
    ),
    onTap: onTap,
  );
}

Future<Map<String, dynamic>> getAppInfo() async {
  PackageInfo info = await PackageInfo.fromPlatform();

  return {
    "appVerstion": info.version,
    'appBuildNumber': info.buildNumber,
  };
}

movePage({required BuildContext context, required Widget page}) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (BuildContext context) => page),
  );
}
