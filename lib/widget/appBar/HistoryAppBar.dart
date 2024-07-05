import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/HistoryOrderProvider.dart';
import 'package:project/provider/YearDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/CalendarPopup.dart';
import 'package:project/widget/popup/FilterPopup.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HistoryAppBar extends StatefulWidget {
  HistoryAppBar({super.key});

  @override
  State<HistoryAppBar> createState() => _HistoryAppBarState();
}

class _HistoryAppBarState extends State<HistoryAppBar> {
  onYear(DateTime datetime) {
    showDialog(
      context: context,
      builder: (context) => CalendarPopup(
        view: DateRangePickerView.decade,
        initialdDateTime: datetime,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) async {
          context
              .read<YearDateTimeProvider>()
              .changeYearDateTime(dateTime: args.value);
          navigatorPop(context);
        },
      ),
    );
  }

  onOrder(isRecent) {
    context.read<HistoryOrderProvider>().setOrder(!isRecent);
  }

  onDisplay() {
    showDialog(context: context, builder: (context) => const FilterPopup());
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    DateTime yearDateTime = context.watch<YearDateTimeProvider>().yearDateTime;
    bool isRecent = context.watch<HistoryOrderProvider>().isRecent;
    List<String>? filterIdList = userRepository.user.filterIdList;

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) => Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // CommonSvgText(
            //   text: yFormatter(
            //     locale: locale,
            //     dateTime: yearDateTime,
            //   ),
            //   fontSize: 18,
            //   isBold: !isLight,
            //   svgName: isLight ? 'dir-down' : 'dir-down-bold',
            //   svgWidth: 14,
            //   svgColor: isLight ? textColor : Colors.white,
            //   svgDirection: SvgDirectionEnum.right,
            //   onTap: () => onYear(yearDateTime),
            // ),
            CommonText(text: '히스토리', fontSize: 18, isBold: !isLight),
            Row(
              children: [
                CommonTag(
                  text: '표시 ${filterIdList?.length ?? 0}',
                  isBold: true,
                  fontSize: 10,
                  textColor: Colors.white,
                  bgColor: isLight ? indigo.s200 : darkButtonColor,
                  onTap: onDisplay,
                ),
                CommonSpace(width: 5),
                CommonTag(
                  text: isRecent ? '최신순' : '과거순',
                  isBold: true,
                  fontSize: 10,
                  textColor: isLight
                      ? Colors.white
                      : isRecent
                          ? indigo.s100
                          : red.s100,
                  bgColor: isLight
                      ? isRecent
                          ? indigo.s200
                          : red.s200
                      : darkButtonColor,
                  onTap: () => onOrder(isRecent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
