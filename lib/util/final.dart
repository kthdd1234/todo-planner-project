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
  BottomNavigationBarClass(
    svgAsset: 'time',
    index: 1,
    label: '시간표',
    body: const TimeTableBody(),
  ),
  BottomNavigationBarClass(
    svgAsset: 'tracker',
    index: 2,
    label: '트래커',
    body: const TrackerBody(),
  ),
  BottomNavigationBarClass(
    svgAsset: 'setting',
    index: 3,
    label: '설정',
    body: const SettingBody(),
  ),
];
