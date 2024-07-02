// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonPopup.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class MarkPopup extends StatefulWidget {
  MarkPopup({
    super.key,
    required this.taskBox,
    required this.recordBox,
    required this.selectedDateTime,
  });

  TaskBox taskBox;
  RecordBox? recordBox;
  DateTime selectedDateTime;

  @override
  State<MarkPopup> createState() => _MarkPopupState();
}

class _MarkPopupState extends State<MarkPopup> {
  String selectedMark = '';
  bool isShowInput = true;
  bool isAutoFocus = false;
  TextEditingController memoController = TextEditingController();

  @override
  void initState() {
    RecordBox? recordBox = widget.recordBox;

    if (recordBox != null) {
      if (recordBox.taskMarkList != null) {
        for (var element in recordBox.taskMarkList!) {
          if (element['id'] == widget.taskBox.id) {
            selectedMark = element['mark'] ?? '';
            memoController.text = element['memo'] ?? '';

            if (element['memo'] != null) isShowInput = false;
            break;
          }
        }
      }
    }

    super.initState();
  }

  onMark(String selectedMark) async {
    String taskId = widget.taskBox.id;
    Map<String, dynamic> taskMark = TaskMarkClass(
      id: taskId,
      mark: selectedMark,
    ).toMap();

    // 메모가 있으면 같이 추가
    if (memoController.text != '') {
      taskMark['memo'] = memoController.text;
    }

    // 기록 리스트에 추가
    if (widget.recordBox == null) {
      recordRepository.updateRecord(
        key: dateTimeKey(widget.selectedDateTime),
        record: RecordBox(
          createDateTime: widget.selectedDateTime,
          taskMarkList: [taskMark],
        ),
      );
    } else if (widget.recordBox!.taskMarkList == null) {
      widget.recordBox!.taskMarkList = [taskMark];
    } else {
      int idx = widget.recordBox!.taskMarkList!.indexWhere(
        (taksMark) => taksMark['id'] == taskId,
      );

      idx == -1
          ? widget.recordBox!.taskMarkList!.add(taskMark)
          : widget.recordBox!.taskMarkList![idx] = taskMark;
    }

    // 내일 할래요 기능 체크
    if (selectedMark == mark.T) {
      DateTime selectedDateTime = widget.selectedDateTime;
      DateTime tomorrowDateTime = DateTime(
        selectedDateTime.year,
        selectedDateTime.month,
        selectedDateTime.day + 1,
      );
      String id = uuid();

      await taskRepository.taskBox.put(
        id,
        TaskBox(
          id: id,
          name: widget.taskBox.name,
          taskType: tTodo.type,
          colorName: widget.taskBox.colorName,
          dateTimeType: dateTimeType.oneDay,
          dateTimeList: [tomorrowDateTime],
        ),
      );

      await widget.taskBox.save();
    }

    await widget.recordBox?.save();
    navigatorPop(context);
  }

  onEditingComplete() async {
    String taskId = widget.taskBox.id;
    Map<String, dynamic> taskMark =
        TaskMarkClass(id: taskId, memo: memoController.text).toMap();

    if (memoController.text == '') {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '한 글자 이상 입력해주세요',
          buttonText: '확인',
          height: 155,
          onTap: () => navigatorPop(context),
        ),
      );
    } else {
      if (widget.recordBox == null) {
        recordRepository.updateRecord(
          key: dateTimeKey(widget.selectedDateTime),
          record: RecordBox(
            createDateTime: widget.selectedDateTime,
            taskMarkList: [taskMark],
          ),
        );
      } else if (widget.recordBox!.taskMarkList == null) {
        widget.recordBox!.taskMarkList = [taskMark];
      } else {
        int idx = widget.recordBox!.taskMarkList!.indexWhere(
          (taksMark) => taksMark['id'] == taskId,
        );

        if (selectedMark != '') {
          taskMark['mark'] = selectedMark;
        }

        idx == -1
            ? widget.recordBox!.taskMarkList!.add(taskMark)
            : widget.recordBox!.taskMarkList![idx] = taskMark;
      }

      setState(() => isShowInput = false);
    }

    await widget.recordBox?.save();
  }

  wText(bool isLight, String text, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        child: CommonText(
          text: text,
          color: Colors.grey,
          fontSize: 11,
          isBold: !isLight,
        ),
      ),
    );
  }

  onEditMemo() {
    isShowInput = true;
    isAutoFocus = true;

    setState(() {});
  }

  onRemoveMemo() async {
    String taskId = widget.taskBox.id;
    int idx = widget.recordBox!.taskMarkList!.indexWhere(
      (element) => element['id'] == taskId,
    );

    widget.recordBox!.taskMarkList![idx]['memo'] = null;
    memoController.text = '';
    await widget.recordBox!.save();

    isShowInput = true;
    isAutoFocus = false;

    setState(() {});
  }

  onChanged(_) {
    //
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    Color cursorColor =
        isLight ? getColorClass(widget.taskBox.colorName).s300 : darkTextColor;

    return CommonPopup(
      insetPaddingHorizontal: 40,
      height: 380,
      child: CommonContainer(
        innerPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView(
          children: [
            Column(
              children: markList
                  .map((info) => MarkItem(
                        isSelected: info['mark'] == selectedMark,
                        mark: info['mark'],
                        name: info['name'],
                        colorName: widget.taskBox.colorName,
                        onTap: onMark,
                      ))
                  .toList(),
            ),
            Padding(
              padding: EdgeInsets.only(top: isShowInput ? 10 : 10),
              child: isShowInput
                  ? Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color:
                            isLight ? whiteBgBtnColor : darkNotSelectedBgColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: MemoField(
                        hintText: '메모 입력하기',
                        fontSize: 15,
                        cursorColor: cursorColor,
                        autofocus: isAutoFocus,
                        controller: memoController,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 8,
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: onChanged,
                        onEditingComplete: onEditingComplete,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: memoController.text,
                          textAlign: TextAlign.start,
                          isBold: !isLight,
                        ),
                        CommonSpace(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            wText(isLight, '수정', onEditMemo),
                            wText(isLight, '|', null),
                            wText(isLight, '삭제', onRemoveMemo)
                          ],
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarkItem extends StatelessWidget {
  MarkItem({
    super.key,
    required this.mark,
    required this.name,
    required this.colorName,
    required this.isSelected,
    required this.onTap,
  });

  String mark, name, colorName;
  bool isSelected;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: () => onTap(mark),
      child: Column(
        children: [
          CommonSpace(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? getColorClass(colorName).s50 : null,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: svgAsset(
                    name: 'mark-$mark',
                    width: 15,
                    color: getColorClass(colorName).s300,
                  ),
                ),
                CommonSpace(width: 10),
                CommonText(
                  text: name,
                  fontSize: 15,
                  color: isLight ? textColor : darkTextColor,
                  isBold: !isLight,
                )
              ],
            ),
          ),
          CommonSpace(height: 10),
          CommonDivider(
            color: isLight ? getColorClass(colorName).s50 : Colors.white12,
          ),
        ],
      ),
    );
  }
}
