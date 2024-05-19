import 'package:flutter/material.dart';
import 'package:project/util/class.dart';
import 'package:project/util/enum.dart';
import 'package:project/body/tracker/trackerBody.dart';
import 'package:project/body/setting/settingBody.dart';
import 'package:project/body/todo/todoBody.dart';

final bottomNavigationBarItemList = [
  BottomNavigationBarClass(
    svgAsset: 'todo',
    index: 0,
    label: '할 일',
    body: const TodoBody(),
  ),
  // BottomNavigationBarClass(
  //   svgAsset: 'time',
  //   index: 1,
  //   label: '시간표',
  //   body: const TimeTableBody(),
  // ),
  BottomNavigationBarClass(
    svgAsset: 'tracker',
    index: 1,
    label: '트래커',
    body: const TrackerBody(),
  ),
  BottomNavigationBarClass(
    svgAsset: 'setting',
    index: 2,
    label: '설정',
    body: const SettingBody(),
  ),
];

final tagIndigo = TagColorClass(
  bgColor: Colors.indigo.shade50,
  todoColor: Colors.indigo.shade100,
  textColor: Colors.indigo.shade300,
); //

final tagGreen = TagColorClass(
  bgColor: Colors.green.shade50,
  todoColor: Colors.green.shade100,
  textColor: Colors.green.shade300,
); //

final tagTeal = TagColorClass(
  bgColor: Colors.teal.shade50,
  todoColor: Colors.teal.shade100,
  textColor: Colors.teal.shade300,
); //

final tagRed = TagColorClass(
  bgColor: Colors.red.shade50,
  todoColor: Colors.red.shade100,
  textColor: Colors.red.shade300,
); //

final tagPink = TagColorClass(
  bgColor: Colors.pink.shade50,
  todoColor: Colors.pink.shade100,
  textColor: Colors.pink.shade300,
); //

final tagBlue = TagColorClass(
  bgColor: Colors.blue.shade50,
  todoColor: Colors.blue.shade100,
  textColor: Colors.blue.shade300,
); //

final tagBrown = TagColorClass(
  bgColor: Colors.brown.shade50,
  todoColor: Colors.brown.shade100,
  textColor: Colors.brown.shade300,
); //

final tagOrange = TagColorClass(
  bgColor: Colors.orange.shade50,
  todoColor: Colors.orange.shade100,
  textColor: Colors.orange.shade300,
); //

final tagPurple = TagColorClass(
  bgColor: Colors.purple.shade50,
  todoColor: Colors.purple.shade100,
  textColor: Colors.purple.shade300,
); //

final tagGrey = TagColorClass(
  bgColor: Colors.grey.shade200,
  todoColor: Colors.grey.shade100,
  textColor: Colors.grey,
); //

final tagLime = TagColorClass(
  bgColor: Colors.lime.shade50,
  todoColor: Colors.lime.shade100,
  textColor: Colors.lime.shade300,
); //

final tagCyan = TagColorClass(
  bgColor: Colors.cyan.shade50,
  todoColor: Colors.cyan.shade100,
  textColor: Colors.cyan.shade300,
); //

final tagEmber = TagColorClass(
  bgColor: Colors.amber.shade50,
  todoColor: Colors.amber.shade100,
  textColor: Colors.amber.shade300,
); //

final tagLightBlue = TagColorClass(
  bgColor: Colors.lightBlue.shade50,
  todoColor: Colors.lightBlue.shade100,
  textColor: Colors.lightBlue.shade300,
);

final tagPeach = TagColorClass(
  bgColor: const Color.fromRGBO(255, 231, 217, 100),
  textColor: const Color.fromRGBO(255, 170, 84, 100),
);

final tagWhiteIndigo = TagColorClass(
  bgColor: Colors.indigo.shade300,
  textColor: Colors.white,
);

final tagWhiteRed = TagColorClass(
  bgColor: Colors.red.shade300,
  textColor: Colors.white,
);

final tagWhitePink = TagColorClass(
  bgColor: Colors.pink.shade300,
  textColor: Colors.white,
);

final tagWhitePurple = TagColorClass(
  bgColor: Colors.purple.shade300,
  textColor: Colors.white,
);

final itemMark = ItemMarkClass(
  E: 'E',
  O: 'O',
  X: 'X',
  M: 'M',
  T: 'T',
);

final eOneday = TodoTypeEnum.oneday.toString();

final eRoutin = TodoTypeEnum.routin.toString();

final tagColorList = [
  tagIndigo,
  tagGreen,
  tagTeal,
  tagCyan,
  tagLime,
  tagRed,
  tagPink,
  tagBlue,
  tagBrown,
  tagOrange,
  tagPurple,
  tagEmber,
];
