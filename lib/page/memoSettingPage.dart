// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:project/widget/memo/MemoActionBar.dart';
import 'package:project/widget/memo/MemoBackground.dart';
import 'package:project/widget/memo/MemoField.dart';
import 'package:project/widget/memo/MemoImage.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/modalSheet/ImageAddModalSheet.dart';
import 'package:project/widget/modalSheet/ImageSelectionModalSheet.dart';
import 'package:provider/provider.dart';

class MemoSettingPage extends StatefulWidget {
  MemoSettingPage({super.key, required this.initDateTime});

  DateTime initDateTime;

  @override
  State<MemoSettingPage> createState() => _MemoSettingPageState();
}

class _MemoSettingPageState extends State<MemoSettingPage> {
  List<Uint8List> uint8ListList = [];
  TextEditingController memoContoller = TextEditingController();
  TextAlign textAlign = TextAlign.left;

  @override
  void initState() {
    // RecordBox? recordBox = widget.recordBox;
    // String? memo = recordBox?.memo ?? '';
    // List<Uint8List>? imageList = recordBox?.imageList ?? [];

    // memoContoller.text = memo;
    // uint8ListList = imageList;

    super.initState();
  }

  onImage() {
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

  onAlign() {
    //
  }

  onClock() {
    //
  }

  onSelectionImage(Uint8List uint8List) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ImageSelectionModalSheet(
        uint8List: uint8List,
        onSlide: () {
          navigatorPop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => ImageSlidePage(
          //       curIndex: uint8ListList.indexOf(uint8List),
          //       uint8ListList: uint8ListList,
          //     ),
          //   ),
          // );
        },
        onRemove: () async {
          // setState(() {
          //   uint8ListList.removeWhere((uint8List_) => uint8List_ == uint8List);
          //   if (uint8ListList.isEmpty) widget.recordBox?.imageList = null;

          //   widget.recordBox?.save();
          // });

          navigatorPop(context);
        },
      ),
    );
  }

  onSave() async {
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
      // List<Uint8List>? imageList =
      //     uint8ListList.isNotEmpty ? uint8ListList : null;
      // if (widget.recordBox == null) {
      //   recordRepository.updateRecord(
      //     key: dateTimeKey(widget.initDateTime),
      //     record: RecordBox(
      //       createDateTime: widget.initDateTime,
      //       memo: memo,
      //       imageList: imageList,
      //     ),
      //   );
      // } else {
      //   widget.recordBox!.memo = memo;
      //   widget.recordBox!.imageList = imageList;

      //   await widget.recordBox!.save();
      // }

      navigatorPop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;
    Color containerColor = isLight ? memoBgColor : darkContainerColor;
    Color borderColor = isLight ? orange.s50 : Colors.white10;
    Color cursorColor = isLight ? orange.s300 : darkTextColor;

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: ymdeFormatter(locale: locale, dateTime: widget.initDateTime),
          isBold: !isLight,
          isNotTr: false,
          fontSize: 15,
        ),
        body: Column(
          children: [
            Expanded(
              child: CommonContainer(
                innerPadding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    HorizentalBorder(colorName: '주황색'),
                    Expanded(
                      child: Container(
                        color: containerColor,
                        child: CustomPaint(
                          painter: MemoBackground(
                            isLight: isLight,
                            color: orange.s50,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            child: ListView(
                              children: [
                                MemoImage(
                                  uint8ListList: uint8ListList,
                                  onImage: onSelectionImage,
                                ),
                                MemoField(
                                  controller: memoContoller,
                                  cursorColor: cursorColor,
                                  onChanged: (_) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    HorizentalBorder(colorName: '주황색'),
                  ],
                ),
              ),
            ),
            MemoActionBar(
              containerColor: containerColor,
              isLight: isLight,
              onImage: onImage,
              onAlign: onAlign,
              onClock: onClock,
              onSave: onSave,
            )
          ],
        ),
      ),
    );
  }
}
