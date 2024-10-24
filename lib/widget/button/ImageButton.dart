import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';

class ImageButton extends StatelessWidget {
  ImageButton({
    super.key,
    required this.path,
    required this.text,
    required this.fontSize,
    required this.padding,
    required this.onTap,
    this.nameArgs,
  });

  String path, text;
  EdgeInsets padding;
  double fontSize;
  Map<String, String>? nameArgs;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/$path.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: padding,
        child: CommonText(
          text: text,
          color: Colors.white,
          fontSize: fontSize,
          nameArgs: nameArgs,
          isBold: true,
        ),
      ),
    );
  }
}
