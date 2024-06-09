// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/repositories/user_repository.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/MonthPopup.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonAppBar extends StatefulWidget {
  const CommonAppBar({super.key});

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    UserBox? user = UserRepository().user;
    CalendarFormat calendarFormat = calendarFormatInfo[user.calendarFormat]!;

    return Column(
      children: [
        AppBarTitle(
          locale: locale,
          calendarFormat: calendarFormat,
        ),
        AppBarCalendar(
          locale: locale,
          calendarFormat: calendarFormat,
        ),
      ],
    );
  }
}

class AppBarTitle extends StatefulWidget {
  AppBarTitle({super.key, required this.locale, required this.calendarFormat});

  CalendarFormat calendarFormat;
  String locale;

  @override
  State<AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  onDateTime(DateTime dateTime) {
    showDialog(
      context: context,
      builder: (context) => MonthPopup(
        initialdDateTime: dateTime,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) async {
          UserBox? user = userRepository.user;
          context
              .read<TitleDateTimeProvider>()
              .changeTitleDateTime(dateTime: args.value);
          context
              .read<SelectedDateTimeProvider>()
              .changeSelectedDateTime(dateTime: args.value);

          user.calendarFormat = CalendarFormat.month.toString();
          await user.save();

          navigatorPop(context);
        },
      ),
    );
  }

  onLabel() async {
    UserBox? user = userRepository.user;
    user.calendarFormat =
        nextCalendarFormats[widget.calendarFormat]!.toString();
    await user.save();
  }

  @override
  Widget build(BuildContext context) {
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;
    String calendarLabel = availableCalendarFormats[widget.calendarFormat]!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonSvgText(
            text: yMFormatter(locale: widget.locale, dateTime: titleDateTime),
            fontSize: 18,
            svgName: 'dir-down',
            svgWidth: 14,
            svgDirection: SvgDirectionEnum.right,
            onTap: () => onDateTime(titleDateTime),
          ),
          CommonTag(
            text: calendarLabel,
            textColor: Colors.white,
            bgColor: indigo.s300,
            isBold: true,
            fontSize: 11,
            onTap: onLabel,
          )
        ],
      ),
    );
  }
}

class AppBarCalendar extends StatefulWidget {
  AppBarCalendar({
    super.key,
    required this.locale,
    required this.calendarFormat,
  });

  String locale;
  CalendarFormat calendarFormat;

  @override
  State<AppBarCalendar> createState() => _AppBarCalendarState();
}

class _AppBarCalendarState extends State<AppBarCalendar> {
  onDaySelected(DateTime dateTime, _) {
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: dateTime);
  }

  onPageChanged(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);
  }

  Widget? stickerBuilder(BuildContext ctx, DateTime dt, List<dynamic> _) {
    return CommonNull();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TableCalendar(
        locale: widget.locale,
        startingDayOfWeek: StartingDayOfWeek.monday,
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
        currentDay: selectedDateTime,
        focusedDay: selectedDateTime,
        calendarFormat: widget.calendarFormat,
        availableCalendarFormats: availableCalendarFormats,
        onPageChanged: onPageChanged,
        onDaySelected: onDaySelected,
      ),
    );
  }
}

// dayBuilder(context, day, events) {
//   return Container(
//     padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
//     decoration: BoxDecoration(
//       color: Colors.indigo.shade100, // const Color(0xffF3F4F9)
//       borderRadius: BorderRadius.circular(3),
//     ),
//     child: CommonText(
//       text: 'D-12',
//       fontSize: 9,
//       color: Colors.white,
//       isBold: true,
//     ),
//   );
// }
