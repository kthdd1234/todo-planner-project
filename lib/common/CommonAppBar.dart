import 'package:flutter/material.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    onTapDateTime() {
      //
    }

    return Column(
      children: [
        AppBarTitle(onTapDateTime: onTapDateTime),
        CommonSpace(height: 15),
        AppBarCalendar(),
      ],
    );
  }
}

class AppBarTitle extends StatelessWidget {
  AppBarTitle({super.key, required this.onTapDateTime});

  Function() onTapDateTime;

  @override
  Widget build(BuildContext context) {
    wCommonTag({required String text}) {
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: CommonTag(
          text: text,
          tagColor: tagWhiteIndigo,
          isBold: true,
          fontSize: 11,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonSvgText(
            text: '2024년 5월',
            fontSize: 20,
            svgName: 'dir-down',
            svgWidth: 16,
            svgDirection: SvgDirection.right,
          ),
          Row(
            children: [
              wCommonTag(text: '1주일'),
              wCommonTag(text: '그룹 4'),
            ],
          )
        ],
      ),
    );
  }
}

class AppBarCalendar extends StatelessWidget {
  const AppBarCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return TableCalendar(
      headerVisible: false,
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: now,
      focusedDay: now,
      calendarFormat: CalendarFormat.week,
    );
  }
}
