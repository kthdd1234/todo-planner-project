import 'package:flutter/material.dart';
import 'package:project/util/constants.dart';

class CommonText extends StatelessWidget {
  CommonText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.isNotTr,
    this.isBold,
    this.nameArgs,
    this.onTap,
  });

  String text;
  Color? color;
  double? fontSize;
  bool? isNotTr, isBold;
  Map<String, String>? nameArgs;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? themeColor,
          fontSize: fontSize,
          fontWeight: isBold == true ? FontWeight.bold : FontWeight.w400,
        ),
      ),
    );
  }
}
