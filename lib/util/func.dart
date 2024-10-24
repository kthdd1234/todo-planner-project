// ignore_for_file: unused_local_variable, prefer_const_declarations

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/main.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
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

String hmFormatter({required String locale, required DateTime dateTime}) {
  return DateFormat.jm(locale).format(dateTime);
}

ColorClass getColorClass(String? name) {
  if (name == null) {
    return indigo;
  }

  return colorList.firstWhere((info) => info.colorName == name);
}

List<TaskInfoClass> getTaskInfoList({
  required String locale,
  required GroupInfoClass groupInfo,
  required DateTime targetDateTime,
}) {
  List<TaskInfoClass> taskFilterList = groupInfo.taskInfoList.where((task) {
    String dateTimeType = task.dateTimeType;
    List<DateTime> dateTimeList = task.dateTimeList;

    if (dateTimeType == taskDateTimeType.selection) {
      return dateTimeList.any(
        (dateTime) => dateTimeKey(dateTime) == dateTimeKey(targetDateTime),
      );
    } else {
      return dateTimeList.any((dateTime) {
        if (dateTimeType == taskDateTimeType.everyWeek) {
          return eFormatter(locale: locale, dateTime: dateTime) ==
              eFormatter(locale: locale, dateTime: targetDateTime);
        } else if (dateTimeType == taskDateTimeType.everyMonth) {
          return dateTime.day == targetDateTime.day;
        }

        return false;
      });
    }
  }).toList();

  List<TaskOrderClass> taskOrderList = groupInfo.taskOrderList;

  int index = taskOrderList.indexWhere(
    (taskOrder) => taskOrder.dateTimeKey == dateTimeKey(targetDateTime),
  );
  List<String> taskOrderIdList = index != -1 ? taskOrderList[index].list : [];

  taskFilterList.sort((taskA, taskB) {
    int indexA = taskOrderIdList.indexOf(taskA.tid);
    int indexB = taskOrderIdList.indexOf(taskB.tid);

    indexA = indexA == -1 ? 999999 : indexA;
    indexB = indexB == -1 ? 999999 : indexB;

    return indexA.compareTo(indexB);
  });

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

// //
// bool isSearchCategory(String? id) {
//   if (id == null) return false;

//   UserBox? user = userRepository.user;
//   List<String> filterList = user.filterIdList ?? [];

//   return filterList.contains(id) == true;
// }

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

List<String?> getMarkList({
  required List<RecordInfoClass> recordInfoList,
  required DateTime dateTime,
}) {
  return List.generate(7, (index) {
    Duration duration = Duration(days: index);
    DateTime resultDateTime = dateTime.add(duration);
    String? mark;

    recordInfoList.forEach((recordInfo) {
      if (recordInfo.dateTimeKey == dateTimeKey(resultDateTime)) {
        mark = recordInfo.mark;
      }
    });

    return mark;
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
    'en': 'Todo List',
    'ja': 'やることリスト',
  }[locale]!;
}

getGroupInfoOrderList(
  List<String> groupOrderList,
  List<GroupInfoClass> groupInfoList,
) {
  groupInfoList.sort((groupA, groupB) {
    int indexA = groupOrderList.indexOf(groupA.gid);
    int indexB = groupOrderList.indexOf(groupB.gid);

    return indexA.compareTo(indexB);
  });

  return groupInfoList;
}

categorySegmented(SegmentedTypeEnum segmented, bool isLight) {
  onSegmentedWidget({
    required String title,
    required SegmentedTypeEnum type,
    required SegmentedTypeEnum selected,
    Map<String, String>? nameArgs,
  }) {
    Color color = isLight
        ? selected == type
            ? Colors.black
            : grey.original
        : selected == type
            ? Colors.white
            : grey.original;

    return CommonText(
      text: title,
      fontSize: 12,
      nameArgs: nameArgs,
      color: color,
      isBold: !isLight,
    );
  }

  Map<SegmentedTypeEnum, Widget> segmentedData = {
    SegmentedTypeEnum.todo: onSegmentedWidget(
      title: '할 일',
      type: SegmentedTypeEnum.todo,
      selected: segmented,
    ),
    SegmentedTypeEnum.memo: onSegmentedWidget(
      title: '메모',
      type: SegmentedTypeEnum.memo,
      selected: segmented,
    ),
  };

  return segmentedData;
}

DateTime timestampToDateTime(Timestamp timestamp) {
  return DateTime.parse(timestamp.toDate().toString());
}

List<DateTime> timestampToDateTimeList(List<dynamic> timestampList) {
  return timestampList
      .map((timestamp) => timestampToDateTime(timestamp))
      .toList();
}

List<String> dynamicToIdList(List<dynamic> dynamicList) {
  return dynamicList.map((id) => id.toString()).toList();
}

List<TaskInfoClass> taskInfoFromJson(List<dynamic> list) {
  return list
      .map(
        (info) => TaskInfoClass(
          createDateTime: timestampToDateTime(info['createDateTime']),
          tid: info['tid'],
          name: info['name'],
          dateTimeType: info['dateTimeType'],
          dateTimeList: timestampToDateTimeList(info['dateTimeList']),
          recordInfoList: recordFromJson(info['recordInfoList']),
        ),
      )
      .toList();
}

List<Map<String, dynamic>> taskInfoToJson(List<TaskInfoClass> list) {
  return list.map((info) => info.toJson()).toList();
}

List<TaskOrderClass> taskOrderFromJson(List<dynamic> list) {
  return list
      .map(
        (info) => TaskOrderClass(
          dateTimeKey: info['dateTimeKey'],
          list: dynamicToIdList(info['list']),
        ),
      )
      .toList();
}

List<Map<String, dynamic>> taskOrderToJson(List<TaskOrderClass> list) {
  return list.map((info) => info.toJson()).toList();
}

List<RecordInfoClass> recordFromJson(List<dynamic> list) {
  return list.map((info) => RecordInfoClass.fromJson(info)).toList();
}

List<Map<String, dynamic>> recordToJson(List<RecordInfoClass> list) {
  return list.map((info) => info.toJson()).toList();
}

int getRecordIndex({
  required List<RecordInfoClass> recordInfoList,
  required DateTime targetDateTime,
}) {
  return recordInfoList.indexWhere(
    (recordInfo) => recordInfo.dateTimeKey == dateTimeKey(targetDateTime),
  );
}

RecordInfoClass? getRecordInfo({
  required List<RecordInfoClass> recordInfoList,
  required DateTime targetDateTime,
}) {
  int index = getRecordIndex(
    recordInfoList: recordInfoList,
    targetDateTime: targetDateTime,
  );

  return index != -1 ? recordInfoList[index] : null;
}

String? textAlignToString(TextAlign? textAlign) {
  Map<TextAlign, String> textAlignToString = {
    TextAlign.left: TextAlign.left.toString(),
    TextAlign.center: TextAlign.center.toString(),
    TextAlign.right: TextAlign.right.toString(),
  };

  return textAlign != null ? textAlignToString[textAlign] : null;
}

TextAlign? stringToTextAlign(String? textAlign) {
  Map<String, TextAlign> stringToTextAlign = {
    TextAlign.left.toString(): TextAlign.left,
    TextAlign.center.toString(): TextAlign.center,
    TextAlign.right.toString(): TextAlign.right,
  };

  return textAlign != null ? stringToTextAlign[textAlign] : null;
}

Future<String?> getDownloadUrl(String imgUrl) async {
  try {
    Reference imgRef = storageRef.child(imgUrl);
    return await imgRef.getDownloadURL();
  } catch (e) {
    log('$e');
    return null;
  }
}

Future<Uint8List> getCacheData(String url) async {
  File file = await DefaultCacheManager().getSingleFile(url);
  return file.readAsBytes();
}

String getImagePath(String mid) {
  String uid = auth.currentUser!.uid;
  return '$uid/$mid/img.jpg';
}

Future<void> removeImage({required String imgUrl, required String path}) async {
  await DefaultCacheManager().removeFile(imgUrl);
  await storageRef.child(path).delete();
}

navigatorRemoveUntil({
  required BuildContext context,
  required Widget page,
}) async {
  FadePageRoute fadePageRoute = FadePageRoute(page: page);
  Navigator.pushAndRemoveUntil(context, fadePageRoute, (_) => false);
}

themeData(String fontFamily) {
  return ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

List<BNClass> getBnClassList(bool isLight, int seletedIdx) {
  svg(int idx, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: svgAsset(
        name: name,
        width: idx == 2 ? 21 : 23,
        color: idx == seletedIdx
            ? null
            : isLight
                ? grey.original
                : grey.original,
      ),
    );
  }

  List<BNClass> bnClassList = [
    BNClass(
      index: 0,
      name: '홈',
      icon: svg(
        0,
        seletedIdx == 0
            ? 'bnb-home-filled-${isLight ? 'light' : 'dark'}'
            : 'bnb-home',
      ),
      svgName: seletedIdx == 0 ? 'bnb-home-filled-light' : 'bnb-home',
    ),
    BNClass(
      index: 1,
      name: '캘린더',
      icon: svg(
        1,
        seletedIdx == 1
            ? 'bnb-calendar-filled-${isLight ? 'light' : 'dark'}'
            : 'bnb-calendar',
      ),
      svgName: 'bnb-calendar',
    ),
    BNClass(
      index: 2,
      name: '기록표',
      icon: svg(
        2,
        seletedIdx == 2
            ? 'bnb-tracker-filled-${isLight ? 'light' : 'dark'}'
            : 'bnb-tracker',
      ),
      svgName: 'bnb-tracker',
    ),
    BNClass(
      index: 3,
      name: '설정',
      icon: svg(
        3,
        seletedIdx == 3
            ? 'bnb-setting-filled-${isLight ? 'light' : 'dark'}'
            : 'bnb-setting',
      ),
      svgName: 'bnb-setting',
    )
  ];

  return bnClassList;
}

List<BottomNavigationBarItem> getBnbiList(bool isLight, int seletedIdx) {
  List<BottomNavigationBarItem> bnbList = getBnClassList(
    isLight,
    seletedIdx,
  )
      .map(
        (bn) => BottomNavigationBarItem(label: bn.name.tr(), icon: bn.icon),
      )
      .toList();

  return bnbList;
}

String getBnName(int appStartIndex) {
  return ['홈', '캘린더', '기록표'][appStartIndex];
}

errorMessage({required String msg}) {
  Fluttertoast.showToast(
    msg: msg.tr(),
    gravity: ToastGravity.TOP,
    backgroundColor: darkButtonColor,
    fontSize: 12,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
    fontAsset: 'assets/font/IM_Hyemin.ttf',
  );
}
