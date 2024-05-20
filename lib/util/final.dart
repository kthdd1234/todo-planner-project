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
  colorName: 'indigo',
  baseColor: Colors.indigo,
  bgColor: Colors.indigo.shade50,
  groupColor: Colors.indigo.shade100,
  textColor: Colors.indigo.shade300,
); //

final tagGreen = TagColorClass(
  colorName: 'green',
  baseColor: Colors.green,
  bgColor: Colors.green.shade50,
  groupColor: Colors.green.shade100,
  textColor: Colors.green.shade300,
); //

final tagTeal = TagColorClass(
  colorName: 'teal',
  baseColor: Colors.teal,
  bgColor: Colors.teal.shade50,
  groupColor: Colors.teal.shade100,
  textColor: Colors.teal.shade300,
); //

final tagRed = TagColorClass(
  colorName: 'red',
  baseColor: Colors.red,
  bgColor: Colors.red.shade50,
  groupColor: Colors.red.shade100,
  textColor: Colors.red.shade300,
); //

final tagPink = TagColorClass(
  colorName: 'pink',
  baseColor: Colors.pink,
  bgColor: Colors.pink.shade50,
  groupColor: Colors.pink.shade100,
  textColor: Colors.pink.shade300,
); //

final tagBlue = TagColorClass(
  colorName: 'blue',
  baseColor: Colors.blue,
  bgColor: Colors.blue.shade50,
  groupColor: Colors.blue.shade100,
  textColor: Colors.blue.shade300,
); //

final tagBrown = TagColorClass(
  colorName: 'brown',
  baseColor: Colors.brown,
  bgColor: Colors.brown.shade50,
  groupColor: Colors.brown.shade100,
  textColor: Colors.brown.shade300,
); //

final tagOrange = TagColorClass(
  colorName: 'orange',
  baseColor: Colors.orange,
  bgColor: Colors.orange.shade50,
  groupColor: Colors.orange.shade100,
  textColor: Colors.orange.shade300,
); //

final tagPurple = TagColorClass(
  colorName: 'purple',
  baseColor: Colors.purple,
  bgColor: Colors.purple.shade50,
  groupColor: Colors.purple.shade100,
  textColor: Colors.purple.shade300,
); //

final tagGrey = TagColorClass(
  colorName: 'grey',
  baseColor: Colors.grey,
  bgColor: Colors.grey.shade200,
  groupColor: Colors.grey.shade100,
  textColor: Colors.grey,
); //

final tagLime = TagColorClass(
  colorName: 'lime',
  baseColor: Colors.lime,
  bgColor: Colors.lime.shade50,
  groupColor: Colors.lime.shade100,
  textColor: Colors.lime.shade300,
); //

final tagCyan = TagColorClass(
  colorName: 'cyan',
  baseColor: Colors.cyan,
  bgColor: Colors.cyan.shade50,
  groupColor: Colors.cyan.shade100,
  textColor: Colors.cyan.shade300,
); //

final tagEmber = TagColorClass(
  colorName: 'amber',
  baseColor: Colors.amber,
  bgColor: Colors.amber.shade50,
  groupColor: Colors.amber.shade100,
  textColor: Colors.amber.shade300,
); //

final tagLightBlue = TagColorClass(
  colorName: 'lightBlue',
  baseColor: Colors.lightBlue,
  bgColor: Colors.lightBlue.shade50,
  groupColor: Colors.lightBlue.shade100,
  textColor: Colors.lightBlue.shade300,
);

final tagPeach = TagColorClass(
  colorName: 'peach',
  baseColor: Colors.pink,
  bgColor: const Color.fromRGBO(255, 231, 217, 100),
  textColor: const Color.fromRGBO(255, 170, 84, 100),
);

final tagWhiteIndigo = TagColorClass(
  baseColor: Colors.indigo,
  bgColor: Colors.indigo.shade300,
  textColor: Colors.white,
);

final tagWhiteRed = TagColorClass(
  baseColor: Colors.red,
  bgColor: Colors.red.shade300,
  textColor: Colors.white,
);

final tagWhitePink = TagColorClass(
  baseColor: Colors.pink,
  bgColor: Colors.pink.shade300,
  textColor: Colors.white,
);

final tagWhitePurple = TagColorClass(
  baseColor: Colors.purple,
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
