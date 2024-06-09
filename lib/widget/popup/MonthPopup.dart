import 'package:flutter/cupertino.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonPopup.dart';
import 'package:project/util/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MonthPopup extends StatelessWidget {
  MonthPopup({
    super.key,
    required this.initialdDateTime,
    required this.onSelectionChanged,
  });

  DateTime initialdDateTime;
  Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return CommonPopup(
      insetPaddingHorizontal: 50,
      height: 400,
      child: CommonContainer(
        child: SfDateRangePicker(
          selectionColor: buttonColor,
          selectionTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          showNavigationArrow: true,
          initialDisplayDate: initialdDateTime,
          initialSelectedDate: initialdDateTime,
          maxDate: DateTime.now(),
          view: DateRangePickerView.year,
          allowViewNavigation: false,
          onSelectionChanged: onSelectionChanged,
        ),
      ),
    );
  }
}
