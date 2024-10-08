import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonImage.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:provider/provider.dart';

class ImageSelectionModalSheet extends StatelessWidget {
  ImageSelectionModalSheet({
    super.key,
    required this.uint8List,
    required this.onSlide,
    required this.onRemove,
  });

  Uint8List uint8List;
  Function() onSlide, onRemove;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonModalSheet(
      title: '사진',
      height: 530,
      child: Column(
        children: [
          CommonImage(
            uint8List: uint8List,
            width: double.infinity,
            height: 335,
            onTap: (_) => onSlide(),
          ),
          CommonSpace(height: 10),
          Row(
            children: [
              ModalButton(
                svgName: 'image',
                actionText: '사진 보기',
                isBold: !isLight,
                color: isLight ? textColor : darkTextColor,
                onTap: onSlide,
              ),
              CommonSpace(width: 10),
              ModalButton(
                svgName: 'remove',
                isBold: !isLight,
                actionText: '삭제하기',
                color: red.s200,
                onTap: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
