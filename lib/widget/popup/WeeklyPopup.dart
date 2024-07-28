import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonPopup.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class WeeklyPopup extends StatefulWidget {
  WeeklyPopup({
    super.key,
    required this.startAndEndDateTime,
    required this.onSelectionChanged,
  });

  List<DateTime?> startAndEndDateTime;
  Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;

  @override
  State<WeeklyPopup> createState() => _WeeklyPopupState();
}

class _WeeklyPopupState extends State<WeeklyPopup> {
  final DateRangePickerController _pickerController =
      DateRangePickerController();

  @override
  void initState() {
    DateTime? startDateTime = widget.startAndEndDateTime[0];
    DateTime? endDateTime = widget.startAndEndDateTime[1];

    _pickerController.selectedRange =
        PickerDateRange(startDateTime, endDateTime);
    _pickerController.displayDate = endDateTime;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonPopup(
      insetPaddingHorizontal: 30,
      height: 390,
      child: CommonContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SfDateRangePicker(
              backgroundColor: Colors.transparent,
              monthViewSettings: DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(
                    fontSize: 13,
                    color: isLight ? Colors.black : Colors.white,
                    fontWeight: isLight ? null : FontWeight.bold,
                  ),
                ),
              ),
              headerStyle: DateRangePickerHeaderStyle(
                backgroundColor: Colors.transparent,
                textStyle: TextStyle(
                  fontWeight: isLight ? null : FontWeight.bold,
                  color: isLight ? Colors.black : Colors.white,
                ),
              ),
              selectionTextStyle: TextStyle(
                fontWeight: isLight ? FontWeight.bold : null,
                color: isLight ? Colors.white : Colors.black,
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(
                    color: isLight ? Colors.black : darkTextColor,
                    fontWeight: isLight ? null : FontWeight.bold,
                  ),
                  disabledDatesTextStyle: TextStyle(
                    color: isLight ? grey.s400 : Colors.white24,
                  ),
                  todayTextStyle: TextStyle(
                    color: isLight ? indigo.s300 : darkTextColor,
                  )),
              rangeTextStyle: TextStyle(
                color: isLight ? Colors.black : grey.s300,
              ),
              rangeSelectionColor: isLight ? indigo.s50 : Colors.white24,
              startRangeSelectionColor: isLight ? indigo.s200 : Colors.white,
              endRangeSelectionColor: isLight ? indigo.s200 : Colors.white,
              todayHighlightColor: Colors.transparent,
              toggleDaySelection: false,
              controller: _pickerController,
              // maxDate: weeklyEndDateTime(DateTime.now()),
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: widget.onSelectionChanged,
            ),
            CommonText(
              text: '요일을 선택하면 선택한 요일의 주가 표시됩니다.',
              color: grey.original,
              fontSize: 12,
              isBold: !isLight,
            ),
          ],
        ),
      ),
    );
  }
}
