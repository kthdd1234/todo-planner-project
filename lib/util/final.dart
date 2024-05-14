import 'package:flutter/material.dart';
import 'package:project/util/class.dart';
import 'package:project/widget/body/TrackerBody.dart';
import 'package:project/widget/body/settingBody.dart';
import 'package:project/widget/body/timeTableBody.dart';
import 'package:project/widget/body/todoBody.dart';

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
  textColor: Colors.indigo.shade300,
);

final tagGreen = TagColorClass(
  bgColor: Colors.green.shade50,
  textColor: Colors.green.shade300,
);

final tagRed = TagColorClass(
  bgColor: Colors.red.shade50,
  textColor: Colors.red.shade300,
);

final tagBlue = TagColorClass(
  bgColor: Colors.blue.shade50,
  textColor: Colors.blue.shade300,
);

final tagLightBlue = TagColorClass(
  bgColor: Colors.lightBlue.shade50,
  textColor: Colors.lightBlue.shade300,
);

final tagTeal = TagColorClass(
  bgColor: Colors.teal.shade50,
  textColor: Colors.teal.shade300,
);

final tagBrown = TagColorClass(
  bgColor: Colors.brown.shade50,
  textColor: Colors.brown.shade300,
);

final tagOrange = TagColorClass(
  bgColor: Colors.orange.shade50,
  textColor: Colors.orange.shade300,
);

final tagPurple = TagColorClass(
  bgColor: Colors.purple.shade50,
  textColor: Colors.purple.shade300,
);

final tagGrey = TagColorClass(
  bgColor: Colors.grey.shade200,
  textColor: Colors.grey,
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
