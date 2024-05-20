import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/common/CommonTextFormField.dart';
import 'package:project/provider/highlighterProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:provider/provider.dart';

class ItemSettingPage extends StatefulWidget {
  const ItemSettingPage({super.key});

  @override
  State<ItemSettingPage> createState() => _ItemSettingPageState();
}

class _ItemSettingPageState extends State<ItemSettingPage> {
  FocusNode todoNode = FocusNode();
  FocusNode memoNode = FocusNode();

  String seletedType = eOneday;
  TextEditingController todoController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  @override
  void initState() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          context
              .read<HighlighterProvider>()
              .changeHighlighter(newValue: false);
        },
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isHighlighter = context.watch<HighlighterProvider>().isHighlighter;

    onType(String type) {
      setState(() => seletedType = type);
    }

    onSave() {
      //
    }

    KeyboardActionsConfig buildConfig(BuildContext context) {
      return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: const Color(0xffF3F4F9),
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: todoNode,
            enabled: false,
            displayArrows: false,
            displayDoneButton: false,
            toolbarButtons: [
              (node) => HighlighterActionBar(isHighlighter: isHighlighter),
            ],
          ),
        ],
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: KeyboardActions(
        config: buildConfig(context),
        child: CommonBackground(
          child: CommonScaffold(
            resizeToAvoidBottomInset: false,
            appBarInfo: AppBarInfoClass(title: '할 일 추가'),
            body: Column(
              children: [
                Expanded(
                  child: CommonContainer(
                    outerPadding: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TodoType(
                          seletedType: seletedType,
                          onTap: onType,
                        ),
                        TodoName(
                          todoNode: todoNode,
                          controller: todoController,
                          seletedType: seletedType,
                          selectedColor: Colors.indigo.shade200,
                        ),
                        TodoMemo(controller: memoController)
                      ],
                    ),
                  ),
                ),
                CommonButton(
                  text: '추가하기',
                  outerPadding: const EdgeInsets.symmetric(vertical: 10),
                  textColor: Colors.white,
                  buttonColor: themeColor,
                  verticalPadding: 15,
                  borderRadius: 100,
                  onTap: onSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HighlighterActionBar extends StatelessWidget {
  const HighlighterActionBar({super.key, required this.isHighlighter});

  final bool isHighlighter;

  @override
  Widget build(BuildContext context) {
    bool isHighlighter = context.watch<HighlighterProvider>().isHighlighter;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonSvgText(
              svgRight: 7,
              text: '할 일에 형광펜 표시 할까요?',
              fontSize: 13,
              svgName: 'highlighter',
              svgWidth: 12,
              svgDirection: SvgDirectionEnum.left,
            ),
            CupertinoSwitch(
              activeColor: Colors.indigo.shade200,
              value: isHighlighter,
              onChanged: (bool newValue) {
                context
                    .read<HighlighterProvider>()
                    .changeHighlighter(newValue: newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TodoType extends StatelessWidget {
  TodoType({super.key, required this.seletedType, required this.onTap});

  String seletedType;
  Function(String type) onTap;

  @override
  Widget build(BuildContext context) {
    wSelectContainer({
      required String type,
      required String title,
      required String subTitle,
    }) {
      bool isSelected = type == seletedType;

      return Expanded(
        child: CommonContainer(
          onTap: () => onTap(type),
          radius: 7,
          color: isSelected ? Colors.indigo.shade200 : Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: title,
                isBold: true,
                color: isSelected ? Colors.white : Colors.grey.shade400,
              ),
              CommonSpace(height: 5),
              CommonText(
                text: subTitle,
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.grey.shade400,
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          TodoTitle(
            title: '유형',
            additionalWidget: Row(
              children: [
                CommonText(
                  text: '루틴 유형은 할 일 앞에',
                  fontSize: 10,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: CommonCircle(color: Colors.indigo.shade200, size: 9),
                ),
                CommonText(text: '을 표시해요.', fontSize: 10, color: Colors.grey),
              ],
            ),
          ),
          CommonSpace(height: 10),
          Row(
            children: [
              wSelectContainer(
                type: eOneday,
                title: '기본 유형',
                subTitle: '딱 하루만 실천해요',
              ),
              CommonSpace(width: 5),
              wSelectContainer(
                type: eRoutin,
                title: '루틴 유형',
                subTitle: '꾸준히 실천해요',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TodoName extends StatelessWidget {
  TodoName({
    super.key,
    required this.controller,
    required this.seletedType,
    required this.selectedColor,
    required this.todoNode,
  });

  TextEditingController controller;
  String seletedType;
  Color selectedColor;
  FocusNode todoNode;

  @override
  Widget build(BuildContext context) {
    bool isHighlighter = context.watch<HighlighterProvider>().isHighlighter;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          TodoTitle(
            title: '할 일',
            additionalWidget: CommonSvgText(
              text: '형광펜',
              fontSize: 11,
              svgName: 'highlighter',
              svgWidth: 11,
              svgColor:
                  isHighlighter ? Colors.indigo.shade300 : Colors.grey.shade400,
              textColor:
                  isHighlighter ? Colors.indigo.shade300 : Colors.grey.shade400,
              svgDirection: SvgDirectionEnum.left,
            ),
          ),
          Row(
            children: [
              seletedType == eRoutin
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 10),
                      child: CommonCircle(color: selectedColor, size: 15),
                    )
                  : const CommonNull(),
              Expanded(
                child: CommonTextFormField(
                  textBgColor: isHighlighter ? Colors.indigo.shade50 : null,
                  focusNode: todoNode,
                  controller: controller,
                  hintText: '할 일을 입력해주세요.',
                  maxLength: 20,
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TodoMemo extends StatelessWidget {
  TodoMemo({super.key, required this.controller});

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TodoTitle(title: '한 줄 메모'),
        CommonTextFormField(
          controller: controller,
          hintText: '메모 할 부분이 있다면 입력해주세요. (선택)',
          maxLength: 20,
          onEditingComplete: () => FocusScope.of(context).unfocus(),
        )
      ],
    );
  }
}

class TodoTitle extends StatelessWidget {
  TodoTitle({super.key, required this.title, this.additionalWidget});

  String title;
  Widget? additionalWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(text: title, fontSize: 14),
        additionalWidget != null ? additionalWidget! : const CommonNull(),
      ],
    );
  }
}
