import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

class TodoGroupTitle extends StatelessWidget {
  TodoGroupTitle({
    super.key,
    required this.title,
    required this.desc,
    required this.color,
    this.isShowAction,
  });

  String title, desc;
  ColorClass color;
  bool? isShowAction;

  @override
  Widget build(BuildContext context) {
    // String locale = context.locale.toString();
    // DateTime selectedDateTime =
    //     context.watch<SelectedDateTimeProvider>().seletedDateTime;

    // onEdit() {
    //   Navigator.pushNamed(context, 'group-setting-page');
    // }

    // onCalendar() {
    //   Navigator.pushNamed(context, 'group-calendar-page');
    // }

    // onTimeLine() {
    //   Navigator.pushNamed(context, 'group-timeline-page');
    // }

    // List<Widget> children = [
    //   TodoGroupBtnClass(assetName: 'edit-pencil', onTap: onEdit),
    //   TodoGroupBtnClass(assetName: 'calendar-check', onTap: onCalendar),
    //   TodoGroupBtnClass(assetName: 'timeline', onTap: onTimeLine),
    // ]
    //     .map((item) => InkWell(
    //           onTap: item.onTap,
    //           child: Padding(
    //             padding: const EdgeInsets.only(left: 13),
    //             child: CommonSvgButton(
    //               name: item.assetName,
    //               width: 18,
    //               color: grey.s400,
    //               onTap: item.onTap,
    //             ),
    //           ),
    //         ))
    //     .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTag(
                text: title,
                textColor: indigo.s300,
                bgColor: whiteBgBtnColor,
              ),
              Icon(Icons.more_vert_rounded, size: 18, color: grey.s400)
            ],
          ),
        ),
      ],
    );
  }
}
