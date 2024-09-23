import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';
import 'package:project/widget/appBar/TrackerAppBar.dart';
import 'package:project/widget/containerView/taskCalendarView.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TrackerBody extends StatefulWidget {
  const TrackerBody({super.key});

  @override
  State<TrackerBody> createState() => _TrackerBodyState();
}

class _TrackerBodyState extends State<TrackerBody> {
  CalendarFormat calendarFormat = CalendarFormat.week;

  onCalendarFormat() {
    setState(() => calendarFormat = nextCalendarFormats[calendarFormat]!);
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return Column(
      children: [
        TrackerAppBar(onCalendarFormat: onCalendarFormat),
        TaskCalendarView(calendarFormat: calendarFormat),
        CommonContainer(
          outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 7),
          child: const Column(
            children: [],
          ),
        )
      ],
    );
  }
}











// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:project/common/CommonContainer.dart';
// import 'package:project/common/CommonNull.dart';
// import 'package:project/common/CommonSpace.dart';
// import 'package:project/common/CommonSvgText.dart';
// import 'package:project/common/CommonText.dart';
// import 'package:project/model/record_box/record_box.dart';
// import 'package:project/model/task_box/task_box.dart';
// import 'package:project/model/user_box/user_box.dart';
// import 'package:project/provider/PremiumProvider.dart';
// import 'package:project/provider/themeProvider.dart';
// import 'package:project/util/class.dart';
// import 'package:project/util/constants.dart';
// import 'package:project/util/enum.dart';
// import 'package:project/util/final.dart';
// import 'package:project/util/func.dart';
// import 'package:project/widget/ad/BannerAd.dart';
// import 'package:project/widget/appBar/TrackerAppBar.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class TrackerBody extends StatefulWidget {
//   const TrackerBody({super.key});

//   @override
//   State<TrackerBody> createState() => _TrackerBodyState();
// }

// class _TrackerBodyState extends State<TrackerBody> {
//   DateTime startDateTime = weeklyStartDateTime(DateTime.now());
//   DateTime endDateTime = weeklyEndDateTime(DateTime.now());

//   onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     DateTime rangeStartDate = args.value.startDate;

//     setState(() {
//       startDateTime = weeklyStartDateTime(rangeStartDate);
//       endDateTime = weeklyEndDateTime(rangeStartDate);
//     });

//     navigatorPop(context);
//   }

//   onLeftWeek() {
//     setState(() {
//       startDateTime = startDateTime.subtract(const Duration(days: 7));
//       endDateTime = endDateTime.subtract(const Duration(days: 7));
//     });
//   }

//   onRightWeek() {
//     setState(() {
//       startDateTime = startDateTime.add(const Duration(days: 7));
//       endDateTime = endDateTime.add(const Duration(days: 7));
//     });
//   }

//   onThisWeek() {
//     setState(() {
//       startDateTime = weeklyStartDateTime(DateTime.now());
//       endDateTime = weeklyEndDateTime(DateTime.now());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isPremium = context.watch<PremiumProvider>().isPremium;

//     return Column(
//       children: [
//         TrackerAppBar(
//           startDateTime: startDateTime,
//           endDateTime: endDateTime,
//           onSelectionChanged: onSelectionChanged,
//         ),
//         ContentView(
//           startDateTime: startDateTime,
//           endDateTime: endDateTime,
//         ),
//         WeeklyArrowButton(
//           startDateTime: startDateTime,
//           endDateTime: endDateTime,
//           onLeftWeek: onLeftWeek,
//           onRightWeek: onRightWeek,
//           onThisWeek: onThisWeek,
//         )
//       ],
//     );
//   }
// }

// class ContentView extends StatefulWidget {
//   ContentView({
//     super.key,
//     required this.startDateTime,
//     required this.endDateTime,
//   });

//   DateTime startDateTime, endDateTime;

//   @override
//   State<ContentView> createState() => _ContentViewState();
// }

// class _ContentViewState extends State<ContentView> {
//   @override
//   Widget build(BuildContext context) {
//     List<String> taskIdList = [];
//     bool isLight = context.watch<ThemeProvider>().isLight;

//     for (var day = 0; day < 7; day++) {
//       Duration duration = Duration(days: day);
//       DateTime targetDateTime = widget.startDateTime.add(duration);
//       List<TaskBox> taskList = getTaskList(
//         groupId: '',
//         locale: context.locale.toString(),
//         taskList: taskRepository.taskList,
//         targetDateTime: targetDateTime,
//       );
//       taskIdList.addAll(taskList.map((task) => task.id));
//     }

//     taskIdList = taskIdList.toSet().toList();

//     return Expanded(
//       child: SingleChildScrollView(
//         child: CommonContainer(
//           height: taskIdList.isNotEmpty ? null : 300,
//           innerPadding: const EdgeInsets.all(5),
//           outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 7),
//           child: taskIdList.isNotEmpty
//               ? Table(
//                   border: TableBorder.symmetric(
//                     inside: BorderSide(
//                       width: 0.0,
//                       color: isLight ? grey.s300 : darkNotSelectedTextColor,
//                     ),
//                   ),
//                   columnWidths: const <int, TableColumnWidth>{
//                     0: IntrinsicColumnWidth(),
//                   },
//                   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                   children: <TableRow>[
//                     trackerTitle(),
//                     ...taskIdList.map((id) {
//                       TaskBox task = taskRepository.taskBox.get(id)!;
//                       List<String?> markList = getRecordValueList(
//                         key: 'mark',
//                         dateTime: widget.startDateTime,
//                         taskId: id,
//                       );
//                       List<String?> memoList = getRecordValueList(
//                         key: 'memo',
//                         dateTime: widget.startDateTime,
//                         taskId: id,
//                       );

//                       return trackerItem(
//                         text: task.name,
//                         isHighlight: task.isHighlighter == true,
//                         color: getColorClass(task.colorName),
//                         memoList: memoList,
//                         markList: markList,
//                       );
//                     }),
//                   ],
//                 )
//               : Center(
//                   child: CommonText(
//                     text: '체크 내역이 없어요\n투두 화면에서 할 일을 체크해보세요',
//                     color: isLight ? grey.original : darkTextColor,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }

//   TableRow trackerTitle() {
//     UserBox user = userRepository.user;
//     String title = user.taskTitleInfo['title'];
//     Color color = getColorClass(user.taskTitleInfo['colorName']).s400;
//     bool isLight = context.watch<ThemeProvider>().isLight;

//     return TableRow(
//       children: <Widget>[
//         SizedBox(
//           width: 160,
//           height: 32,
//           child: Center(
//             child: CommonText(
//               text: title,
//               fontSize: 12,
//               overflow: TextOverflow.ellipsis,
//               color: color,
//               isBold: !isLight,
//               isNotTr: true,
//             ),
//           ),
//         ),
//         ...days.map(
//           (day) => Center(
//             child: CommonText(
//               text: day,
//               fontSize: 12,
//               color: grey.original,
//               isBold: !isLight,
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   TableRow trackerItem({
//     required String text,
//     required List<String?> markList,
//     required List<String?> memoList,
//     required ColorClass color,
//     required bool isHighlight,
//   }) {
//     bool isLight = context.watch<ThemeProvider>().isLight;
//     Color? highlightColor = isHighlight
//         ? isLight
//             ? color.s50
//             : color.original
//         : null;
//     return TableRow(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 5),
//           width: 160,
//           height: 32,
//           child: Center(
//             child: CommonText(
//               text: text,
//               fontSize: 12,
//               highlightColor: highlightColor,
//               overflow: TextOverflow.ellipsis,
//               isBold: !isLight,
//               isNotTr: true,
//             ),
//           ),
//         ),
//         ...List.generate(
//           7,
//           (index) => Center(
//             child: markList[index] != null
//                 ? svgAsset(
//                     name: 'mark-${markList[index]}',
//                     width: 14,
//                     color: color.s400,
//                   )
//                 : const CommonNull(),
//           ),
//         )
//       ],
//     );
//   }
// }

// class WeeklyArrowButton extends StatelessWidget {
//   WeeklyArrowButton({
//     super.key,
//     required this.startDateTime,
//     required this.endDateTime,
//     required this.onLeftWeek,
//     required this.onRightWeek,
//     required this.onThisWeek,
//   });

//   DateTime startDateTime, endDateTime;
//   Function() onLeftWeek, onRightWeek, onThisWeek;

//   @override
//   Widget build(BuildContext context) {
//     bool isLight = context.watch<ThemeProvider>().isLight;

//     onButton({
//       required String text,
//       required Function() onTap,
//       String? svgName,
//       SvgDirectionEnum? svgDirection,
//     }) {
//       return Expanded(
//         flex: svgName == null ? 1 : 2,
//         child: CommonContainer(
//             onTap: onTap,
//             innerPadding: const EdgeInsets.all(0),
//             height: 35,
//             color: isLight ? Colors.white : darkButtonColor,
//             child: Center(
//               child: svgName != null
//                   ? CommonSvgText(
//                       text: text,
//                       fontSize: 12,
//                       svgName: 'dir-$svgName-s',
//                       svgWidth: 5,
//                       svgDirection: svgDirection!,
//                       svgRight: 7,
//                       svgLeft: 7,
//                       svgColor: isLight ? darkButtonColor : darkTextColor,
//                       textColor: isLight ? darkButtonColor : darkTextColor,
//                       isBold: true,
//                     )
//                   : CommonText(
//                       text: text,
//                       fontSize: 12,
//                       color: isLight ? darkButtonColor : darkTextColor,
//                       isBold: true,
//                     ),
//             )),
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(7, 0, 7, 7),
//       child: Row(
//         children: [
//           onButton(
//             text: '지난 주',
//             svgName: 'left',
//             svgDirection: SvgDirectionEnum.left,
//             onTap: onLeftWeek,
//           ),
//           CommonSpace(width: 5),
//           onButton(text: '이번 주', onTap: onThisWeek),
//           CommonSpace(width: 5),
//           onButton(
//             text: '다음 주',
//             svgName: 'right',
//             svgDirection: SvgDirectionEnum.right,
//             onTap: onRightWeek,
//           ),
//         ],
//       ),
//     );
//   }
// }
