import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:project/widget/modalSheet/TaskMoreModalSheet.dart';
import 'package:project/widget/popup/MarkPopup.dart';
import 'package:provider/provider.dart';

class TaskView extends StatefulWidget {
  TaskView({
    super.key,
    required this.groupInfo,
    required this.taskInfo,
    required this.selectedDateTime,
  });

  GroupInfoClass groupInfo;
  TaskInfoClass taskInfo;
  DateTime selectedDateTime;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
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
          padding: const EdgeInsets.only(
            left: 15,
            right: 3,
            top: 10,
            bottom: 10,
          ),
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
        groupInfo: widget.groupInfo,
        taskInfo: widget.taskInfo,
        selectedDateTime: widget.selectedDateTime,
      ),
    );
  }

  onMore() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskMoreModalSheet(
        groupInfo: widget.groupInfo,
        taskInfo: widget.taskInfo,
        selectedDateTime: widget.selectedDateTime,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    String colorName = widget.groupInfo.colorName;
    ColorClass color = getColorClass(colorName);
    RecordInfoClass? recordInfo = getRecordInfo(
      recordList: widget.taskInfo.recordList,
      targetDateTime: widget.selectedDateTime,
    );

    return Container(
      color: isLight ? Colors.white : darkContainerColor,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: onMore,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: recordInfo?.mark != null
                            ? isLight
                                ? color.s50
                                : color.s400
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: widget.taskInfo.name,
                            textAlign: TextAlign.start,
                            isBold: !isLight,
                            isNotTr: true,
                          ),
                          recordInfo?.memo != null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: CommonText(
                                    text: recordInfo!.memo!,
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
                ),
              ),
              CommonSpace(width: 15),
              wAction(
                svgName: 'mark-${recordInfo?.mark ?? 'E'}',
                width: 20,
                actionColor: color.s200,
                onTap: onMark,
              ),
            ],
          ),
          HorizentalBorder(colorName: colorName)
        ],
      ),
    );
  }
}
