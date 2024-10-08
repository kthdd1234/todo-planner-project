import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonCachedNetworkImage.dart';
import 'package:project/common/CommonCalendar.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/titleDateTimeProvider.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/VerticalBorder.dart';
import 'package:project/widget/view/CalendarBarView.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  CalendarView({
    super.key,
    required this.selectedSegment,
    required this.groupInfoList,
    required this.memoInfoList,
    required this.selectedGroupInfoIndex,
    this.todayColor,
  });

  SegmentedTypeEnum selectedSegment;
  List<GroupInfoClass> groupInfoList;
  List<MemoInfoClass> memoInfoList;
  int selectedGroupInfoIndex;
  Color? todayColor;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  onDaySelected(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: dateTime);
  }

  onPageChanged(DateTime dateTime) {
    context
        .read<TitleDateTimeProvider>()
        .changeTitleDateTime(dateTime: dateTime);
  }

  Widget? todayBuilder(bool isLight, DateTime dateTime) {
    GroupInfoClass groupInfo =
        widget.groupInfoList[widget.selectedGroupInfoIndex];
    Color todoBgColor = isLight
        ? getColorClass(groupInfo.colorName).s200
        : calendarSelectedDateTimeBgColor;
    Color todoTextColor =
        isLight ? Colors.white : calendarSelectedDateTimeTextColor;

    Color memoBgColor = isLight ? orange.s50 : orange.s300;
    Color memoTextColor = isLight ? orange.original : Colors.white;

    bool isTodo = widget.selectedSegment == SegmentedTypeEnum.todo;

    return Column(
      children: [
        CommonSpace(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 27.5,
              height: 27.5,
              decoration: BoxDecoration(
                color: isTodo ? todoBgColor : memoBgColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            CommonText(
              text: '${dateTime.day}',
              color: isTodo ? todoTextColor : memoTextColor,
              isBold: isTodo ? isLight : false,
              isNotTr: true,
            )
          ],
        ),
      ],
    );
  }

  Widget? barBuilder(bool isLight, DateTime dateTime) {
    String locale = context.locale.toString();

    GroupInfoClass groupInfo =
        widget.groupInfoList[widget.selectedGroupInfoIndex];

    String colorName = groupInfo.colorName;
    ColorClass color = getColorClass(colorName);
    List<TaskInfoClass> taskInfoList = getTaskInfoList(
      locale: locale,
      groupInfo: groupInfo,
      targetDateTime: dateTime,
    );

    Color? highlighterColor(TaskInfoClass taskInfo) {
      RecordInfoClass? recordInfo = getRecordInfo(
        recordInfoList: taskInfo.recordInfoList,
        targetDateTime: dateTime,
      );

      bool isHighlighter = recordInfo?.mark != null && recordInfo?.mark != 'E';

      return isHighlighter
          ? isLight
              ? color.s50
              : color.original
          : null;
    }

    return taskInfoList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 40, right: 5, left: 5),
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: taskInfoList
                      .map(
                        (taskInfo) => CalendarBarView(
                          highlighterColor: highlighterColor(taskInfo),
                          color: color,
                          name: taskInfo.name,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        : const CommonNull();
  }

  Widget? memoBuilder(bool isLight, DateTime dateTime) {
    int index = widget.memoInfoList.indexWhere(
      (memoInfo) => memoInfo.dateTimeKey == dateTimeKey(dateTime),
    );
    MemoInfoClass? memoInfo = index != -1 ? widget.memoInfoList[index] : null;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Column(
      children: [
        memoInfo?.imgUrl != null
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 3,
                  left: 5,
                  right: 5,
                ),
                child: Center(
                  child: CommonCachedNetworkImage(
                    cacheKey: memoInfo!.imgUrl!,
                    imageUrl: memoInfo.imgUrl!,
                    fontSize: 0,
                    radious: 3,
                    width: double.infinity,
                    height: isTablet
                        ? isPortrait
                            ? 100
                            : 55
                        : 50,
                    onTap: () {},
                  ),
                ),
              )
            : const CommonNull(),
        CommonSpace(height: memoInfo?.imgUrl == null ? 40 : 0),
        memoInfo?.text != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isLight ? orange.s50 : orange.s300,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: svgAsset(
                      name: 'pencil',
                      width: isTablet ? 12 : 8,
                      color: isLight ? orange.original : orange.s50,
                    ),
                  ),
                ),
              )
            : const CommonNull()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    bool isTodo = widget.selectedSegment == SegmentedTypeEnum.todo;

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: CommonCalendar(
            selectedDateTime: selectedDateTime,
            calendarFormat: CalendarFormat.month,
            shouldFillViewport: true,
            markerBuilder: isTodo ? barBuilder : memoBuilder,
            todayBuilder: todayBuilder,
            onPageChanged: onPageChanged,
            onDaySelected: onDaySelected,
            onFormatChanged: (_) {},
          ),
        ),
      ),
    );
  }
}
