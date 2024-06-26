import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';

class LoadingPopup extends StatelessWidget {
  LoadingPopup({
    super.key,
    required this.text,
    required this.color,
    this.nameArgs,
    this.subText,
  });

  String text;
  Color color;
  String? subText;
  Map<String, String>? nameArgs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(strokeWidth: 3),
        CommonSpace(height: 10),
        CommonText(
          text: text,
          fontSize: 11,
          color: color,
          nameArgs: nameArgs,
        ),
        CommonSpace(height: 3),
        subText != null
            ? CommonText(
                text: subText!,
                fontSize: 11,
                color: color,
                nameArgs: nameArgs,
              )
            : const CommonNull(),
      ],
    );
  }
}
