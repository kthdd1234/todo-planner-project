import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/repositories/record_repository.dart';
import 'package:project/repositories/task_repository.dart';
import 'package:project/repositories/user_repository.dart';
import 'package:project/util/class.dart';
import 'package:project/util/enum.dart';
import 'package:project/body/SettingBody.dart';
import 'package:project/body/TaskBody.dart';
import 'package:table_calendar/table_calendar.dart';

final bottomNavigationBarItemList = [
  BottomNavigationBarClass(
    svgAsset: 'todo',
    index: 0,
    label: '할 일',
    body: const TaskBody(),
  ),
  // BottomNavigationBarClass(
  //   svgAsset: 'time',
  //   index: 1,
  //   label: '달력',
  //   body: const TimeTableBody(),
  // ),
  BottomNavigationBarClass(
    svgAsset: 'setting',
    index: 2,
    label: '설정',
    body: const SettingBody(),
  ),
];

final indigo = ColorClass(
  colorName: '남색',
  original: Colors.indigo,
  s50: Colors.indigo.shade50,
  s100: Colors.indigo.shade100,
  s200: Colors.indigo.shade200,
  s300: Colors.indigo.shade300,
  s400: Colors.indigo.shade400,
);

final green = ColorClass(
  colorName: '녹색',
  original: Colors.green,
  s50: Colors.green.shade50,
  s100: Colors.green.shade100,
  s200: Colors.green.shade200,
  s300: Colors.green.shade300,
  s400: Colors.green.shade400,
); //

final teal = ColorClass(
  colorName: '청록색',
  original: Colors.teal,
  s50: Colors.teal.shade50,
  s100: Colors.teal.shade100,
  s200: Colors.teal.shade200,
  s300: Colors.teal.shade300,
  s400: Colors.teal.shade400,
); //

final red = ColorClass(
  colorName: '빨간색',
  original: Colors.red,
  s50: Colors.red.shade50,
  s100: Colors.red.shade100,
  s200: Colors.red.shade200,
  s300: Colors.red.shade300,
  s400: Colors.red.shade400,
); //

final pink = ColorClass(
  colorName: '핑크색',
  original: Colors.pink,
  s50: Colors.pink.shade50,
  s100: Colors.pink.shade100,
  s200: Colors.pink.shade200,
  s300: Colors.pink.shade300,
  s400: Colors.pink.shade400,
); //

final blue = ColorClass(
  colorName: '파란색',
  original: Colors.blue,
  s50: Colors.blue.shade50,
  s100: Colors.blue.shade100,
  s200: Colors.blue.shade200,
  s300: Colors.blue.shade300,
  s400: Colors.blue.shade400,
); //

final brown = ColorClass(
  colorName: '갈색',
  original: Colors.brown,
  s50: Colors.brown.shade50,
  s100: Colors.brown.shade100,
  s200: Colors.brown.shade200,
  s300: Colors.brown.shade300,
  s400: Colors.brown.shade400,
); //

final orange = ColorClass(
  colorName: '주황색',
  original: Colors.orange,
  s50: Colors.orange.shade50,
  s100: Colors.orange.shade100,
  s200: Colors.orange.shade200,
  s300: Colors.orange.shade300,
  s400: Colors.orange.shade400,
); //

final purple = ColorClass(
  colorName: '보라색',
  original: Colors.purple,
  s50: Colors.purple.shade50,
  s100: Colors.purple.shade100,
  s200: Colors.purple.shade200,
  s300: Colors.purple.shade300,
  s400: Colors.purple.shade400,
); //

final grey = ColorClass(
  colorName: '회색',
  original: Colors.grey,
  s50: Colors.grey.shade50,
  s100: Colors.grey.shade100,
  s200: Colors.grey.shade200,
  s300: Colors.grey.shade300,
  s400: Colors.grey.shade400,
); //

final lime = ColorClass(
  colorName: '라임색',
  original: Colors.lime,
  s50: Colors.lime.shade50,
  s100: Colors.lime.shade100,
  s200: Colors.lime.shade200,
  s300: Colors.lime.shade300,
  s400: Colors.lime.shade400,
); //

final cyan = ColorClass(
  colorName: '민트색',
  original: Colors.cyan,
  s50: Colors.cyan.shade50,
  s100: Colors.cyan.shade100,
  s200: Colors.cyan.shade200,
  s300: Colors.cyan.shade300,
  s400: Colors.cyan.shade400,
); //

final ember = ColorClass(
  colorName: '노랑색',
  original: Colors.amber,
  s50: Colors.amber.shade50,
  s100: Colors.amber.shade100,
  s200: Colors.amber.shade200,
  s300: Colors.amber.shade300,
  s400: Colors.amber.shade400,
); //

final blueGrey = ColorClass(
  colorName: '청회색',
  original: Colors.blueGrey,
  s50: Colors.blueGrey.shade50,
  s100: Colors.blueGrey.shade100,
  s200: Colors.blueGrey.shade200,
  s300: Colors.blueGrey.shade300,
  s400: Colors.blueGrey.shade400,
); //

final lightBlue = ColorClass(
  colorName: 'lightBlue',
  original: Colors.lightBlue,
  s50: Colors.lightBlue.shade50,
  s100: Colors.lightBlue.shade100,
  s200: Colors.lightBlue.shade200,
  s300: Colors.lightBlue.shade300,
  s400: Colors.lightBlue.shade400,
);

final itemMark = ItemMarkClass(
  E: 'E',
  O: 'O',
  X: 'X',
  M: 'M',
  T: 'T',
);

// final itemMarkName = ;

final eOneday = TodoTypeEnum.oneday.toString();

final eRoutin = TodoTypeEnum.routin.toString();

final eItemActionMark = ItemActionTypeEnum.mark.toString();

final eItemActionEdit = ItemActionTypeEnum.edit.toString();

final colorList = [
  indigo,
  red,
  pink,
  green,
  teal,
  cyan,
  lime,
  blue,
  brown,
  orange,
  purple,
  blueGrey
];

final repeatType = RepeatTypeClass(
  everyWeek: 'everyWeek',
  everyMonth: 'everyMonth',
  everyYear: 'everyYear',
);

final tTodo = TaskClass(type: 'todo', name: '할 일', dateTimeLable: '날짜');

final tRoutin = TaskClass(type: 'routin', name: '루틴', dateTimeLable: '반복');

final markList = [
  {'svg': itemMark.O, 'name': itemMark.markName(itemMark.O)},
  {'svg': itemMark.X, 'name': itemMark.markName(itemMark.X)},
  {'svg': itemMark.M, 'name': itemMark.markName(itemMark.M)},
  {'svg': itemMark.T, 'name': itemMark.markName(itemMark.T)},
];

final dateTimeType = DateTimeTypeClass(
  oneDay: "oneDay",
  manyDay: "manyDay",
  everyWeek: "everyWeek",
  everyMonth: "everyMonth",
);

final calendarFormatInfo = {
  CalendarFormat.week.toString(): CalendarFormat.week,
  CalendarFormat.twoWeeks.toString(): CalendarFormat.twoWeeks,
  CalendarFormat.month.toString(): CalendarFormat.month,
};

final availableCalendarFormats = {
  CalendarFormat.week: '1주일',
  CalendarFormat.twoWeeks: '2주일',
  CalendarFormat.month: '1개월',
};

const nextCalendarFormats = {
  CalendarFormat.week: CalendarFormat.twoWeeks,
  CalendarFormat.twoWeeks: CalendarFormat.month,
  CalendarFormat.month: CalendarFormat.week
};

UserRepository userRepository = UserRepository();
RecordRepository recordRepository = RecordRepository();
TaskRepository taskRepository = TaskRepository();

final valueListenables = [
  userRepository.userBox.listenable(),
  recordRepository.recordBox.listenable(),
  taskRepository.taskBox.listenable(),
];

int recordKey(DateTime? dateTime) {
  if (dateTime == null) {
    return 0;
  }

  DateFormat formatter = DateFormat('yyyyMMdd');
  String strDateTime = formatter.format(dateTime);

  return int.parse(strDateTime);
}
