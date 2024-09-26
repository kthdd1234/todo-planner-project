import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_widget/home_widget.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/repositories/task_repository.dart';
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

  updateTodoRoutin(String locale) {
    DateTime now = DateTime.now();
    UserBox? user = userRepository.user;
    int recordKey = dateTimeKey(now);
    RecordBox? recordBox = recordRepository.recordBox.get(recordKey);
    String today = mdeFormatter(locale: locale, dateTime: now); // 작업 필요!
    Map<String, dynamic>? taskTitleInfo = user.taskTitleInfo;
    String widgetTheme = user.widgetTheme ?? 'light';
    bool isWidgetLight = widgetTheme == 'light';
    String taskTitle = taskTitleInfo['title'];
    String taskTitleColorName = taskTitleInfo['colorName'];
    ColorClass taskTitleColor = getColorClass(taskTitleColorName);
    Color taskTitleTextColor =
        isWidgetLight ? taskTitleColor.original : taskTitleColor.s200;
    Color taskTitleBgColor =
        isWidgetLight ? taskTitleColor.s50 : darkButtonColor;
    WidgetHeaderClass header = WidgetHeaderClass(
      taskTitle,
      today,
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
    // List<TaskBox> taskList = getTaskList(
    //   groupId: '',
    //   locale: locale,
    //   taskList: TaskRepository().taskList,
    //   targetDateTime: now,
    // );

    List<WidgetItemClass> taskInfoList = [].map((task) {
      ColorClass color = getColorClass(task.colorName);
      Color barColor = isWidgetLight ? color.s100 : color.s400;
      Color lineColor = isWidgetLight ? color.s300 : color.s200;
      Color markColor = isWidgetLight ? color.s200 : color.s300;
      Color highlightColor = isWidgetLight ? color.s50 : color.s400;

      String id = task.id;
      String name = task.name;
      // String mark = getRecordInfo(key: 'mark', taskId: task.id) ?? 'E';
      String mark = 'E';
      List<int> barRGB = [barColor.red, barColor.green, barColor.blue];
      List<int> lineRGB = [lineColor.red, lineColor.green, lineColor.blue];
      List<int> markRGB = [markColor.red, markColor.green, markColor.blue];
      List<int>? highlightRGB = task.isHighlighter == true
          ? [highlightColor.red, highlightColor.green, highlightColor.blue]
          : null;

      return WidgetItemClass(
        id,
        name,
        mark,
        barRGB,
        lineRGB,
        markRGB,
        highlightRGB,
      );
    }).toList();

    Map<String, String> entry = {
      "fontFamily": 'IM_Hyemin',
      "emptyText": "추가된 할 일이 없어요",
      "header": jsonEncode(header),
      "taskList": jsonEncode(taskInfoList),
      "widgetTheme": widgetTheme,
    };

    return updateWidget(data: entry, widgetName: 'TodoRoutinWidget');
  }
}

const Duration maxCacheDuration = Duration(hours: 4);
DateTime? _appOpenLoadTime;

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  String get appOpeningUnitId => getAdId('appOpening');

  void loadAd() {
    AppOpenAd.load(
      adUnitId: appOpeningUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
          print('AppOpenAd !!');
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (!isAdAvailable) {
      loadAd();
      return;
    }

    if (_isShowingAd) {
      return;
    }

    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );

    _appOpenAd!.show();
  }
}
