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

class RepeatInfoClass {
  RepeatInfoClass({required this.type, required this.selectedDateTimeList});

  String type;
  List<DateTime> selectedDateTimeList;
}

class RepeatTypeClass {
  RepeatTypeClass({
    required this.everyWeek,
    required this.everyMonth,
    required this.everyYear,
  });

  String everyWeek, everyMonth, everyYear;
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
    required this.dateTimeLable,
  });

  String type, name, dateTimeLable;
}
