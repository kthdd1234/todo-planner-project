import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class HomeWidgetService {
  Future<bool?> updateWidget({
    required Map<String, String> data,
    required String widgetName,
  }) async {
    data.forEach((key, value) async {
      await HomeWidget.saveWidgetData<String>(key, value);
    });

    return await HomeWidget.updateWidget(iOSName: widgetName);
  }

  updateAllTodoList({
    required String locale,
    required UserInfoClass userInfo,
    required List<GroupInfoClass> groupInfoList,
  }) {
    DateTime now = DateTime.now();

    String fontFamily = userInfo.fontFamily;
    String widgetTheme = userInfo.widgetTheme;
    bool isWidgetLight = widgetTheme == 'light';

    List<WidgetItemClass> taskList = [];

    for (final groupInfo in groupInfoList) {
      List<TaskInfoClass> taskInfoList = getTaskInfoList(
        locale: locale,
        groupInfo: groupInfo,
        targetDateTime: now,
      );

      for (final taskInfo in taskInfoList) {
        ColorClass color = getColorClass(groupInfo.colorName);
        Color barColor = isWidgetLight ? color.s100 : color.s400;
        Color lineColor = isWidgetLight ? color.s300 : color.s200;
        Color markColor = isWidgetLight ? color.s200 : color.s300;
        Color highlightColor = isWidgetLight ? color.s50 : color.s400;

        String mark = getRecordInfo(
              recordInfoList: taskInfo.recordInfoList,
              targetDateTime: now,
            )?.mark ??
            'E';
        List<int> barRGB = [barColor.red, barColor.green, barColor.blue];
        List<int> lineRGB = [lineColor.red, lineColor.green, lineColor.blue];
        List<int> markRGB = [markColor.red, markColor.green, markColor.blue];
        List<int>? highlightRGB = mark != 'E'
            ? [highlightColor.red, highlightColor.green, highlightColor.blue]
            : null;

        WidgetItemClass widgetItem = WidgetItemClass(
          taskInfo.tid,
          taskInfo.name,
          mark,
          barRGB,
          lineRGB,
          markRGB,
          highlightRGB,
        );

        taskList.add(widgetItem);
      }
    }

    Color taskTitleTextColor = isWidgetLight ? buttonColor : Colors.white;
    Color taskTitleBgColor = isWidgetLight ? selectedColor : darkButtonColor;
    WidgetHeaderClass header = WidgetHeaderClass(
      '오늘의 할 일'.tr(namedArgs: {'length': '${taskList.length}'}),
      mdeFormatter(locale: locale, dateTime: now),
      [
        taskTitleTextColor.red,
        taskTitleTextColor.green,
        taskTitleTextColor.blue
      ],
      [
        taskTitleBgColor.red,
        taskTitleBgColor.green,
        taskTitleBgColor.blue,
      ],
    );

    log(header.title);

    Map<String, String> entry = {
      "fontFamily": fontFamily,
      "emptyText": "추가된 할 일이 없어요",
      "header": jsonEncode(header),
      "taskList": jsonEncode(taskList),
      "widgetTheme": widgetTheme,
    };

    return updateWidget(data: entry, widgetName: 'TodoRoutinWidget');
  }
}
