import 'package:flutter/material.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAppBar(),
        ContentView(),
      ],
    );
  }
}

class ContentView extends StatelessWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
      child: Column(
        children: [],
      ),
    );
  }
}

//
// ReportTitle(),
// CommonDivider(vertical: 15),
// Column(
//   children: markStateList
//       .map(
//         (markState) => Column(
//           children: [
//             Row(
//               children: [
//                 svgAsset(
//                   name: 'mark-${markState.mark}',
//                   width: 20,
//                   color: markState.color,
//                 ),
//                 const Spacer(),
//                 Row(
//                     children: [3, 2, 2, 0, 4, 3, 1, 15]
//                         .map((result) => Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 15),
//                               child: CommonText(text: '$result'),
//                             ))
//                         .toList())
//               ],
//             ),
//             CommonDivider(vertical: 15),
//           ],
//         ),
//       )
//       .toList(),
// )

// class ReportTitle extends StatelessWidget {
//   const ReportTitle({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CommonText(text: '상태'),
//         const Spacer(),
//         Row(
//           children: weeks
//               .map((day) => Padding(
//                     padding: const EdgeInsets.only(left: 15),
//                     child: CommonText(
//                       text: day,
//                       color: '일' == day
//                           ? red.original
//                           : '토' == day
//                               ? blue.original
//                               : textColor,
//                     ),
//                   ))
//               .toList(),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 15),
//           child: CommonText(text: '합계'),
//         ),
//       ],
//     );
//   }
// }
