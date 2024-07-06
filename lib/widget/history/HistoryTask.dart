import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class HistoryTask extends StatelessWidget {
  HistoryTask({
    super.key,
    required this.isLight,
    required this.taskMarkList,
    required this.taskOrderList,
  });

  bool isLight;
  List<Map<String, dynamic>>? taskMarkList;
  List<String>? taskOrderList;

  Widget wHistoryItem(Map<String, dynamic> taskMark, String? lastTaskId) {
    ColorClass color = getColorClass(taskMark['colorName']);
    Color? highlightColor = taskMark['isHighlighter'] == true
        ? isLight
            ? color.s50
            : color.s400
        : null;

    return taskMark['mark'] != null && isVisibleHistory(taskMark['mark'])
        ? Padding(
            padding:
                EdgeInsets.only(bottom: taskMark['id'] == lastTaskId ? 5 : 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3, right: 10),
                      child: svgAsset(
                          name: 'mark-${taskMark['mark']}',
                          width: 14,
                          color: getColorClass(taskMark['colorName']).s300),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CommonText(
                            text: taskMark['name'] ?? '',
                            highlightColor: highlightColor,
                            isBold: !isLight,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                taskMark['memo'] != null
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                          left: taskMark['mark'] != null ? 25 : 0,
                        ),
                        child: CommonText(
                          text: taskMark['memo']!,
                          isBold: !isLight,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 11,
                          color: grey.original,
                        ),
                      )
                    : const CommonNull(),
              ],
            ),
          )
        : const CommonNull();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>>? taskRenderList = taskMarkList?.map((taskMark) {
          TaskBox? taskItem = taskRepository.taskBox.get(taskMark['id']);

          taskMark['name'] = taskItem?.name;
          taskMark['colorName'] = taskItem?.colorName;
          taskMark['isHighlighter'] = taskItem?.isHighlighter;

          return taskMark;
        }).toList() ??
        [];

    if (taskOrderList != null) {
      taskRenderList.sort((taskA, taskB) {
        int indexA = taskOrderList!.indexOf(taskA['id']);
        int indexB = taskOrderList!.indexOf(taskB['id']);

        indexA = indexA != -1 ? indexA : 999999;
        indexB = indexB != -1 ? indexB : 999999;

        return indexA.compareTo(indexB);
      });
    }

    return taskRenderList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: taskRenderList
                  .map(
                    (taskMark) => taskMark['name'] != null
                        ? wHistoryItem(taskMark, taskRenderList.last['id'])
                        : const CommonNull(),
                  )
                  .toList(),
            ),
          )
        : const CommonNull();
  }
}
