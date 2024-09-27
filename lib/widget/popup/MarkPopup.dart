// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonPopup.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/main.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/memo/MemoField.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class MarkPopup extends StatefulWidget {
  MarkPopup({
    super.key,
    required this.groupInfo,
    required this.taskInfo,
    required this.selectedDateTime,
  });

  GroupInfoClass groupInfo;
  TaskInfoClass taskInfo;
  DateTime selectedDateTime;

  @override
  State<MarkPopup> createState() => _MarkPopupState();
}

class _MarkPopupState extends State<MarkPopup> {
  String currentMark = '';
  TextEditingController memoController = TextEditingController();
  bool isShowInput = true;
  bool isAutoFocus = false;

  @override
  void initState() {
    RecordInfoClass? recordInfo = getRecordInfo(
      recordInfoList: widget.taskInfo.recordInfoList,
      targetDateTime: widget.selectedDateTime,
    );

    if (recordInfo != null) {
      currentMark = recordInfo.mark ?? '';
      memoController.text = recordInfo.memo ?? '';

      if (recordInfo.memo != null) isShowInput = false;
    }

    super.initState();
  }

  onMark(String selectedMark) async {
    String groupId = widget.groupInfo.gid;
    String taskId = widget.taskInfo.tid;

    DateTime selectedDateTime = widget.selectedDateTime;

    RecordInfoClass newRecordInfo = RecordInfoClass(
      dateTimeKey: dateTimeKey(selectedDateTime),
      mark: currentMark != selectedMark ? selectedMark : null,
      memo: memoController.text != '' ? memoController.text : null,
    );

    RecordInfoClass? recordInfo = getRecordInfo(
      recordInfoList: widget.taskInfo.recordInfoList,
      targetDateTime: selectedDateTime,
    );

    // 기록 리스트에 추가
    if (recordInfo == null) {
      widget.taskInfo.recordInfoList.add(newRecordInfo);
    } else {
      int index = getRecordIndex(
        recordInfoList: widget.taskInfo.recordInfoList,
        targetDateTime: selectedDateTime,
      );

      widget.taskInfo.recordInfoList[index] = newRecordInfo;
    }

    // 내일 할래요
    DateTime tomorrowDateTime = DateTime(
      selectedDateTime.year,
      selectedDateTime.month,
      selectedDateTime.day + 1,
    );
    List<DateTime> dateTimeList = widget.taskInfo.dateTimeList;
    int tDtIndex = dateTimeList.indexWhere(
      (dateTime) => dateTimeKey(dateTime) == dateTimeKey(tomorrowDateTime),
    );

    if (selectedMark == 'T') {
      tDtIndex == -1
          ? dateTimeList.add(tomorrowDateTime)
          : dateTimeList.removeAt(tDtIndex);
    } else if (currentMark == 'T' && selectedMark != 'T') {
      dateTimeList.removeAt(tDtIndex);
    }

    await groupMethod.updateGroup(gid: groupId, groupInfo: widget.groupInfo);
    navigatorPop(context);
  }

  onEditingComplete() async {
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
      String groupId = widget.groupInfo.gid;
      String taskId = widget.taskInfo.tid;
      DateTime selectedDateTime = widget.selectedDateTime;

      RecordInfoClass newRecordInfo = RecordInfoClass(
        dateTimeKey: dateTimeKey(selectedDateTime),
        mark: currentMark != '' ? currentMark : null,
        memo: memoController.text != '' ? memoController.text : null,
      );

      RecordInfoClass? recordInfo = getRecordInfo(
        recordInfoList: widget.taskInfo.recordInfoList,
        targetDateTime: selectedDateTime,
      );

      if (recordInfo == null) {
        widget.taskInfo.recordInfoList.add(newRecordInfo);
      } else {
        int index = getRecordIndex(
          recordInfoList: widget.taskInfo.recordInfoList,
          targetDateTime: selectedDateTime,
        );

        widget.taskInfo.recordInfoList[index] = newRecordInfo;
      }

      await groupMethod.updateGroup(gid: groupId, groupInfo: widget.groupInfo);
    }

    setState(() => isShowInput = false);
  }

  wText(bool isLight, String text, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        child: CommonText(
          text: text,
          color: grey.original,
          fontSize: 12,
          isBold: !isLight,
          isNotTr: text == '|',
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
    String groupId = widget.groupInfo.gid;
    DateTime selectedDateTime = widget.selectedDateTime;

    int index = getRecordIndex(
      recordInfoList: widget.taskInfo.recordInfoList,
      targetDateTime: selectedDateTime,
    );

    widget.taskInfo.recordInfoList[index].memo = null;
    await groupMethod.updateGroup(gid: groupId, groupInfo: widget.groupInfo);

    setState(() {
      memoController.text = '';
      isShowInput = true;
      isAutoFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String colorName = widget.groupInfo.colorName;
    ColorClass color = getColorClass(colorName);
    Color cursorColor = isLight ? color.s300 : darkTextColor;
    bool isSelection =
        widget.taskInfo.dateTimeType == taskDateTimeType.selection;
    List<Map<String, dynamic>> markList =
        isSelection ? selectionMarkList : weekMonthMarkList;

    return CommonPopup(
      insetPaddingHorizontal: 40,
      height: isSelection ? 380 : 320,
      child: CommonContainer(
        innerPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView(
          children: [
            Column(
              children: markList
                  .map((info) => MarkItem(
                        isSelected: info['mark'] == currentMark,
                        mark: info['mark'],
                        name: info['name'],
                        colorName: colorName,
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
                        hintText: '메모 입력하기'.tr(),
                        fontSize: 15,
                        cursorColor: cursorColor,
                        autofocus: isAutoFocus,
                        controller: memoController,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 8,
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: (_) => {},
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
                          isNotTr: true,
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
    ColorClass color = getColorClass(colorName);

    return InkWell(
      onTap: () => onTap(mark),
      child: Column(
        children: [
          CommonSpace(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? isLight
                      ? color.s50
                      : color.s300
                  : null,
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
                    color: isLight ? color.s300 : darkTextColor,
                  ),
                ),
                CommonSpace(width: 10),
                CommonText(
                  text: name,
                  color: isLight
                      ? isSelected
                          ? color.original
                          : textColor
                      : isSelected
                          ? color.s50
                          : darkTextColor,
                  isBold: !isLight,
                )
              ],
            ),
          ),
          CommonSpace(height: 10),
          CommonDivider(color: isLight ? color.s50 : Colors.white12),
        ],
      ),
    );
  }
}
