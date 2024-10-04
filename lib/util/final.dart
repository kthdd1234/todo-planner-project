import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/repositories/group_repository.dart';
import 'package:project/repositories/record_repository.dart';
import 'package:project/repositories/task_repository.dart';
import 'package:project/repositories/user_repository.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/func.dart';
import 'package:table_calendar/table_calendar.dart';

final indigo = ColorClass(
  colorName: '남색',
  original: Colors.indigo, // 63, 81, 181
  s50: Colors.indigo.shade50, // 232, 234, 246
  s100: Colors.indigo.shade100, // 197, 202, 233
  s200: Colors.indigo.shade200, // 159, 168, 218
  s300: Colors.indigo.shade300, // 121, 134, 203
  s400: Colors.indigo.shade400, // 92, 107, 192
);

final green = ColorClass(
  colorName: '녹색',
  original: Colors.green,
  s50: Colors.green.shade50,
  s100: Colors.green.shade100,
  s200: Colors.green.shade200, // 165, 214, 167
  s300: Colors.green.shade300,
  s400: Colors.green.shade400,
); //

final teal = ColorClass(
  colorName: '청록색',
  original: Colors.teal,
  s50: Colors.teal.shade50,
  s100: Colors.teal.shade100, // 178, 223, 219
  s200: Colors.teal.shade200, // 128, 203, 196
  s300: Colors.teal.shade300, // 255, 77, 182, 172
  s400: Colors.teal.shade400,
); //

final red = ColorClass(
  colorName: '빨간색',
  original: Colors.red,
  s50: Colors.red.shade50,
  s100: Colors.red.shade100, // 255, 205, 210
  s200: Colors.red.shade200, // 239, 154, 154
  s300: Colors.red.shade300, // 229, 115, 115
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
  original: Colors.blue, // 33, 150, 243
  s50: Colors.blue.shade50, // 227, 242, 253
  s100: Colors.blue.shade100, // 187, 222, 251
  s200: Colors.blue.shade200, // 144, 202, 249
  s300: Colors.blue.shade300, // 100, 181, 246
  s400: Colors.blue.shade400, // 66, 165, 245
); //

final brown = ColorClass(
  colorName: '갈색',
  original: Colors.brown,
  s50: Colors.brown.shade50, //
  s100: Colors.brown.shade100,
  s200: Colors.brown.shade200,
  s300: Colors.brown.shade300,
  s400: Colors.brown.shade400,
); //

final orange = ColorClass(
  colorName: '주황색',
  original: Colors.orange,
  s50: Colors.orange.shade50,
  s100: Colors.orange.shade100, // 255, 224, 178
  s200: Colors.orange.shade200, // 255, 204, 128
  s300: Colors.orange.shade300,
  s400: Colors.orange.shade400,
); //

final purple = ColorClass(
  colorName: '보라색',
  original: Colors.purple,
  s50: Colors.purple.shade50,
  s100: Colors.purple.shade100, // 225, 190, 231
  s200: Colors.purple.shade200, // 206, 147, 216
  s300: Colors.purple.shade300, // 186, 104, 200
  s400: Colors.purple.shade400,
); //

final grey = ColorClass(
  colorName: '회색',
  original: Colors.grey.shade600,
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
  s200: Colors.cyan.shade200, // 128, 222, 234
  s300: Colors.cyan.shade300,
  s400: Colors.cyan.shade400, // 38, 198, 218
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
  s100: Colors.blueGrey.shade100, // 207, 216, 200
  s200: Colors.blueGrey.shade200, // 176, 190, 197
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

final markInfo = MarkClass(
  E: 'E',
  O: 'O',
  X: 'X',
  M: 'M',
  T: 'T',
);

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
  blue,
  brown,
  orange,
  purple,
  blueGrey
];

final taskDateTimeType = TaskDateTimeTypeClass(
  selection: 'selection',
  everyWeek: 'everyWeek',
  everyMonth: 'everyMonth',
);

final taskDateTimeLabel = {
  'selection': '선택',
  'everyWeek': '매주',
  'everyMonth': '매달',
};

final tTodo = TaskClass(
  groupId: '',
  type: 'todo',
  name: '할 일',
  dateTimeType: taskDateTimeType.selection,
  dateTimeLabel: '날짜',
  dateTimeList: [DateTime.now()],
);

final tRoutin = TaskClass(
  groupId: '',
  type: 'routin',
  name: '루틴',
  dateTimeType: taskDateTimeType.everyWeek,
  dateTimeLabel: '반복',
  dateTimeList: [DateTime.now()],
);

final selectionMarkList = [
  {'mark': markInfo.O, 'name': markInfo.markName(markInfo.O)},
  {'mark': markInfo.X, 'name': markInfo.markName(markInfo.X)},
  {'mark': markInfo.M, 'name': markInfo.markName(markInfo.M)},
  {'mark': markInfo.T, 'name': markInfo.markName(markInfo.T)},
];

final weekMonthMarkList = [
  {'mark': markInfo.O, 'name': markInfo.markName(markInfo.O)},
  {'mark': markInfo.X, 'name': markInfo.markName(markInfo.X)},
  {'mark': markInfo.M, 'name': markInfo.markName(markInfo.M)},
];

final calendarFormatInfo = {
  CalendarFormat.week.toString(): CalendarFormat.week,
  CalendarFormat.twoWeeks.toString(): CalendarFormat.month,
  CalendarFormat.month.toString(): CalendarFormat.month,
};

final availableCalendarFormats = {
  CalendarFormat.week: 'week',
  CalendarFormat.twoWeeks: 'twoWeeks',
  CalendarFormat.month: 'month',
};

const nextCalendarFormats = {
  CalendarFormat.week: CalendarFormat.twoWeeks,
  CalendarFormat.twoWeeks: CalendarFormat.month,
  CalendarFormat.month: CalendarFormat.week
};

UserRepository userRepository = UserRepository();
RecordRepository recordRepository = RecordRepository();
TaskRepository taskRepository = TaskRepository();
GroupRepository groupRepository = GroupRepository();

final valueListenables = [
  userRepository.userBox.listenable(),
  recordRepository.recordBox.listenable(),
  taskRepository.taskBox.listenable(),
  groupRepository.groupBox.listenable()
];

final premiumBenefitList = [
  PremiumBenefitClass(
    svgName: 'premium-free',
    mainTitle: '평생 무료로 이용 할 수 있어요',
    subTitle: '구독없이 깔끔하게 단 한번 결제!',
  ),
  PremiumBenefitClass(
    svgName: 'premium-no-ads',
    mainTitle: '전면 광고가 제거돼요',
    subTitle: '광고없이 쾌적하게 앱을 사용해보세요!',
  ),
  PremiumBenefitClass(
    svgName: 'premium-group',
    mainTitle: '그룹을 제한없이 추가할 수 있어요',
    subTitle: '보다 많은 그룹으로 할 일을 분류!',
  ),
  PremiumBenefitClass(
    svgName: 'premium-memo',
    mainTitle: '메모를 제한없이 추가할 수 있어요',
    subTitle: '사진과 함께 꼼꼼히 기록해보세요!',
  ),
  PremiumBenefitClass(
    svgName: 'premium-background',
    mainTitle: '다양한 배경들을 제공해드려요',
    subTitle: '총 6종의 다채로운 배경들을 이용해보세요!',
  ),
  PremiumBenefitClass(
    svgName: 'premium-start',
    mainTitle: '앱 시작 시 원하는 화면을 바로 볼 수 있어요',
    subTitle: '홈, 캘린더, 기록표 화면 중 한 곳 선택!',
  ),
];

final filterItemList = [
  FilterItemClass(id: 'O', svg: 'O', name: '(완료했어요)'),
  FilterItemClass(id: 'X', svg: 'X', name: '(안했어요)'),
  FilterItemClass(id: 'M', svg: 'M', name: '(덜 했어요)'),
  FilterItemClass(id: 'T', svg: 'T', name: '(내일 할래요)'),
  FilterItemClass(id: 'memo', svg: null, name: '메모 글'),
  FilterItemClass(id: 'image', svg: null, name: '메모 사진'),
];

final filterIdList = filterItemList.map((item) => item.id).toList();

final stateIconList = [
  StateIconClass(title: '기본', iconList: ['E']),
  StateIconClass(title: '완료했어요', iconList: ['O']),
  StateIconClass(title: '안했어요', iconList: ['X']),
  StateIconClass(title: '덜 했어요', iconList: ['M']),
  StateIconClass(title: '내일 할래요', iconList: ['T']),
];

final daysInfo = {
  '일': 7,
  '월': 1,
  '화': 2,
  '수': 3,
  '목': 4,
  '금': 5,
  '토': 6,
  0: 7,
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
};

final backroundClassList = [
  [
    BackgroundClass(path: '0', name: 'Defalut'),
    BackgroundClass(path: '05', name: 'Paper Texture'),
  ],
  [
    BackgroundClass(path: '1', name: 'Cloudy Apple'),
    BackgroundClass(path: '2', name: 'Snow Again'),
  ],
  [
    BackgroundClass(path: '3', name: 'Pastel Sky'),
    BackgroundClass(path: '4', name: 'Winter Sky'),
  ],
  [
    BackgroundClass(path: '5', name: 'Perfect White'),
    BackgroundClass(path: '6', name: 'Kind Steel'),
  ],
];

List<Map<String, String>> fontFamilyList = [
  {
    "fontFamily": "IM_Hyemin",
    "name": "IM 혜민",
  },
  {
    "fontFamily": "OpenSans",
    "name": "OpenSans",
  },
  {
    "fontFamily": "KyoboHandwriting2019",
    "name": "교보 손글씨",
  },
  {
    "fontFamily": "SingleDay",
    "name": "싱글데이",
  },
  {
    "fontFamily": "Cafe24Dongdong",
    "name": "카페24 동동",
  },
  {
    "fontFamily": "Cafe24Syongsyong",
    "name": "카페24 숑숑",
  },
  {
    "fontFamily": "Cafe24Ssukssuk",
    "name": "카페24 쑥쑥",
  },
];

final languageList = [
  {'svgName': 'Korea', 'lang': 'ko', 'name': '한국어'},
  {'svgName': 'Usa', 'lang': 'en', 'name': 'English'},
  {'svgName': 'Japan', 'lang': 'ja', 'name': '日本語'},
];

final initUserInfo = UserInfoClass(
  uid: '-',
  loginType: 'apple',
  createDateTime: DateTime.now(),
  appStartIndex: 0,
  fontFamily: initFontFamily,
  background: '0',
  theme: 'light',
  widgetTheme: 'light',
  groupOrderList: [],
);

Map<TextAlign, TextAlign> nextTextAlign = {
  TextAlign.left: TextAlign.center,
  TextAlign.center: TextAlign.right,
  TextAlign.right: TextAlign.left
};

Map<TextAlign, String> textAlignName = {
  TextAlign.left: 'left',
  TextAlign.center: 'center',
  TextAlign.right: 'right'
};

Map<String, Map<String, dynamic>> authButtonInfo = {
  'kakao': {
    'svg': 'kakao-logo',
    'name': '카카오 계정',
    'textColor': kakaoTextColor,
    'bgColor': kakaoBgColor,
  },
  'google': {
    'svg': 'google-logo',
    'name': '구글 계정',
    'textColor': darkButtonColor,
    'bgColor': Colors.white,
  },
  'apple': {
    'svg': 'apple-logo',
    'name': '애플 계정',
    'textColor': Colors.white,
    'bgColor': darkButtonColor,
  },
};

bool get isTablet {
  final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
  final logicalShortestSide =
      firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
  return logicalShortestSide > 600;
}
