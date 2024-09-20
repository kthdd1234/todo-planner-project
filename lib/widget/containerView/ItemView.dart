import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:project/widget/modalSheet/TaskMoreModalSheet.dart';
import 'package:project/widget/popup/MarkPopup.dart';
import 'package:provider/provider.dart';

class ItemView extends StatefulWidget {
  ItemView({
    super.key,
    required this.recordBox,
    required this.groupBox,
    required this.taskBox,
    required this.taskItem,
    required this.selectedDateTime,
  });

  RecordBox? recordBox;
  GroupBox groupBox;
  TaskBox taskBox;
  TaskItemClass taskItem;
  DateTime selectedDateTime;

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
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
          padding: const EdgeInsets.only(left: 15, right: 3),
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
        groupBox: widget.groupBox,
        taskBox: widget.taskBox,
        recordBox: widget.recordBox,
        selectedDateTime: widget.selectedDateTime,
      ),
    );
  }

  onMore(bool isLight) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskMoreModalSheet(
        groupBox: widget.groupBox,
        taskBox: widget.taskBox,
        recordBox: widget.recordBox,
        selectedDateTime: widget.selectedDateTime,
        taskItem: widget.taskItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isMark = getTaskInfo(
          key: 'mark',
          recordBox: widget.recordBox,
          taskId: widget.taskBox.id,
        ) !=
        null;

    return InkWell(
      onTap: () => onMore(isLight),
      child: Container(
        color: isLight ? Colors.white : darkContainerColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: isMark
                            ? isLight
                                ? widget.taskItem.color.s50
                                : widget.taskItem.color.s400
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: widget.taskItem.name,
                            textAlign: TextAlign.start,
                            isBold: !isLight,
                            isNotTr: true,
                          ),
                          widget.taskItem.memo != null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: CommonText(
                                    text: widget.taskItem.memo!,
                                    color: grey.original,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    isBold: !isLight,
                                    isNotTr: true,
                                  ),
                                )
                              : const CommonNull()
                        ],
                      ),
                    ),
                  ),
                  CommonSpace(width: 15),
                  wAction(
                    svgName: 'mark-${widget.taskItem.mark ?? 'E'}',
                    width: 20,
                    actionColor: widget.taskItem.color.s200,
                    onTap: onMark,
                  ),
                ],
              ),
            ),
            HorizentalBorder(colorName: widget.groupBox.colorName)
          ],
        ),
      ),
    );
  }
}
