// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonImage.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/main.dart';
import 'package:project/page/ImageSlidePage.dart';
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
  MemoSettingPage({
    super.key,
    required this.initDateTime,
    this.memoInfo,
  });

  DateTime initDateTime;
  MemoInfoClass? memoInfo;

  @override
  State<MemoSettingPage> createState() => _MemoSettingPageState();
}

class _MemoSettingPageState extends State<MemoSettingPage> {
  Uint8List? uint8List;
  TextEditingController memoContoller = TextEditingController();
  TextAlign textAlign = TextAlign.left;

  @override
  void initState() {
    super.initState();

    if (widget.memoInfo != null) {
      memoContoller.text = widget.memoInfo!.text ?? '';
      textAlign = widget.memoInfo!.textAlign ?? TextAlign.left;

      if (widget.memoInfo!.imgUrl != null) {
        getImg(widget.memoInfo!.imgUrl!).then(
            (uint8ListResult) => setState(() => uint8List = uint8ListResult));
      }
    }
  }

  onImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImageAddModalSheet(
        onResult: (Uint8List uint8ListResult) {
          setState(() => uint8List = uint8ListResult);
          navigatorPop(context);
        },
      ),
    );
  }

  onAlign() {
    setState(() => textAlign = nextTextAlign[textAlign]!);
  }

  onClock() {
    String locale = context.locale.toString();
    DateTime now = DateTime.now();
    String time = hmFormatter(locale: locale, dateTime: now);

    setState(() => memoContoller.text = '${memoContoller.text}$time');
  }

  onSelectionImage(Uint8List selectionUint8List) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ImageSelectionModalSheet(
        uint8List: selectionUint8List,
        onSlide: () {
          navigatorPop(context);
          movePage(
            context: context,
            page: ImageSlidePage(
              uint8ListList: [selectionUint8List],
              curIndex: 0,
            ),
          );
        },
        onRemove: () async {
          setState(() => uint8List = null);
          navigatorPop(context);
        },
      ),
    );
  }

  Future<String?> onImgUrl(String? mid) async {
    String uid = auth.currentUser!.uid;

    if (uint8List != null) {
      try {
        String path = '$uid/$mid/img.jpg';
        TaskSnapshot result = await storageRef.child(path).putData(uint8List!);

        return result.state == TaskState.success ? path : null;
      } catch (e) {
        log('$e');
        return null;
      }
    }

    return null;
  }

  onSave() async {
    bool isEmpty = uint8List == null && memoContoller.text == '';

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
      String mid = dateTimeKey(widget.initDateTime).toString();
      String? text = memoContoller.text != '' ? memoContoller.text : null;
      String? imgUrl = await onImgUrl(mid);

      if (widget.memoInfo == null) {
        await memoMethod.addMemo(
          mid: mid,
          memoInfo: MemoInfoClass(
            dateTimeKey: dateTimeKey(widget.initDateTime),
            imgUrl: imgUrl,
            text: text,
            textAlign: textAlign,
          ),
        );
      } else {
        if (widget.memoInfo!.imgUrl != null && uint8List == null) {
          storageRef.child(widget.memoInfo!.imgUrl!);
        }

        widget.memoInfo!.text = text;
        widget.memoInfo!.imgUrl = imgUrl;
        widget.memoInfo!.textAlign = textAlign;

        await memoMethod.updateMemo(mid: mid, memoInfo: widget.memoInfo!);
      }

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
            HorizentalBorder(colorName: '주황색'),
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
                                uint8List != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: CommonImage(
                                          uint8List: uint8List!,
                                          height: 250,
                                          onTap: onSelectionImage,
                                        ),
                                      )
                                    : const CommonNull(),
                                MemoField(
                                  controller: memoContoller,
                                  cursorColor: cursorColor,
                                  textAlign: textAlign,
                                  fontSize: 14,
                                  onChanged: (_) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MemoActionBar(
              containerColor: containerColor,
              textAlign: textAlign,
              isLight: isLight,
              onImage: onImage,
              onAlign: onAlign,
              onClock: onClock,
              onSave: onSave,
            ),
            HorizentalBorder(colorName: '주황색'),
          ],
        ),
      ),
    );
  }
}
