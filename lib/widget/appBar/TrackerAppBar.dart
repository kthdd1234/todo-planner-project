import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgTag.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/WeeklyPopup.dart';
import 'package:project/widget/tracker/TrackerDateTime.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TrackerAppBar extends StatefulWidget {
  TrackerAppBar({
    super.key,
    required this.startDateTime,
    required this.endDateTime,
    required this.onSelectionChanged,
  });

  DateTime startDateTime, endDateTime;
  Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;

  @override
  State<TrackerAppBar> createState() => _TrackerAppBarState();
}

class _TrackerAppBarState extends State<TrackerAppBar> {
  onWeeklyPopup() {
    showDialog(
      context: context,
      builder: (context) => WeeklyPopup(
        startAndEndDateTime: [widget.startDateTime, widget.endDateTime],
        onSelectionChanged: widget.onSelectionChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    String std = mdFormatter(locale: locale, dateTime: widget.startDateTime);
    String etd = mdFormatter(locale: locale, dateTime: widget.endDateTime);
    String title = '$std - $etd';

    bool isLight = context.watch<ThemeProvider>().isLight;

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            children: [
              CommonText(text: '주간 기록표', fontSize: 16, isBold: true),
              const Spacer(),
              CommonTag(
                text: title,
                isBold: true,
                isNotTr: true,
                fontSize: 10,
                textColor: isLight ? darkButtonColor : Colors.white,
                bgColor: isLight ? Colors.white : darkButtonColor,
                onTap: onWeeklyPopup,
              ),
            ],
          ),
        );
      },
    );
  }
}

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:project/common/CommonTag.dart';
// import 'package:project/common/CommonText.dart';
// import 'package:project/provider/themeProvider.dart';
// import 'package:project/util/constants.dart';
// import 'package:project/util/final.dart';
// import 'package:project/util/func.dart';
// import 'package:project/widget/popup/WeeklyPopup.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class TrackerAppBar extends StatefulWidget {
//   TrackerAppBar({
//     super.key,
//     required this.startDateTime,
//     required this.endDateTime,
//     required this.onSelectionChanged,
//   });

//   DateTime startDateTime, endDateTime;
//   Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;

//   @override
//   State<TrackerAppBar> createState() => _TrackerAppBarState();
// }

// class _TrackerAppBarState extends State<TrackerAppBar> {
//   onWeeklyPopup() {
//     showDialog(
//       context: context,
//       builder: (context) => WeeklyPopup(
//         startAndEndDateTime: [widget.startDateTime, widget.endDateTime],
//         onSelectionChanged: widget.onSelectionChanged,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     String locale = context.locale.toString();
//     bool isLight = context.watch<ThemeProvider>().isLight;
//     String title =
//         '${ymdFullFormatter(locale: locale, dateTime: widget.startDateTime)} - ${mdFormatter(locale: locale, dateTime: widget.endDateTime)}';

//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CommonText(text: '일주일 트래커', fontSize: 18, isBold: !isLight),
//           CommonTag(
//             text: title,
//             isBold: true,
//             isNotTr: true,
//             fontSize: 10,
//             textColor: Colors.white,
//             bgColor: isLight ? indigo.s300 : darkButtonColor,
//             onTap: onWeeklyPopup,
//           )
//         ],
//       ),
//     );
//   }
// }
