import 'package:flutter/material.dart';
import 'package:project/util/class.dart';
import 'package:project/util/func.dart';

class CommonSvgTag extends StatelessWidget {
  CommonSvgTag({
    super.key,
    required this.svgName,
    required this.svgWidth,
    required this.tagColor,
  });

  String svgName;
  double svgWidth;
  TagColorClass tagColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
          color: tagColor.bgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: svgAsset(
          name: svgName,
          width: svgWidth,
          color: tagColor.textColor,
        ),
      ),
    );
  }
}
