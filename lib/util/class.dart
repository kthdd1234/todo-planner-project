import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class AppBarInfoClass {
  AppBarInfoClass({
    required this.title,
    this.isCenter,
    this.actions,
    this.fontSize,
    this.isNotTr,
    this.isBold,
  });

  String title;
  bool? isCenter, isNotTr, isBold;
  List<Widget>? actions;
  double? fontSize;
}

class BottomNavigationBarClass {
  BottomNavigationBarClass({
    required this.svgAsset,
    required this.index,
    required this.label,
    required this.body,
  });

  String svgAsset, label;
  int index;
  Widget body;
}

class ColorClass {
  ColorClass({
    required this.s50,
    required this.s100,
    required this.s200,
    required this.s300,
    required this.s400,
    required this.original,
    required this.colorName,
  });

  String colorName;
  Color s50, s100, s200, s300, s400, original;
}

class TodoGroupBtnClass {
  TodoGroupBtnClass({required this.assetName, required this.onTap});

  String assetName;
  Function() onTap;
}

class MarkClass {
  MarkClass({
    required this.E,
    required this.O,
    required this.X,
    required this.M,
    required this.T,
  });

  markName(String mark) {
    return {'O': '완료했어요', 'X': '안했어요', 'M': '덜 했어요', 'T': '내일 할래요'}[mark]!;
  }

  String E, O, X, M, T;
}

class TodoClass {
  TodoClass({
    required this.id,
    required this.type,
    required this.name,
    this.isHighlighter,
    this.memo,
  });

  String id, type, name;
  String? memo;
  bool? isHighlighter;
}

class TaskDateTimeInfoClass {
  TaskDateTimeInfoClass({required this.type, required this.dateTimeList});

  String type;
  List<DateTime> dateTimeList;
}

class TaskDateTimeTypeClass {
  TaskDateTimeTypeClass({
    required this.selection,
    required this.everyWeek,
    required this.everyMonth,
  });

  String selection, everyWeek, everyMonth;
}

class WeekDayClass {
  WeekDayClass({
    required this.id,
    required this.name,
    required this.isVisible,
  });

  int id;
  String name;
  bool isVisible;
}

class MonthDayClass {
  MonthDayClass({
    required this.id,
    required this.isVisible,
  });

  int id;
  bool isVisible;
}

class CategoryClass {
  CategoryClass({
    required this.id,
    required this.name,
    required this.colorName,
  });

  String id, name, colorName;
}

class TaskClass {
  TaskClass({
    required this.groupId,
    required this.type,
    required this.name,
    required this.dateTimeType,
    required this.dateTimeList,
    required this.dateTimeLabel,
  });

  String groupId, type, name, dateTimeLabel, dateTimeType;
  List<DateTime> dateTimeList;
}

class DateTimeInfoClass {
  DateTimeInfoClass({
    required this.dateTimeType,
    required this.dateTimeList,
  });

  String dateTimeType;
  List<DateTime> dateTimeList;

  Map<String, dynamic> toMap() {
    return {
      'dateTimeType': dateTimeType,
      'dateTimeList': dateTimeList,
    };
  }
}

class TaskItemClass {
  TaskItemClass({
    required this.id,
    required this.name,
    required this.mark,
    required this.memo,
    required this.isHighlight,
    required this.task,
    required this.color,
    required this.groupId,
  });

  String id, name;
  String? mark, memo, groupId;
  bool? isHighlight;
  TaskClass task;
  ColorClass color;
}

class TaskMarkClass {
  TaskMarkClass({required this.dateTime, this.mark, this.memo});

  int dateTime;
  String? memo, mark;

  Map<String, dynamic> toMap() =>
      {'dateTime': dateTime, 'mark': mark, 'memo': memo};
}

class SettingItemClass {
  SettingItemClass({
    required this.name,
    required this.svg,
    required this.onTap,
    this.value,
  });

  String name, svg;
  Widget? value;
  Function() onTap;
}

class PremiumBenefitClass {
  PremiumBenefitClass({
    required this.svgName,
    required this.mainTitle,
    required this.subTitle,
  });

  String svgName, mainTitle, subTitle;
}

class WidgetHeaderClass {
  final String title, today;
  final List<int> textRGB, bgRGB;

  WidgetHeaderClass(this.title, this.today, this.textRGB, this.bgRGB);

  WidgetHeaderClass.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        today = json['today'] as String,
        textRGB = json['textRGB'] as List<int>,
        bgRGB = json['bgRGB'] as List<int>;

  Map<String, dynamic> toJson() => {
        'title': title,
        'today': today,
        'textRGB': textRGB,
        'bgRGB': bgRGB,
      };
}

class WidgetItemClass {
  final String id, name, mark;
  final List<int> barRGB, lineRGB, markRGB;
  final List<int>? highlightRGB;

  WidgetItemClass(
    this.id,
    this.name,
    this.mark,
    this.barRGB,
    this.lineRGB,
    this.markRGB,
    this.highlightRGB,
  );

  WidgetItemClass.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        mark = json['mark'] as String,
        barRGB = json['barRGB'] as List<int>,
        lineRGB = json['lineRGB'] as List<int>,
        markRGB = json['markRGB'] as List<int>,
        highlightRGB = json['highlightRGB'] as List<int>?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mark': mark,
        'barRGB': barRGB,
        'lineRGB': lineRGB,
        'markRGB': markRGB,
        'highlightRGB': highlightRGB
      };
}

class MarkStateClass {
  MarkStateClass({required this.mark, required this.color, required this.name});

  String mark, name;
  Color color;
}

class FilterItemClass {
  FilterItemClass({
    required this.id,
    required this.name,
    this.svg,
  });

  String id, name;
  String? svg;
}

class StateIconClass {
  StateIconClass({required this.title, required this.iconList});

  String title;
  List<String> iconList;
}

class SearchResultClass {
  SearchResultClass({
    required this.dateTime,
    required this.taskList,
    required this.imageList,
    this.memo,
  });

  DateTime dateTime;
  List<TodoClass>? taskList;
  String? memo;
  List<Uint8List>? imageList;
}

class TrakcerItemClass {
  TrakcerItemClass({
    required this.name,
    required this.markList,
    this.highlightColor,
  });

  String name;
  List<String?> markList;
  Color? highlightColor;
}

class BackgroundClass {
  BackgroundClass({
    required this.path,
    required this.name,
  });

  String path, name;
}

class BNClass {
  BNClass({
    required this.index,
    required this.name,
    required this.icon,
    required this.svgName,
  });

  int index;
  String name, svgName;
  Widget icon;
}

class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ파이어스토어 데이터 모델링ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

class UserInfoClass {
  UserInfoClass({
    required this.uid,
    required this.loginType,
    required this.createDateTime,
    required this.fontFamily,
    required this.background,
    required this.theme,
    required this.widgetTheme,
    required this.groupOrderList,
    this.passwords,
    this.email,
    this.displayName,
    this.imgUrl,
  });

  String uid, loginType, fontFamily, background, theme, widgetTheme;
  DateTime createDateTime;
  List<String> groupOrderList;
  String? email, displayName, imgUrl, passwords;

  UserInfoClass.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String,
        loginType = json['loginType'] as String,
        createDateTime = timestampToDateTime(json['createDateTime']),
        fontFamily = json['fontFamily'] as String,
        background = json['background'] as String,
        theme = json['theme'] as String,
        groupOrderList = dynamicToIdList(json['groupOrderList']),
        widgetTheme = json['widgetTheme'] as String,
        passwords = json['passwords'] as String?,
        email = json['email'] as String?,
        displayName = json['displayName'] as String?,
        imgUrl = json['imgUrl'] as String?;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'loginType': loginType,
        'createDateTime': createDateTime,
        'fontFamily': fontFamily,
        'background': background,
        'theme': theme,
        'groupOrderList': groupOrderList,
        'widgetTheme': widgetTheme,
        'passwords': passwords,
        'email': email,
        'displayName': displayName,
        'imgUrl': imgUrl,
      };
}

class GroupInfoClass {
  GroupInfoClass({
    required this.gid,
    required this.name,
    required this.colorName,
    required this.createDateTime,
    required this.isOpen,
    required this.taskOrderList,
    required this.taskInfoList,
  });

  String gid, name, colorName;
  DateTime createDateTime;
  bool isOpen;
  List<TaskOrderClass> taskOrderList;
  List<TaskInfoClass> taskInfoList;

  GroupInfoClass.fromJson(Map<String, dynamic> json)
      : gid = json['gid'] as String,
        name = json['name'] as String,
        colorName = json['colorName'] as String,
        createDateTime = timestampToDateTime(json['createDateTime']),
        isOpen = json['isOpen'] as bool,
        taskOrderList = taskOrderFromJson(json['taskOrderList']),
        taskInfoList = taskInfoFromJson(json['taskInfoList']);

  Map<String, dynamic> toJson() => {
        'gid': gid,
        'name': name,
        'colorName': colorName,
        'createDateTime': createDateTime,
        'isOpen': isOpen,
        'taskOrderList': taskOrderToJson(taskOrderList),
        'taskInfoList': taskInfoToJson(taskInfoList)
      };
}

class TaskInfoClass {
  TaskInfoClass({
    required this.createDateTime,
    required this.tid,
    required this.name,
    required this.dateTimeType,
    required this.dateTimeList,
    required this.recordInfoList,
  });

  DateTime createDateTime;
  String tid, name, dateTimeType;
  List<DateTime> dateTimeList;
  List<RecordInfoClass> recordInfoList;

  TaskInfoClass.fromJson(Map<String, dynamic> json)
      : createDateTime = timestampToDateTime(json['createDateTime']),
        tid = json['tid'] as String,
        name = json['name'] as String,
        dateTimeType = json['dateTimeType'] as String,
        dateTimeList = timestampToDateTimeList(json['dateTimeList']),
        recordInfoList = recordFromJson(json['recordInfoList']);

  Map<String, dynamic> toJson() => {
        'createDateTime': createDateTime,
        'tid': tid,
        'name': name,
        'dateTimeType': dateTimeType,
        'dateTimeList': dateTimeList,
        'recordInfoList': recordToJson(recordInfoList),
      };
}

class TaskOrderClass {
  TaskOrderClass({required this.dateTimeKey, required this.list});

  int dateTimeKey;
  List<String> list;

  TaskOrderClass.fromJson(Map<String, dynamic> json)
      : dateTimeKey = json['dateTimeKey'],
        list = json['list'];

  Map<String, dynamic> toJson() => {
        'dateTimeKey': dateTimeKey,
        'list': list,
      };
}

class RecordInfoClass {
  RecordInfoClass({required this.dateTimeKey, this.memo, this.mark});

  int dateTimeKey;
  String? memo, mark;

  RecordInfoClass.fromJson(Map<String, dynamic> json)
      : dateTimeKey = json['dateTimeKey'] as int,
        memo = json['memo'] as String?,
        mark = json['mark'] as String?;

  Map<String, dynamic> toJson() =>
      {'dateTimeKey': dateTimeKey, 'memo': memo, 'mark': mark};
}

class MemoInfoClass {
  MemoInfoClass({
    required this.dateTimeKey,
    this.path,
    this.imgUrl,
    this.text,
    this.textAlign,
  });

  int dateTimeKey;
  String? path, imgUrl, text;
  TextAlign? textAlign;

  MemoInfoClass.fromJson(Map<String, dynamic> json)
      : dateTimeKey = json['dateTimeKey'] as int,
        path = json['path'] as String?,
        imgUrl = json['imgUrl'] as String?,
        text = json['text'] as String?,
        textAlign = stringToTextAlign(json['textAlign']);

  Map<String, dynamic> toJson() => {
        'dateTimeKey': dateTimeKey,
        'path': path,
        'text': text,
        'imgUrl': imgUrl,
        'textAlign': textAlignToString(textAlign)
      };
}
