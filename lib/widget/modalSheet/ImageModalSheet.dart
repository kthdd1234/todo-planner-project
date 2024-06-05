import 'package:flutter/cupertino.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';
import 'package:project/widget/button/ModalButton.dart';

class ImageModalSheet extends StatelessWidget {
  const ImageModalSheet({super.key});

  onCamera() {
    //
  }

  onGallery() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      title: '사진 추가',
      height: 190,
      child: Column(
        children: [
          Row(
            children: [
              ModalButton(
                svgName: 'camera',
                actionText: '카메라',
                color: textColor,
                onTap: onCamera,
              ),
              CommonSpace(width: 5),
              ModalButton(
                svgName: 'gallery',
                actionText: '갤러리',
                color: textColor,
                onTap: onGallery,
              )
            ],
          )
        ],
      ),
    );
  }
}
