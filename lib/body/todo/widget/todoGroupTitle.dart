import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';

class TodoGroupTitle extends StatelessWidget {
  TodoGroupTitle({
    super.key,
    required this.title,
    required this.desc,
    this.isShowAction,
  });

  String title, desc;
  bool? isShowAction;

  @override
  Widget build(BuildContext context) {
    onEdit() {
      Navigator.pushNamed(context, 'group-setting-page');
    }

    onCalendar() {
      Navigator.pushNamed(context, 'group-calendar-page');
    }

    onTimeLine() {
      Navigator.pushNamed(context, 'group-timeline-page');
    }

    List<Widget> children = [
      TodoGroupBtnClass(assetName: 'edit-pencil', onTap: onEdit),
      TodoGroupBtnClass(assetName: 'calendar-check', onTap: onCalendar),
      TodoGroupBtnClass(assetName: 'timeline', onTap: onTimeLine),
    ]
        .map((item) => Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CommonSvgButton(
                name: item.assetName,
                width: item.assetName == 'edit-pencil' ? 18 : 20,
                color: Colors.grey.shade400,
                onTap: item.onTap,
              ),
            ))
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(text: title, fontSize: 16),
            CommonSpace(height: 2),
            CommonText(text: desc, fontSize: 11, color: Colors.grey),
          ],
        ),
        isShowAction != false
            ? Row(children: children)
            : CommonText(
                text: '5월 18일 (수)',
                color: Colors.grey,
                fontSize: 11,
              )
      ],
    );
  }
}

// class TodoGroupImage extends StatelessWidget {
//   const TodoGroupImage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 15),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(6),
//         child: Image.asset(
//           'assets/image/test.png',
//           width: 40,
//           height: 40,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }