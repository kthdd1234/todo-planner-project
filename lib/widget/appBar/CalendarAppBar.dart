import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonSegmented.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

class CalendarAppBar extends StatelessWidget {
  CalendarAppBar({
    super.key,
    required this.selectedSegment,
    required this.onSegmentedChanged,
    required this.onCalendar,
  });

  SegmentedTypeEnum selectedSegment;
  Function(SegmentedTypeEnum?) onSegmentedChanged;
  Function(DateTime) onCalendar;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          CommonText(
            text: yMFormatter(locale: locale, dateTime: titleDateTime),
            fontSize: 16,
            isBold: true,
            isNotTr: true,
            color: isLight ? darkButtonColor : Colors.white,
            onTap: () => onCalendar(titleDateTime),
          ),
          const Spacer(),
          SizedBox(
            width: locale == 'ko' ? 100 : 160,
            child: CommonSegmented(
              selectedSegment: selectedSegment,
              children: categorySegmented(selectedSegment, isLight),
              onSegmentedChanged: onSegmentedChanged,
            ),
          )
        ],
      ),
    );
  }
}
