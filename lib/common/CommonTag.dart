import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';

class CommonTag extends StatelessWidget {
  CommonTag({
    super.key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.onTap,
    this.isBold,
    this.fontSize,
  });

  String text;
  Color textColor, bgColor;
  bool? isBold;
  double? fontSize;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: CommonText(
          text: text,
          color: textColor,
          isBold: isBold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
