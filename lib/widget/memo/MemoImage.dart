import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/common/CommonCachedNetworkImage.dart';
import 'package:project/common/CommonNull.dart';

class MemoImage extends StatelessWidget {
  MemoImage({super.key, required this.imageUrl, required this.onTap});

  String? imageUrl;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == '') return const CommonNull();

    return CommonCachedNetworkImage(
      cacheKey: imageUrl!,
      imageUrl: imageUrl!,
      width: double.infinity,
      height: 300,
      onTap: onTap,
    );
  }
}
