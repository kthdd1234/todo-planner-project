import 'package:flutter/material.dart';
import 'package:project/util/func.dart';

class CommonSvgTag extends StatelessWidget {
  CommonSvgTag({
    super.key,
    required this.svgName,
    required this.svgWidth,
    required this.svgColor,
    required this.bgColor,
  });

  String svgName;
  double svgWidth;
  Color svgColor, bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5),
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
