import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/modalSheet/ImageModalSheet.dart';

class MemoSettingPage extends StatefulWidget {
  const MemoSettingPage({super.key});

  @override
  State<MemoSettingPage> createState() => _MemoSettingPageState();
}

class _MemoSettingPageState extends State<MemoSettingPage> {
  TextEditingController memoContoller = TextEditingController();
  FocusNode focusNode = FocusNode();

  actionButton({
    required String text,
    required ColorClass color,
    required Function() onTap,
  }) {
    return Expanded(
      child: CommonButton(
        text: text,
        textColor: Colors.white,
        buttonColor: color.s200,
        verticalPadding: 15,
        borderRadius: 7,
        onTap: onTap,
      ),
    );
  }

  onDateTime() {
    //
  }

  onChanged(_) {
    //
  }

  onAddImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImageModalSheet(),
    );
  }

  onCompletedMemo() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          isCenter: false,
          title: '메모',
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 5),
              child: CommonText(text: '2024년 6월 3일 월요일'),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: CommonContainer(
                outerPadding: 7,
                child: Column(
                  children: [
                    // ImageContainer(),
                    MemoField(
                      controller: memoContoller,
                      focusNode: focusNode,
                      onChanged: onChanged,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              child: Row(
                children: [
                  actionButton(
                    text: '+ 사진 추가',
                    color: purple,
                    onTap: onAddImage,
                  ),
                  CommonSpace(width: 7),
                  actionButton(
                    text: '완료',
                    color: indigo,
                    onTap: onAddImage,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
      ),
      children: [],
    );
  }
}

class MemoField extends StatelessWidget {
  MemoField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  TextEditingController controller;
  FocusNode focusNode;
  Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      autofocus: true,
      maxLines: null,
      minLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '메모를 입력해주세요 :D',
        hintStyle: TextStyle(color: grey.s400),
      ),
      onChanged: onChanged,
    );
  }
}
