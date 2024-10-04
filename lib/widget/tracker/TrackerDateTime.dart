// import 'package:flutter/material.dart';
// import 'package:project/common/CommonContainer.dart';
// import 'package:project/common/CommonSpace.dart';
// import 'package:project/common/CommonSvgText.dart';
// import 'package:project/common/CommonText.dart';
// import 'package:project/provider/themeProvider.dart';
// import 'package:project/util/constants.dart';
// import 'package:project/util/enum.dart';
// import 'package:provider/provider.dart';

// class TrackerDateTime extends StatelessWidget {
//   TrackerDateTime({
//     super.key,
//     required this.startDateTime,
//     required this.endDateTime,
//     required this.onLeftWeek,
//     required this.onRightWeek,
//   });

//   DateTime startDateTime, endDateTime;
//   Function() onLeftWeek, onRightWeek;

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
//           // onButton(text: '이번 주', onTap: onThisWeek),
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
