import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonImage.dart';
import 'package:project/common/CommonPopup.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/page/ImageSlidePage.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/modalSheet/ImageAddModalSheet.dart';
import 'package:project/widget/modalSheet/ImageSelectionModalSheet.dart';

class MemoSettingPage extends StatefulWidget {
  MemoSettingPage({super.key, required this.initDateTime});

  DateTime initDateTime;

  @override
  State<MemoSettingPage> createState() => _MemoSettingPageState();
}

class _MemoSettingPageState extends State<MemoSettingPage> {
  List<XFile> xFileList = [];
  TextEditingController memoContoller = TextEditingController();

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
      builder: (context) => ImageAddModalSheet(
        xFileList: xFileList,
        onCamera: (XFile xFile) {
          setState(() => xFileList.add(xFile));
          navigatorPop(context);
        },
        onGallery: (List<XFile> pickedXFileList) {
          setState(() => xFileList = [...pickedXFileList]);
          navigatorPop(context);
        },
      ),
    );
  }

  onImage(XFile xFile) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ImageSelectionModalSheet(
        xFile: xFile,
        onSlide: () {
          navigatorPop(context);
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ImageSlidePage(
                curIndex: xFileList.indexOf(xFile),
                xFileList: xFileList,
              ),
            ),
          );
        },
        onRemove: () {
          setState(() {
            xFileList.removeWhere((item) => item.name == xFile.name);
          });
          navigatorPop(context);
        },
      ),
    );
  }

  onCompletedMemo() {
    bool isEmpty = xFileList.isEmpty && memoContoller.text == '';

    if (isEmpty) {
      showDialog(
        context: context,
        builder: (context) => CommonPopup(
          title: '메모 추가 알림',
          desc: '한 장 이상의 사진 추가\n또는 한글자 이상의 메모를 입력해주세요',
          buttonText: '확인',
          height: 135,
          onTap: () => navigatorPop(context),
        ),
      );
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          isCenter: false,
          title: '메모',
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 5),
              child: CommonText(
                text: ymdeFormatter(
                    locale: locale, dateTime: widget.initDateTime),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: CommonContainer(
                outerPadding: 7,
                child: ListView(
                  children: [
                    ImageContainer(xFileList: xFileList, onImage: onImage),
                    MemoField(controller: memoContoller, onChanged: onChanged),
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
                    onTap: onCompletedMemo,
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
  ImageContainer({
    super.key,
    required this.xFileList,
    required this.onImage,
  });

  List<XFile> xFileList;
  Function(XFile) onImage;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: xFileList
          .map(
            (xFile) => CommonImage(xFile: xFile, height: 150, onTap: onImage),
          )
          .toList(),
    );
  }
}

class MemoField extends StatelessWidget {
  MemoField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  TextEditingController controller;
  Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      maxLines: null,
      minLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        hintText: '메모를 입력해주세요 :D',
        hintStyle: TextStyle(color: grey.s400),
      ),
      onChanged: onChanged,
    );
  }
}
