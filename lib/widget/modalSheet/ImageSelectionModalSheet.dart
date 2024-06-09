import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonImage.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/button/ModalButton.dart';

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
    return CommonModalSheet(
      title: '사진',
      height: 530,
      child: Column(
        children: [
          CommonImage(
            uint8List: uint8List,
            height: 335,
            onTap: (_) => onSlide(),
          ),
          CommonSpace(height: 10),
          Row(
            children: [
              ModalButton(
                svgName: 'image',
                actionText: '자세히 보기',
                color: textColor,
                onTap: onSlide,
              ),
              CommonSpace(width: 10),
              ModalButton(
                svgName: 'remove',
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
