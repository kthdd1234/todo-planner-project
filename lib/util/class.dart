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

class TagColorClass {
  TagColorClass({
    required this.baseColor,
    required this.bgColor,
    required this.textColor,
    this.colorName,
    this.groupColor,
  });

  String? colorName;
  Color bgColor, textColor;
  Color? groupColor;
  MaterialColor baseColor;
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

  String E, O, X, M, T;
}

class TodoClass {
  TodoClass({
    required this.id,
    required this.type,
    required this.name,
    required this.isHighlighter,
    required this.memo,
  });

  String id, type, name, memo;
  bool isHighlighter;
}
