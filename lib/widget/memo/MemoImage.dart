// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project/common/CommonImage.dart';

class MemoImage extends StatelessWidget {
  MemoImage({
    super.key,
    required this.uint8ListList,
    required this.onImage,
    this.length,
  });

  List<Uint8List> uint8ListList;
  int? length;
  Function(Uint8List) onImage;

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: length ?? 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: uint8ListList
          .map(
            (uint8List) => CommonImage(
              uint8List: uint8List,
              height: 150,
              onTap: onImage,
            ),
          )
          .toList(),
    );
  }
}
