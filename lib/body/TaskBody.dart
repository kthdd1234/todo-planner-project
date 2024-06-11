import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonEmpty.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:project/widget/modalSheet/TaskSettingModalSheet.dart';
import 'package:project/widget/modalSheet/TaskTitleModalSheet.dart';
import 'package:project/widget/popup/MarkPopup.dart';
import 'package:provider/provider.dart';

class TaskBody extends StatelessWidget {
  const TaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (btx, list, w) {
        RecordBox? recordBox =
            recordRepository.recordBox.get(dateTimeKey(selectedDateTime));

        return ListView(
          children: [
            CommonAppBar(),
            MemoContainer(recordBox: recordBox),
            TaskContainer(
              selectedDateTime: selectedDateTime,
              recordBox: recordBox,
            ),
          ],
        );
      },
    );
  }
}

class MemoContainer extends StatelessWidget {
  MemoContainer({super.key, required this.recordBox});

  RecordBox? recordBox;

  @override
  Widget build(BuildContext context) {
    bool isShowMemo = recordBox != null &&
        (recordBox?.memo != null || recordBox?.imageList != null);

    return isShowMemo
        ? CommonContainer(
            innerPadding: const EdgeInsets.all(20),
            outerPadding: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: '큰 목표를 이루고 싶으면 허락을 구하지 마라',
                  fontSize: 15,
                ),
                //
              ],
            ),
          )
        : const CommonNull();
  }
}

class TaskContainer extends StatefulWidget {
  TaskContainer({
    super.key,
    required this.selectedDateTime,
    required this.recordBox,
  });

  DateTime selectedDateTime;
  RecordBox? recordBox;

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  UserBox user = userRepository.user;
  Box<TaskBox> taskBox = taskRepository.taskBox;

  onTitle() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const TaskTitleModalSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    List<TaskBox> taskFilterList = getTaskList(
      locale: locale,
      taskList: taskBox.values.toList(),
      targetDateTime: widget.selectedDateTime,
    );
    List<TaskItem> taskItemList = taskFilterList
        .map(
          (taskBox) => TaskItem(
            recordBox: widget.recordBox,
            taskBox: taskBox,
            taskItem: TaskItemClass(
              id: taskBox.id,
              name: taskBox.name,
              mark: getTaskInfo(
                key: 'mark',
                recordBox: widget.recordBox,
                taskId: taskBox.id,
              ),
              memo: getTaskInfo(
                key: 'memo',
                recordBox: widget.recordBox,
                taskId: taskBox.id,
              ),
              isHighlight: taskBox.isHighlighter == true,
              task: TaskClass(
                type: taskBox.taskType,
                name: getTaskClass(taskBox.taskType).name,
                dateTimeType: taskBox.dateTimeType,
                dateTimeList: taskBox.dateTimeList,
                dateTimeLabel: getTaskClass(taskBox.taskType).dateTimeLabel,
              ),
              color: getColorClass(taskBox.colorName),
            ),
            selectedDateTime: widget.selectedDateTime,
          ),
        )
        .toList();

    return CommonContainer(
      outerPadding: 7,
      innerPadding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTag(
            text: user.taskTitle,
            textColor: indigo.original,
            bgColor: indigo.s50,
            innerPadding: const EdgeInsets.only(bottom: 5),
            onTap: onTitle,
          ),
          taskItemList.isNotEmpty
              ? Column(children: taskItemList)
              : CommonEmpty(
                  height: 150,
                  line_1: '추가된 할 일, 루틴이 없어요.',
                  line_2: '+ 버튼을 눌러 추가해보세요.',
                ),
        ],
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  TaskItem({
    super.key,
    required this.recordBox,
    required this.taskBox,
    required this.taskItem,
    required this.selectedDateTime,
  });

  RecordBox? recordBox;
  TaskBox taskBox;
  TaskItemClass taskItem;
  DateTime selectedDateTime;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  wAction({
    required String svgName,
    required Color actionColor,
    required double width,
    required Function() onTap,
  }) {
    return Expanded(
      flex: 0,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 5),
          child: CommonSvgButton(
            width: width,
            name: svgName,
            color: actionColor,
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  onMark() {
    showDialog(
      context: context,
      builder: (context) => MarkPopup(
        taskBox: widget.taskBox,
        recordBox: widget.recordBox,
        selectedDateTime: widget.selectedDateTime,
      ),
    );
  }

  onMore() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => CommonModalSheet(
        title: widget.taskItem.name,
        height: 200,
        child: Row(
          children: [
            ModalButton(
              svgName: 'highlighter',
              actionText: '수정하기',
              color: textColor,
              onTap: () {
                navigatorPop(context);
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => TaskSettingModalSheet(
                    initTask: widget.taskItem.task,
                    taskBox: widget.taskBox,
                  ),
                );
              },
            ),
            CommonSpace(width: 5),
            ModalButton(
              svgName: 'remove',
              actionText: '삭제하기',
              color: red.s200,
              onTap: () async {
                navigatorPop(context);
                widget.taskItem.task.dateTimeList.removeWhere(
                  (dateTime) =>
                      dateTimeKey(dateTime) ==
                      dateTimeKey(widget.selectedDateTime),
                );
                await widget.taskBox.save();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log('로딩 테스~! ${widget.taskItem.mark}');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: IntrinsicHeight(
        child: Row(
          children: [
            VerticalBorder(color: widget.taskItem.color.s50),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: onMore,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: widget.taskItem.name,
                      textAlign: TextAlign.start,
                      highlightColor: widget.taskItem.isHighlight == true
                          ? widget.taskItem.color.s50
                          : null,
                    ),
                    CommonSpace(height: 5),
                    CommonText(
                      text: widget.taskItem.task.name,
                      color: grey.original,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
            ),
            wAction(
              svgName: 'mark-${widget.taskItem.mark ?? 'E'}',
              width: 25,
              actionColor: widget.taskItem.color.s100,
              onTap: onMark,
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalBorder extends StatelessWidget {
  const VerticalBorder({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 5,
        height: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(2),
            bottom: Radius.circular(2),
          ),
        ),
      ),
    );
  }
}
