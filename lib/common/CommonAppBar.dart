import 'package:easy_localization/easy_localization.dart';
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
        CommonSpace(height: 15),
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
            svgDirection: SvgDirectionEnum.right,
          ),
          Row(
            children: [
              wCommonTag(text: '스티커'),
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
    String locale = context.locale.toString();

    stickerBuilder(context, day, events) {
      //
    }

    dayBuilder(context, day, events) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.indigo.shade100, // const Color(0xffF3F4F9)
          borderRadius: BorderRadius.circular(3),
        ),
        child: CommonText(
          text: 'D-12',
          fontSize: 9,
          color: Colors.white,
          isBold: true,
        ),
      );
    }

    return TableCalendar(
      locale: locale,
      calendarStyle: CalendarStyle(
        cellMargin: const EdgeInsets.all(15),
        todayDecoration: BoxDecoration(
          color: Colors.indigo.shade300,
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: stickerBuilder,
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.grey, fontSize: 13),
        weekendStyle: TextStyle(color: Colors.grey, fontSize: 13),
      ),
      headerVisible: false,
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(3000, 1, 1),
      focusedDay: now,
      calendarFormat: CalendarFormat.week,
    );
  }
}


 // 캘린터 마커 타입
 // 스티커(Default)
 // D-day(Premium)
 // 퍼센트(Premium)
