// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';
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
    required this.uint8ListList,
    required this.onCamera,
    required this.onGallery,
  });

  List<Uint8List> uint8ListList;
  Function(Uint8List) onCamera;
  Function(List<Uint8List>) onGallery;

  @override
  State<ImageAddModalSheet> createState() => _ImageAddModalSheetState();
}

class _ImageAddModalSheetState extends State<ImageAddModalSheet> {
  onCamera() async {
    if (widget.uint8ListList.length > 2) {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '사진은 최대 3장까지\n추가할 수 있어요.',
          buttonText: '확인',
          height: 175,
          onTap: () => navigatorPop(context),
        ),
      );
    } else {
      XFile? xFile = await picker.pickImage(source: ImageSource.camera);
      Uint8List? uint8List = await xFile?.readAsBytes();

      if (uint8List != null) {
        widget.onCamera(uint8List);
      }
    }
  }

  onGallery() async {
    List<XFile> pickedXFileList = await picker.pickMultiImage(limit: 3);
    List<Uint8List> pickedUint8ListList = [];

    for (var xFile in pickedXFileList) {
      Uint8List uint8List = await xFile.readAsBytes();
      pickedUint8ListList.add(uint8List);
    }

    widget.onGallery(pickedUint8ListList);
  }

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      title: '사진 추가',
      height: 185,
      child: Row(
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
      ),
    );
  }
}
