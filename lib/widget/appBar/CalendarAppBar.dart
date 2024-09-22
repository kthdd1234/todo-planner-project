import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonSegmented.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
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

    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    int recordKey = dateTimeKey(selectedDateTime);
    RecordBox? recordBox = recordRepository.recordBox.get(recordKey);

    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          CommonText(
            text: yMFormatter(locale: locale, dateTime: titleDateTime),
            fontSize: 16,
            isNotTr: true,
            isBold: true,
            color: isLight ? darkButtonColor : Colors.white,
            onTap: () => onCalendar(titleDateTime),
          ),
          const Spacer(),
          SizedBox(
            width: locale == 'en' ? 150 : 100,
            child: CommonSegmented(
              selectedSegment: selectedSegment,
              children: categorySegmented(selectedSegment),
              onSegmentedChanged: onSegmentedChanged,
            ),
          )
        ],
      ),
    );
  }
}
