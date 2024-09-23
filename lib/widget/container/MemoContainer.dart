import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/record_box/record_box.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/page/ImageSlidePage.dart';
import 'package:project/page/MemoSettingPage.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:project/widget/modalSheet/ImageSelectionModalSheet.dart';
import 'package:project/widget/modalSheet/MemoModalSheet.dart';
import 'package:provider/provider.dart';

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
          widget.recordBox?.memo = null;
          await widget.recordBox?.save();

          if (isEmptyRecord(widget.recordBox)) {
            await recordRepository.recordBox
                .delete(dateTimeKey(widget.selectedDateTime));
          }

          navigatorPop(context);
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
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isText = widget.recordBox?.memo != null;
    bool isImageList = widget.recordBox?.imageList != null;
    bool isMemo = widget.recordBox != null && (isText || isImageList);
    Color containerColor = isLight ? memoBgColor : darkContainerColor;
    Color borderColor = isLight ? orange.s50 : Colors.white10;

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
                  painter: BacgroundPaint(isLight: isLight, color: orange.s50),
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
                                    text: widget.recordBox!.memo!,
                                    textAlign: TextAlign.start,
                                    isBold: !isLight,
                                    isNotTr: true,
                                  ),
                                ),
                              )
                            : const CommonNull(),
                        CommonSpace(height: isText && isImageList ? 10 : 0),
                        isImageList
                            ? ImageContainer(
                                uint8ListList:
                                    widget.recordBox!.imageList ?? [],
                                onImage: onImage,
                              )
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

class BacgroundPaint extends CustomPainter {
  BacgroundPaint({required this.isLight, required this.color});

  bool isLight;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = isLight ? color : const Color.fromARGB(255, 43, 43, 43);

    for (int i = 1; i < height; i++) {
      if (i % 15 == 0) {
        Path linePath = Path();
        linePath.addRect(
            Rect.fromLTRB(0, i.toDouble(), width, (i + 0.5).toDouble()));
        canvas.drawPath(linePath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
