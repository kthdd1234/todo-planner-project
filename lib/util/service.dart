import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_widget/home_widget.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/repositories/task_repository.dart';
import 'package:project/util/class.dart';
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

  updateTodoRoutin() {
    DateTime now = DateTime.now();
    UserBox? user = userRepository.user;
    int recordKey = dateTimeKey(now);
    RecordBox? recordBox = recordRepository.recordBox.get(recordKey);
    String today = mdeFormatter(locale: 'ko', dateTime: now); // 작업 필요!
    Map<String, dynamic>? taskTitleInfo = user.taskTitleInfo;
    String taskTitle = taskTitleInfo['title'];
    String taskTitleColorName = taskTitleInfo['colorName'];
    Color taskTitleTextColor = getColorClass(taskTitleColorName).original;
    Color taskTitleBgColor = getColorClass(taskTitleColorName).s50;
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
    List<TaskBox> taskList = getTaskList(
      locale: 'ko',
      taskList: TaskRepository().taskList,
      targetDateTime: now,
      orderList: recordBox?.taskOrderList,
    );
    List<WidgetItemClass> taskInfoList = taskList.map((task) {
      ColorClass color = getColorClass(task.colorName);
      Color barColor = color.s100;
      Color lineColor = color.s300;
      Color markColor = color.s200;
      Color highlightColor = color.s50;

      String id = task.id;
      String name = task.name;
      String mark =
          getTaskInfo(key: 'mark', recordBox: recordBox, taskId: task.id) ??
              'E';
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
      "emptyText": "할 일이 없어요",
      "header": jsonEncode(header),
      "taskList": jsonEncode(taskInfoList),
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

class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) {
      _onAppStateChangedAd(state);
      // _onAppStateChangedPassword(state);
    });
  }

  void _onAppStateChangedAd(AppState appState) async {
    bool isPurchase = await isPurchasePremium();

    if (appState == AppState.foreground && isPurchase == false) {
      appOpenAdManager.showAdIfAvailable();
    }
  }

  // void _onAppStateChangedPassword(AppState appState) async {
  //   String? passwords = userRepository.user.screenLockPasswords;

  //   try {
  //     if (passwords != null) {
  //       if (appState == AppState.foreground) {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (context) => EnterScreenLockPage(),
  //             fullscreenDialog: true,
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     log('e => $e');
  //   }
  // }
}
