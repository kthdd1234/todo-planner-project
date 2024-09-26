import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/main.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:provider/provider.dart';

class AddView extends StatefulWidget {
  AddView({super.key, required this.groupInfo});

  GroupInfoClass groupInfo;

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isShowInput = false;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    bool isLight = context.watch<ThemeProvider>().isLight;
    String colorName = widget.groupInfo.colorName;
    ColorClass color = getColorClass(colorName);

    onInput(bool isShow) {
      setState(() => isShowInput = isShow);
    }

    onCompleted() async {
      onInput(false);
      FocusScope.of(context).unfocus();

      if (controller.text != '') {
        String newTid = uuid();
        DateTime now = DateTime.now();

        await taskMethod.addTask(
          gid: widget.groupInfo.gid,
          tid: newTid,
          taskInfo: TaskInfoClass(
            createDateTime: now,
            tid: newTid,
            name: controller.text,
            dateTimeType: taskDateTimeType.selection,
            dateTimeList: [selectedDateTime],
            recordList: [],
          ),
        );

        setState(() => controller.text = '');
      }
    }

    return Column(
      children: [
        isShowInput
            ? TextFormField(
                scrollController: scrollController,
                controller: controller,
                autofocus: true,
                cursorColor: color.s400,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: '할 일을 입력해주세요.',
                  hintStyle: TextStyle(fontSize: 14, color: grey.s400),
                  contentPadding: const EdgeInsets.all(0),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
                onEditingComplete: onCompleted,
                onTapOutside: (_) => onCompleted(),
              )
            : InkWell(
                onTap: () => onInput(true),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      CommonText(
                        text: '+ 할 일 추가',
                        color: isLight ? color.original : grey.s300,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: svgAsset(
                            name: 'mark-d', width: 20, color: color.s100),
                      ),
                    ],
                  ),
                ),
              ),
        HorizentalBorder(colorName: colorName),
      ],
    );
  }
}
