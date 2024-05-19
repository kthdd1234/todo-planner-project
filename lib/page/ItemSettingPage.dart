import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/common/CommonTextFormField.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class ItemSettingPage extends StatefulWidget {
  const ItemSettingPage({super.key});

  @override
  State<ItemSettingPage> createState() => _ItemSettingPageState();
}

class _ItemSettingPageState extends State<ItemSettingPage> {
  TextEditingController todoController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  String seletedType = eOneday;
  Color selectedColor = Colors.indigo.shade200;

  @override
  Widget build(BuildContext context) {
    onType(String type) {
      setState(() => seletedType = type);
    }

    onSave() {
      //
    }

    return CommonBackground(
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
                      controller: todoController,
                      seletedType: seletedType,
                      selectedColor: selectedColor,
                    ),
                    TodoColor(),
                    TodoHighlight(),
                    TodoMemo()
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
                  child: CommonCircle(
                    color: Colors.indigo.shade200,
                    size: 9,
                  ),
                ),
                CommonText(
                  text: '을 표시해요.',
                  fontSize: 10,
                  color: Colors.grey,
                ),
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
  });

  TextEditingController controller;
  String seletedType;
  Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          TodoTitle(title: '이름'),
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
                  controller: controller,
                  hintText: '이름을 입력해주세요.',
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

class TodoColor extends StatelessWidget {
  const TodoColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          TodoTitle(title: '컬러'),
          CommonSpace(height: 15),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            children: tagColorList
                .map(
                  (tagColor) => Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CommonCircle(
                        color: tagColor.todoColor!,
                        size: 40,
                      ),
                      svgAsset(
                        name: 'mark-V',
                        width: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}

class TodoHighlight extends StatelessWidget {
  const TodoHighlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          TodoTitle(title: '형광펜'),
        ],
      ),
    );
  }
}

class TodoMemo extends StatelessWidget {
  const TodoMemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TodoTitle(title: '한 줄 메모'),
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
