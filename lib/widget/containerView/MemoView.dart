import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/page/ImageSlidePage.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:project/widget/memo/MemoBackground.dart';
import 'package:project/widget/memo/MemoImage.dart';
import 'package:project/widget/modalSheet/ImageSelectionModalSheet.dart';
import 'package:project/widget/modalSheet/MemoModalSheet.dart';
import 'package:provider/provider.dart';

class MemoView extends StatefulWidget {
  MemoView({super.key});

  @override
  State<MemoView> createState() => _MemoViewState();
}

class _MemoViewState extends State<MemoView> {
  onMemoText() {
    showModalBottomSheet(
      context: context,
      builder: (context) => MemoModalSheet(
        onEdit: () {
          navigatorPop(context);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => MemoSettingPage(
          //       recordBox: widget.recordBox,
          //       initDateTime: widget.selectedDateTime,
          //     ),
          //   ),
          // );
        },
        onRemove: () async {
          // widget.recordBox?.memo = null;
          // await widget.recordBox?.save();

          // if (isEmptyRecord(widget.recordBox)) {
          //   await recordRepository.recordBox
          //       .delete(dateTimeKey(widget.selectedDateTime));
          // }

          navigatorPop(context);
        },
      ),
    );
  }

  onImage(Uint8List uint8List) {
    // List<Uint8List>? imageList = widget.recordBox?.imageList;

    // if (imageList != null) {
    //   showModalBottomSheet(
    //     isScrollControlled: true,
    //     context: context,
    //     builder: (context) => ImageSelectionModalSheet(
    //       uint8List: uint8List,
    //       onSlide: () {
    //         navigatorPop(context);
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute<void>(
    //             builder: (BuildContext context) => ImageSlidePage(
    //               curIndex: imageList.indexOf(uint8List),
    //               uint8ListList: imageList,
    //             ),
    //           ),
    //         );
    //       },
    //       onRemove: () async {
    //         imageList.removeWhere((uint8List_) => uint8List_ == uint8List);

    //         if (imageList.isEmpty) {
    //           widget.recordBox?.imageList = null;
    //         }

    //         await widget.recordBox?.save();
    //         navigatorPop(context);
    //       },
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    // bool isText = widget.recordBox?.memo != null;
    // bool isImageList = widget.recordBox?.imageList != null;
    // bool isMemo = widget.recordBox != null && (isText || isImageList);
    Color containerColor = isLight ? memoBgColor : darkContainerColor;
    Color borderColor = isLight ? orange.s50 : Colors.white10;

    bool isText = false;
    bool isImageList = false;
    bool isMemo = false;

    return isMemo
        ? CommonContainer(
            radius: 0,
            color: containerColor,
            innerPadding: const EdgeInsets.all(0),
            outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HorizentalBorder(
                  colorName: '주황색',
                ),
                CustomPaint(
                  painter: MemoBackground(isLight: isLight, color: orange.s50),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12.5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isText
                            ? GestureDetector(
                                onTap: onMemoText,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: CommonText(
                                    text: '',
                                    textAlign: TextAlign.start,
                                    isBold: !isLight,
                                    isNotTr: true,
                                  ),
                                ),
                              )
                            : const CommonNull(),
                        CommonSpace(height: isText && isImageList ? 10 : 0),
                        isImageList
                            ? MemoImage(uint8ListList: [], onImage: onImage)
                            : const CommonNull(),
                      ],
                    ),
                  ),
                ),
                HorizentalBorder(colorName: '주황색'),
              ],
            ),
          )
        : const CommonNull();
  }
}
