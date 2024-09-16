// ignore_for_file: unused_local_variable, prefer_const_declarations

import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

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

String ymdFullFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.yMMMMd(locale).format(dateTime);
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

ColorClass getColorClass(String? name) {
  if (name == null) {
    return indigo;
  }

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

    if (task.dateTimeType == taskDateTimeType.selection) {
      return dateTimeList.any(
          (dateTime) => dateTimeKey(dateTime) == dateTimeKey(targetDateTime));
    } else {
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
  String? dateTimeType,
}) {
  if (dateTimeType == taskDateTimeType.selection) {
    String ymd = ymdFormatter(locale: locale, dateTime: targetDateTime);
    return selectionList.indexWhere(
      (dateTime) => ymdFormatter(locale: locale, dateTime: dateTime) == ymd,
    );
  } else if (dateTimeType == taskDateTimeType.everyWeek) {
    String e = eFormatter(locale: locale, dateTime: targetDateTime);
    return selectionList.indexWhere(
      (dateTime) => eFormatter(locale: locale, dateTime: dateTime) == e,
    );
  } else {
    DateTime now = DateTime.now();
    String ymd = ymdFormatter(
      locale: locale,
      dateTime: DateTime(
        now.year,
        now.month,
        targetDateTime.day,
      ),
    );

    return selectionList.indexWhere(
      (dateTime) =>
          ymdFormatter(
            locale: locale,
            dateTime: DateTime(now.year, now.month, dateTime.day),
          ) ==
          ymd,
    );
  }
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

// ad: banner, native, appOpening
String getAdId(String ad) {
  final platform = Platform.isIOS ? 'ios' : 'android';
  final env = kDebugMode ? 'debug' : 'real';
  final adId = {
    'android': {
      'banner': {
        'debug': androidBannerTestId,
        'real': androidBannerRealId,
      },
      'native': {
        'debug': androidNativeTestId,
        'real': androidNativeRealId,
      },
      'appOpening': {
        'debug': androidAppOpeningTestId,
        'real': androidAppOpeningRealId,
      }
    },
    'ios': {
      'banner': {
        'debug': iOSBannerTestId,
        'real': iOSBannerRealId,
      },
      'native': {
        'debug': iOSNativeTestId,
        'real': iOSNativeRealId,
      },
      'appOpening': {
        'debug': iOSAppOpeningTestId,
        'real': iOSAppOpeningRealId,
      }
    },
  };

  return adId[platform]![ad]![env]!;
}

Future<bool> setPurchasePremium(Package package) async {
  try {
    CustomerInfo customerInfo = await Purchases.purchasePackage(package);
    return customerInfo.entitlements.all[entitlementIdentifier]?.isActive ==
        true;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

Future<bool> isPurchasePremium() async {
  try {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    bool isActive =
        customerInfo.entitlements.all[entitlementIdentifier]?.isActive == true;
    return isActive;
    // return true;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

Future<bool> isPurchaseRestore() async {
  try {
    CustomerInfo customerInfo = await Purchases.restorePurchases();
    bool isActive =
        customerInfo.entitlements.all[entitlementIdentifier]?.isActive == true;
    return isActive;
  } on PlatformException catch (e) {
    log('e =>> ${e.toString()}');
    return false;
  }
}

//
bool isSearchCategory(String? id) {
  if (id == null) return false;

  UserBox? user = userRepository.user;
  List<String> filterList = user.filterIdList ?? [];

  return filterList.contains(id) == true;
}

bool isEmptyRecord(RecordBox? record) {
  bool isEmptyMark =
      record?.taskMarkList == null || record?.taskMarkList?.length == 0;
  bool isEmptyMemo = record?.memo == null;
  bool isEmptyImage = record?.imageList == null;

  return isEmptyMark && isEmptyMemo && isEmptyImage;
}

DateTime weeklyStartDateTime(DateTime dateTime) {
  if (dateTime.weekday == 7) {
    return dateTime;
  }

  return dateTime.subtract(Duration(days: dateTime.weekday));
}

DateTime weeklyEndDateTime(DateTime dateTime) {
  if (dateTime.weekday == 7) {
    return dateTime.add(const Duration(days: 6));
  }

  return dateTime.add(Duration(
    days: DateTime.daysPerWeek - dateTime.weekday - 1,
  ));
}

List<String?> getRecordValueList({
  required String key,
  required DateTime dateTime,
  required String taskId,
}) {
  return List.generate(7, (index) {
    Duration duration = Duration(days: index);
    DateTime resultDateTime = dateTime.add(duration);
    int recordKey = dateTimeKey(resultDateTime);
    RecordBox? record = recordRepository.recordBox.get(recordKey);
    List<Map<String, dynamic>>? taskMarkList = record?.taskMarkList;
    String? value;

    taskMarkList?.forEach((info) {
      if (info['id'] == taskId) {
        value = info[key];
      }
    });

    return value;
  });
}

calendarHeaderStyle(bool isLight) {
  return HeaderStyle(
    titleCentered: true,
    titleTextStyle: TextStyle(
      color: isLight ? Colors.black : Colors.white,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    formatButtonVisible: false,
    leftChevronIcon: Icon(
      Icons.chevron_left,
      color: isLight ? buttonColor : Colors.white,
    ),
    rightChevronIcon: Icon(
      Icons.chevron_right,
      color: isLight ? buttonColor : Colors.white,
    ),
  );
}

calendarDaysOfWeekStyle(bool isLight) {
  return DaysOfWeekStyle(
    weekdayStyle: TextStyle(
      fontSize: 13,
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    weekendStyle: TextStyle(
      fontSize: 13,
      color: red.s300,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
  );
}

calendarDetailStyle(bool isLight) {
  return CalendarStyle(
    defaultTextStyle: TextStyle(
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    weekendTextStyle: TextStyle(
      color: isLight ? Colors.black : red.s300,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    todayDecoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    todayTextStyle: TextStyle(
      color: isLight ? Colors.black : darkTextColor,
      fontWeight: isLight ? null : FontWeight.bold,
    ),
    outsideDaysVisible: false,
  );
}

String getFontName(String fontFamily) {
  int idx = fontFamilyList
      .indexWhere((element) => element['fontFamily'] == fontFamily);
  return idx != -1 ? fontFamilyList[idx]['name']! : initFontName;
}

String getLocaleName(String locale) {
  if (locale == 'ko') {
    return '한국어';
  } else if (locale == 'ja') {
    return '日本語';
  } else {
    return 'English';
  }
}

String getGroupName(String locale) {
  return {
    'ko': '할 일 리스트',
    'en': 'To Do List',
    'ja': 'やることリスト',
  }[locale]!;
}
