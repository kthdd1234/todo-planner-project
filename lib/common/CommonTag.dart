import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';

class CommonTag extends StatelessWidget {
  CommonTag({
    super.key,
    required this.text,
    required this.tagColor,
    this.isBold,
    this.fontSize,
  });

  String text;
  TagColorClass tagColor;
  bool? isBold;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
          color: tagColor.bgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: CommonText(
          text: text,
          color: tagColor.textColor,
          isBold: isBold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
