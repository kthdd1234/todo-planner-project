// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonImage.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/widget/popup/AlertPopup.dart';
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
  MemoSettingPage({
    super.key,
    required this.recordBox,
    required this.initDateTime,
  });

  RecordBox? recordBox;
  DateTime initDateTime;

  @override
  State<MemoSettingPage> createState() => _MemoSettingPageState();
}

class _MemoSettingPageState extends State<MemoSettingPage> {
  List<Uint8List> uint8ListList = [];
  TextEditingController memoContoller = TextEditingController();

  @override
  void initState() {
    RecordBox? recordBox = widget.recordBox;
    String? memo = recordBox?.memo ?? '';
    List<Uint8List>? imageList = recordBox?.imageList ?? [];

    memoContoller.text = memo;
    uint8ListList = imageList;

    super.initState();
  }

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
        uint8ListList: uint8ListList,
        onCamera: (Uint8List uint8List) {
          setState(() => uint8ListList.add(uint8List));
          navigatorPop(context);
        },
        onGallery: (List<Uint8List> uint8ListList_) {
          setState(() => uint8ListList = [...uint8ListList_]);
          navigatorPop(context);
        },
      ),
    );
  }

  onImage(Uint8List uint8List) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ImageSelectionModalSheet(
        uint8List: uint8List,
        onSlide: () {
          navigatorPop(context);
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ImageSlidePage(
                curIndex: uint8ListList.indexOf(uint8List),
                uint8ListList: uint8ListList,
              ),
            ),
          );
        },
        onRemove: () {
          setState(() {
            uint8ListList.removeWhere((uint8List_) => uint8List_ == uint8List);
          });
          navigatorPop(context);
        },
      ),
    );
  }

  onCompletedMemo() async {
    bool isEmpty = uint8ListList.isEmpty && memoContoller.text == '';

    if (isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '한 장 이상의 사진\n또는 한 글자 이상 입력해주세요',
          buttonText: '확인',
          height: 175,
          onTap: () => navigatorPop(context),
        ),
      );
    } else {
      String? memo = memoContoller.text != '' ? memoContoller.text : null;
      List<Uint8List>? imageList =
          uint8ListList.isNotEmpty ? uint8ListList : null;
      if (widget.recordBox == null) {
        recordRepository.updateRecord(
          key: dateTimeKey(widget.initDateTime),
          record: RecordBox(
            createDateTime: widget.initDateTime,
            memo: memo,
            imageList: imageList,
          ),
        );
      } else {
        widget.recordBox!.memo = memo;
        widget.recordBox!.imageList = imageList;

        await widget.recordBox!.save();
      }

      navigatorPop(context);
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
                    ImageContainer(
                      uint8ListList: uint8ListList,
                      onImage: onImage,
                    ),
                    MemoField(
                      controller: memoContoller,
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
    required this.uint8ListList,
    required this.onImage,
    this.length,
  });

  List<Uint8List> uint8ListList;
  int? length;
  Function(Uint8List) onImage;

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: length ?? 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: uint8ListList
          .map(
            (uint8List) => CommonImage(
              uint8List: uint8List,
              height: 150,
              onTap: onImage,
            ),
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
