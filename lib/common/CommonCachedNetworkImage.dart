import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/main.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';

class CommonCachedNetworkImage extends StatelessWidget {
  CommonCachedNetworkImage({
    super.key,
    required this.cacheKey,
    required this.imageUrl,
    required this.height,
    required this.onTap,
    this.radious,
    this.width,
    this.fontSize,
  });

  String cacheKey, imageUrl;
  double height;
  Function() onTap;
  double? width, radious, fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radious ?? 5),
        child: CachedNetworkImage(
          cacheKey: cacheKey,
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: grey.s200,
            child: Center(
              child: CommonText(
                text: '이미지 로드 중...',
                fontSize: fontSize ?? 12,
                color: grey.original,
              ),
            ),
          ),
          errorWidget: (context, url, error) {
            return Container(
              color: grey.s200,
              child: Center(
                child: CommonText(
                  text: '이미지 불러오기 실패',
                  fontSize: 12,
                  color: grey.original,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
