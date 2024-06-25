import 'dart:convert';

import 'package:home_widget/home_widget.dart';
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
    int recordKey = dateTimeKey(now);
    String today = mdeFormatter(locale: 'ko', dateTime: now); // 작업 필요!
    String header = jsonEncode();
    String taskList = jsonEncode();

    Map<String, String> entry = {
      "fontFamily": 'IM_Hyemin',
      "emptyText": "할 일, 루틴이 없어요",
      "header": header,
      "taskList": taskList,
    };
    return updateWidget(data: entry, widgetName: 'TodoRoutinWidget');
  }
}

// let header: String
// let taskList: String
// let fontFamily: String
// let emptyText: String

// struct HeaderModel: Hashable, Codable {
//     var title: String
//     var today: String
//     var textRGB: [Double]
//     var bgRGB: [Double]
// }

// struct ItemModel: Hashable, Codable, Identifiable {
//     var id: String
//     var name: String
//     var mark: String
//     var barRGB: [Double]
//     var lineRGB: [Double]
//     var markRGB: [Double]
//     var highlightRGB: [Double]
// }