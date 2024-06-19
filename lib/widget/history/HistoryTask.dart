import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class HistoryTask extends StatelessWidget {
  HistoryTask({
    super.key,
    required this.taskMarkList,
    required this.taskOrderList,
  });

  List<Map<String, dynamic>>? taskMarkList;
  List<String>? taskOrderList;

  Widget wHistoryItem(Map<String, dynamic> taskMark, String? lastTaskId) {
    return Container(
      padding: EdgeInsets.only(bottom: taskMark['id'] == lastTaskId ? 5 : 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: svgAsset(
                      name: 'mark-${taskMark['mark']}',
                      width: 14,
                      color: getColorClass(taskMark['colorName']).s300),
                ),
              ),
              CommonSpace(width: 10),
              CommonText(
                text: taskMark['name'],
                highlightColor: taskMark['isHighlighter'] == true
                    ? getColorClass(taskMark['colorName']).s50
                    : null,
              ),
            ],
          ),
          taskMark['memo'] != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 5, left: 25),
                  child: CommonText(
                    text: taskMark['memo']!,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 11,
                    color: grey.original,
                  ),
                )
              : const CommonNull()
        ],
      ),
    );
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

        return indexA.compareTo(indexB);
      });
    }

    return taskRenderList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: taskRenderList
                  .map(
                    (taskMark) => wHistoryItem(
                      taskMark,
                      taskRenderList.last['id'],
                    ),
                  )
                  .toList(),
            ),
          )
        : const CommonNull();
  }
}