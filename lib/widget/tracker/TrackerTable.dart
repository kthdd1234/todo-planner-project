import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/tracker/TrackerItem.dart';
import 'package:project/widget/tracker/TrackerItemList.dart';
import 'package:project/widget/tracker/TrackerTitle.dart';
import 'package:provider/provider.dart';
import '../../provider/themeProvider.dart';

class TrackerTable extends StatelessWidget {
  TrackerTable({
    super.key,
    required this.isLight,
    required this.startDateTime,
    required this.endDateTime,
    required this.groupInfoList,
    required this.selectedGroupInfoIndex,
  });

  bool isLight;
  DateTime startDateTime, endDateTime;
  List<GroupInfoClass> groupInfoList;
  int selectedGroupInfoIndex;

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    GroupInfoClass groupInfo = groupInfoList[selectedGroupInfoIndex];
    ColorClass color = getColorClass(groupInfo.colorName);

    List<String> taskIdList = [];

    for (var day = 0; day < 7; day++) {
      Duration duration = Duration(days: day);
      DateTime targetDateTime = startDateTime.add(duration);
      List<TaskInfoClass> taskList = getTaskInfoList(
        locale: locale,
        targetDateTime: targetDateTime,
        groupInfo: groupInfo,
      );

      taskIdList.addAll(taskList.map((task) => task.tid));
    }

    taskIdList = taskIdList.toSet().toList();

    List<TableRow> itemList = trackerItemList(
      taskIdList: taskIdList,
      startDateTime: startDateTime,
      isLight: isLight,
      groupInfo: groupInfo,
      color: color,
    );

    return Expanded(
      child: SingleChildScrollView(
        child: CommonContainer(
          height: itemList.isNotEmpty ? null : 300,
          innerPadding: const EdgeInsets.all(5),
          outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 7),
          child: itemList.isNotEmpty
              ? Table(
                  border: TableBorder.symmetric(
                    inside: BorderSide(
                      width: 0.0,
                      color: isLight ? grey.s300 : darkNotSelectedTextColor,
                    ),
                  ),
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    trackerTitle(
                      isLight: isLight,
                      title: groupInfo.name,
                      color: color,
                    ),
                    ...itemList,
                  ],
                )
              : Center(
                  child: CommonText(
                    text: '체크 내역이 없어요\n홈 화면에서 할 일을 체크해보세요',
                    color: isLight ? grey.original : darkTextColor,
                  ),
                ),
        ),
      ),
    );
  }
}
