import 'package:flutter/material.dart';

class AppBarInfoClass {
  AppBarInfoClass({
    required this.title,
    this.isCenter,
    this.actions,
  });

  String title;
  bool? isCenter;
  List<Widget>? actions;
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

class ItemMarkClass {
  ItemMarkClass({
    required this.E,
    required this.O,
    required this.X,
    required this.M,
    required this.T,
  });

  markName(String mark) {
    return {'O': '완료 했어요', 'X': '안했어요', 'M': '덜 했어요', 'T': '내일 할래요'}[mark]!;
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
    required this.type,
    required this.name,
    required this.dateTimeType,
    required this.dateTimeList,
    required this.dateTimeLabel,
  });

  String type, name, dateTimeLabel, dateTimeType;
  List<DateTime> dateTimeList;
}

class DateTimeTypeClass {
  DateTimeTypeClass({
    required this.oneDay,
    required this.manyDay,
    required this.everyWeek,
    required this.everyMonth,
  });

  String oneDay, manyDay, everyWeek, everyMonth;
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
  });

  String id, name;
  String? mark, memo;
  bool? isHighlight;
  TaskClass task;
  ColorClass color;
}
