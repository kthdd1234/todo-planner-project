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
import 'package:project/provider/initGroupProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TodoAddPage extends StatefulWidget {
  TodoAddPage({super.key, this.isEdit, this.editTodo});

  bool? isEdit;
  TodoClass? editTodo;

  @override
  State<TodoAddPage> createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  FocusNode todoNode = FocusNode();

  String seletedType = eOneday;
  TextEditingController todoController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  @override
  void initState() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          context.read<HighlighterProvider>().changeHighlighter(
              newValue: widget.isEdit == true
                  ? widget.editTodo!.isHighlighter == true
                  : false);
        },
      );
    }

    if (widget.isEdit == true) {
      TodoClass todo = widget.editTodo!;

      seletedType = todo.type;
      todoController.text = todo.name;
      memoController.text = todo.memo ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InitGroupProvider group = context.watch<InitGroupProvider>();
    ColorClass color = getColor('빨간색');
    bool isHighlighter = context.watch<HighlighterProvider>().isHighlighter;
    bool isNotEmpty = todoController.text != '';

    onSave() {
      if (isNotEmpty) {
        TodoClass todo = TodoClass(
          id: widget.isEdit == false ? const Uuid().v4() : widget.editTodo!.id,
          type: seletedType,
          name: todoController.text,
          isHighlighter: isHighlighter,
          memo: memoController.text != '' ? memoController.text : null,
        );

        InitGroupProvider provider = context.read<InitGroupProvider>();
        widget.isEdit == false
            ? provider.addTodo(todo: todo)
            : provider.editTodo(todo: todo);

        Navigator.pop(context);
      }
    }

    KeyboardActionsConfig buildConfig(BuildContext context) {
      return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey.shade50,
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: todoNode,
            enabled: false,
            displayArrows: false,
            displayDoneButton: false,
            toolbarButtons: [
              (node) => HighlighterActionBar(color: color),
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
                CommonContainer(
                  outerPadding: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TodoCategory(),
                      TodoName(
                        todoNode: todoNode,
                        controller: todoController,
                        seletedType: seletedType,
                        selectedColor: color,
                      ),
                    ],
                  ),
                ),
                CommonButton(
                  text: '추가하기',
                  outerPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  textColor: isNotEmpty ? Colors.white : Colors.grey,
                  buttonColor: isNotEmpty ? buttonColor : Colors.grey.shade300,
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
  const HighlighterActionBar({super.key, required this.color});

  final ColorClass color;

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
              text: '할 일에 형광색 표시 할까요?',
              fontSize: 13,
              svgName: 'highlighter',
              svgWidth: 12,
              textColor: Colors.grey,
              svgColor: Colors.grey,
              svgDirection: SvgDirectionEnum.left,
            ),
            CupertinoSwitch(
              activeColor: color.s200,
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

// class TodoType extends StatelessWidget {
//   TodoType({
//     super.key,
//     required this.seletedType,
//     required this.selectedColor,
//     required this.onTap,
//   });

//   String seletedType;
//   ColorClass selectedColor;
//   Function(String type) onTap;

//   @override
//   Widget build(BuildContext context) {
//     wSelectContainer({
//       required String type,
//       required String title,
//       required String subTitle,
//     }) {
//       bool isSelected = type == seletedType;

//       return Expanded(
//         child: CommonContainer(
//           onTap: () => onTap(type),
//           radius: 7,
//           color: isSelected ? selectedColor.s50 : Colors.grey.shade100,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CommonText(
//                 text: title,
//                 color:
//                     isSelected ? selectedColor.original : Colors.grey.shade400,
//                 fontSize: 15,
//               ),
//               CommonSpace(height: 5),
//               CommonText(
//                 text: subTitle,
//                 fontSize: 12,
//                 color:
//                     isSelected ? selectedColor.original : Colors.grey.shade400,
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 30),
//       child: Column(
//         children: [
//           TodoTitle(
//             title: '유형',
//             isRequired: true,
//             additionalWidget: Row(
//               children: [
//                 CommonText(
//                   text: '루틴 유형은 할 일 앞에',
//                   fontSize: 10,
//                   color: Colors.grey,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 3),
//                   child: CommonCircle(color: selectedColor.s100, size: 10),
//                 ),
//                 CommonText(text: '을 표시해요.', fontSize: 10, color: Colors.grey),
//               ],
//             ),
//           ),
//           CommonSpace(height: 10),
//           Row(
//             children: [
//               wSelectContainer(
//                 type: eOneday,
//                 title: '기본 유형',
//                 subTitle: '딱 하루만 실천해요',
//               ),
//               CommonSpace(width: 5),
//               wSelectContainer(
//                 type: eRoutin,
//                 title: '루틴 유형',
//                 subTitle: '꾸준히 실천해요',
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  ColorClass selectedColor;
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
            isRequired: true,
            additionalWidget: CommonSvgText(
              text: '형광색',
              fontSize: 11,
              svgName: 'highlighter',
              svgWidth: 11,
              svgColor:
                  isHighlighter ? selectedColor.s300 : Colors.grey.shade400,
              textColor:
                  isHighlighter ? selectedColor.s300 : Colors.grey.shade400,
              svgDirection: SvgDirectionEnum.left,
            ),
          ),
          Row(
            children: [
              seletedType == eRoutin
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 10),
                      child: CommonCircle(color: selectedColor.s100, size: 15),
                    )
                  : const CommonNull(),
              Expanded(
                child: CommonTextFormField(
                  autofocus: true,
                  controller: controller,
                  textInputAction: TextInputAction.next,
                  textBgColor: isHighlighter ? selectedColor.s50 : null,
                  focusNode: todoNode,
                  hintText: '할 일을 입력해주세요.',
                  maxLength: 30,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
          textInputAction: TextInputAction.next,
          controller: controller,
          hintText: '메모 할 부분이 있다면 입력해주세요. (선택)',
          maxLength: 30,
          onEditingComplete: () => FocusScope.of(context).unfocus(),
        )
      ],
    );
  }
}

class TodoCategory extends StatelessWidget {
  const TodoCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          TodoTitle(title: '카테고리', isRequired: true),
        ],
      ),
    );
  }
}

class TodoTitle extends StatelessWidget {
  TodoTitle({
    super.key,
    required this.title,
    this.additionalWidget,
    this.isRequired,
  });

  String title;
  bool? isRequired;
  Widget? additionalWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CommonText(text: title, fontSize: 14, isRequired: isRequired),
        additionalWidget != null ? additionalWidget! : const CommonNull(),
      ],
    );
  }
}
