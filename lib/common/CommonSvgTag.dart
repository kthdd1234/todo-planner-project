import 'package:flutter/material.dart';
import 'package:project/util/func.dart';

class CommonSvgTag extends StatelessWidget {
  CommonSvgTag({
    super.key,
    required this.svgName,
    required this.svgWidth,
    required this.svgColor,
    required this.bgColor,
    this.padding,
    this.height,
  });

  String svgName;
  double svgWidth;
  Color svgColor, bgColor;
  EdgeInsets? padding;
  double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: svgAsset(
          name: svgName,
          width: svgWidth,
          color: svgColor,
        ),
      ),
    );
  }
}
