import 'package:flutter/material.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/tracker/TrackerItem.dart';

List<TableRow> trackerItemList({
  required List<String> taskIdList,
  required GroupInfoClass groupInfo,
  required DateTime startDateTime,
  required bool isLight,
  required ColorClass color,
}) {
  List<TableRow> reslutList = [];

  taskIdList.forEach(
    (id) {
      int index =
          groupInfo.taskInfoList.indexWhere((taskInfo) => taskInfo.tid == id);
      TaskInfoClass taskInfo = groupInfo.taskInfoList[index];
      List<String?> markList = getMarkList(
        recordInfoList: taskInfo.recordInfoList,
        dateTime: startDateTime,
      );

      bool isMark = markList.any((mark) => mark != null);

      if (isMark) {
        reslutList.add(
          trackerItem(
            isLight: isLight,
            text: taskInfo.name,
            color: color,
            markList: markList,
          ),
        );
      }
    },
  );

  return reslutList;
}
