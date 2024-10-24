import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/page/GroupPage.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/page/PremiumPage.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskAppBar extends StatefulWidget {
  TaskAppBar({
    super.key,
    required this.memoInfoList,
    required this.calendarFormat,
    required this.onCalendarFormat,
  });

  List<MemoInfoClass> memoInfoList;
  CalendarFormat calendarFormat;
  Function() onCalendarFormat;

  @override
  State<TaskAppBar> createState() => _TaskAppBarState();
}

class _TaskAppBarState extends State<TaskAppBar> {
  onToday() {
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: DateTime.now());
  }

  onPremiumPage() {
    movePage(context: context, page: const PremiumPage());
  }

  onGroup() {
    movePage(context: context, page: GroupPage());
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    DateTime titleDateTime =
        context.watch<TitleDateTimeProvider>().titleDateTime;

    int index = widget.memoInfoList.indexWhere(
      (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(selectedDateTime),
    );
    MemoInfoClass? memoInfo = index != -1 ? widget.memoInfoList[index] : null;

    onMemo() {
      movePage(
        context: context,
        page: MemoSettingPage(
          initDateTime: selectedDateTime,
          memoInfoList: widget.memoInfoList,
          memoInfo: memoInfo,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          CommonSvgText(
            text: yMFormatter(locale: locale, dateTime: titleDateTime),
            fontSize: 16,
            isNotTr: true,
            isBold: true,
            textColor: isLight ? darkButtonColor : Colors.white,
            svgWidth: 11,
            svgColor: isLight ? grey.s400 : Colors.white,
            svgDirection: SvgDirectionEnum.right,
            onTap: widget.onCalendarFormat,
          ),
          const Spacer(),
          InkWell(
            onTap: onMemo,
            child: svgAsset(
              name: 'memo-light',
              width: 21,
              color: isLight ? grey.original : Colors.white,
            ),
          ),
          CommonSpace(width: 12.5),
          InkWell(
            onTap: onGroup,
            child: svgAsset(
              name: 'group-light',
              width: 23,
              color: isLight ? grey.original : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}



// class TitleDateTime extends StatefulWidget {
//   TitleDateTime({super.key, required this.onTap});

//   Function() onTap;

//   @override
//   State<TitleDateTime> createState() => _TitleDateTimeState();
// }

// class _TitleDateTimeState extends State<TitleDateTime> {
//   @override
//   Widget build(BuildContext context) {


//     return CommonSvgText(
//       text: yMFormatter(locale: locale, dateTime: titleDateTime),
//       fontSize: 18,
//       isNotTr: true,
//       isBold: !isLight,
//       svgName: isLight ? 'dir-down' : 'dir-down-bold',
//       svgWidth: 14,
//       svgColor: isLight ? textColor : Colors.white,
//       svgDirection: SvgDirectionEnum.right,
//       onTap: onTap,
//     );
//   }
// }

 