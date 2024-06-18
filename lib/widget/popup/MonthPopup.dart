import 'package:flutter/cupertino.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonPopup.dart';
import 'package:project/util/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarPopup extends StatelessWidget {
  CalendarPopup({
    super.key,
    required this.view,
    required this.initialdDateTime,
    required this.onSelectionChanged,
  });

  DateRangePickerView view;
  DateTime initialdDateTime;
  Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return CommonPopup(
      insetPaddingHorizontal: 50,
      height: 400,
      child: CommonContainer(
        child: SfDateRangePicker(
          selectionTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          showNavigationArrow: true,
          initialDisplayDate: initialdDateTime,
          initialSelectedDate: initialdDateTime,
          maxDate: DateTime(3000, 1, 1),
          view: view,
          allowViewNavigation: false,
          onSelectionChanged: onSelectionChanged,
        ),
      ),
    );
  }
}
