import 'package:flutter/material.dart';

class AppBarInfoClass {
  AppBarInfoClass({
    required this.title,
    required this.centerTitle,
    this.actions,
  });

  String title;
  bool centerTitle;
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
  TagColorClass({required this.bgColor, required this.textColor});
  Color bgColor, textColor;
}
