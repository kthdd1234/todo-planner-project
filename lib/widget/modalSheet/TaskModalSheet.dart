import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/modalSheet/CategoryModalSheet.dart';
import 'package:project/widget/modalSheet/RepeatModalSheet.dart';

class TaskModalSheet extends StatefulWidget {
  TaskModalSheet({super.key, required this.title});

  String title;

  @override
  State<TaskModalSheet> createState() => _TaskModalSheetState();
}

class _TaskModalSheetState extends State<TaskModalSheet> {
  bool isHighlighter = false;
  String categoryId = '';
  TextEditingController controller = TextEditingController();

  onHighlighter(bool newValue) {
    setState(() => isHighlighter = newValue);
  }

  onCategory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const CategoryModalSheet(),
    );
  }

  onEditingComplete() {
    //
  }

  onRepeat() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const RepeatModalSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '${widget.title} 추가',
        height: widget.title == '루틴' ? 325 : 275,
        child: CommonContainer(
          innerPadding: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskSetting(
                title: '형광색',
                onTap: () => onHighlighter(!isHighlighter),
                child: CupertinoSwitch(
                  activeColor: indigo.s300,
                  value: isHighlighter,
                  onChanged: onHighlighter,
                ),
              ),
              TaskSetting(
                title: '카테고리',
                onTap: onCategory,
                child: CommonTag(
                  text: '📚 독서',
                  textColor: blue.original,
                  bgColor: blue.s50,
                  onTap: onCategory,
                ),
              ),
              widget.title == '루틴'
                  ? TaskSetting(
                      title: '반복',
                      onTap: onRepeat,
                      child: CommonSvgText(
                        text: '매주 - 월, 수, 금',
                        fontSize: 14,
                        textColor: textColor,
                        svgColor: grey.s400,
                        svgName: 'dir-right',
                        svgWidth: 7,
                        svgLeft: 7,
                        svgDirection: SvgDirectionEnum.right,
                        onTap: onRepeat,
                      ),
                    )
                  : const CommonNull(),
              TaskName(
                controller: controller,
                onEditingComplete: onEditingComplete,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskSetting extends StatelessWidget {
  TaskSetting({
    super.key,
    required this.title,
    required this.child,
    required this.onTap,
  });

  String title;
  Widget child;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [CommonText(text: title), child],
                ),
              ],
            ),
          ),
          CommonDivider(color: grey.s200, horizontal: 15),
        ],
      ),
    );
  }
}

class TaskName extends StatelessWidget {
  TaskName({
    super.key,
    required this.controller,
    required this.onEditingComplete,
  });

  TextEditingController controller;
  Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 25),
            hintText: '할 일을 입력해주세요',
            hintStyle: TextStyle(color: grey.s400),
            filled: true,
            fillColor: whiteBgBtnColor,
            suffixIcon: UnconstrainedBox(
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: indigo.s200,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onEditingComplete: onEditingComplete,
        ),
      ),
    );
  }
}
