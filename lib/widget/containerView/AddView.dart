import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/task_box/task_box.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:provider/provider.dart';

class AddView extends StatefulWidget {
  AddView({
    super.key,
    this.taskBox,
    required this.colorName,
    required this.onText,
  });

  TaskBox? taskBox;
  String colorName;
  Function(TaskBox?, String) onText;

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isShowInput = false;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    ColorClass color = getColorClass(widget.colorName);

    onInput(bool isShow) {
      setState(() => isShowInput = isShow);
    }

    onCompleted() {
      onInput(false);
      FocusScope.of(context).unfocus();

      if (controller.text != '') {
        widget.onText(widget.taskBox, controller.text);
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
                      svgAsset(name: 'mark-d', width: 20, color: color.s100),
                    ],
                  ),
                ),
              ),
        HorizentalBorder(colorName: widget.colorName),
      ],
    );
  }
}
