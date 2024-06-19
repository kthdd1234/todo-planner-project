import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonImage.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/page/ImageSlidePage.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:project/widget/modalSheet/ImageSelectionModalSheet.dart';
import 'package:project/widget/modalSheet/MemoModalSheet.dart';
import 'package:project/widget/modalSheet/TitleSettingModalSheet.dart';

class MemoContainer extends StatefulWidget {
  MemoContainer({
    super.key,
    required this.recordBox,
    required this.selectedDateTime,
  });

  RecordBox? recordBox;
  DateTime selectedDateTime;

  @override
  State<MemoContainer> createState() => _MemoContainerState();
}

class _MemoContainerState extends State<MemoContainer> {
  UserBox user = userRepository.user;

  onMemoTitle(String memoTitle, String memoColorName) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleSettingModalSheet(
        title: memoTitle,
        colorName: memoColorName,
        onCompleted: (String title_, String colorName_) async {
          user.memoTitleInfo = {'title': title_, 'colorName': colorName_};
          await user.save();
          navigatorPop(context);
        },
      ),
    );
  }

  onMemoText() {
    showModalBottomSheet(
      context: context,
      builder: (context) => MemoModalSheet(
        onEdit: () {
          navigatorPop(context);

          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => MemoSettingPage(
                recordBox: widget.recordBox,
                initDateTime: widget.selectedDateTime,
              ),
            ),
          );
        },
        onRemove: () async {
          navigatorPop(context);

          widget.recordBox?.memo = null;
          await widget.recordBox?.save();
        },
      ),
    );
  }

  onImage(Uint8List uint8List) {
    List<Uint8List>? imageList = widget.recordBox?.imageList;

    if (imageList != null) {
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
                  curIndex: imageList.indexOf(uint8List),
                  uint8ListList: imageList,
                ),
              ),
            );
          },
          onRemove: () async {
            imageList.removeWhere((uint8List_) => uint8List_ == uint8List);

            if (imageList.isEmpty) {
              widget.recordBox?.imageList = null;
            }

            await widget.recordBox?.save();
            navigatorPop(context);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> taskTitleInfo = user.memoTitleInfo;
    String memoTitle = taskTitleInfo['title'];
    String colorName = taskTitleInfo['colorName'];

    bool isText = widget.recordBox?.memo != null;
    bool isImageList = widget.recordBox?.imageList != null;
    bool isMemo = widget.recordBox != null && (isText || isImageList);

    return isMemo
        ? CommonContainer(
            innerPadding: const EdgeInsets.all(0),
            outerPadding: EdgeInsets.fromLTRB(7, 0, 7, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HorizentalBorder(color: orange.s50),
                Container(
                  width: double.infinity,
                  color: Color.fromARGB(255, 255, 251, 243),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12.5,
                  ),
                  child: Column(
                    children: [
                      isText
                          ? InkWell(
                              onTap: onMemoText,
                              child: CommonText(
                                text: widget.recordBox!.memo!,
                                textAlign: TextAlign.start,
                              ),
                            )
                          : const CommonNull(),
                      CommonSpace(height: isText && isImageList ? 10 : 0),
                      isImageList
                          ? ImageContainer(
                              length: widget.recordBox!.imageList?.length ?? 0,
                              uint8ListList: widget.recordBox!.imageList ?? [],
                              onImage: onImage,
                            )
                          : const CommonNull(),
                    ],
                  ),
                ),
                HorizentalBorder(color: orange.s50),
              ],
            ),
          )
        : const CommonNull();
  }
}
