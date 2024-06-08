// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ModalButton.dart';

ImagePicker picker = ImagePicker();

class ImageAddModalSheet extends StatefulWidget {
  ImageAddModalSheet({
    super.key,
    required this.xFileList,
    required this.onCamera,
    required this.onGallery,
  });

  List<XFile> xFileList;
  Function(XFile) onCamera;
  Function(List<XFile>) onGallery;

  @override
  State<ImageAddModalSheet> createState() => _ImageAddModalSheetState();
}

class _ImageAddModalSheetState extends State<ImageAddModalSheet> {
  onCamera() async {
    if (widget.xFileList.length > 2) {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          title: '사진 추가 제한',
          desc: '사진은 최대 3장까지\n추가할 수 있어요.',
          buttonText: '확인',
          height: 135,
          onTap: () => navigatorPop(context),
        ),
      );
    } else {
      XFile? xFile = await picker.pickImage(source: ImageSource.camera);

      if (xFile != null) {
        widget.onCamera(xFile);
      }
    }
  }

  onGallery() async {
    List<XFile> pickedXFileList = await picker.pickMultiImage(limit: 3);
    widget.onGallery(pickedXFileList);
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
