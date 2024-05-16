import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonText.dart';

class CommonButton extends StatelessWidget {
  CommonButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    required this.verticalPadding,
    required this.borderRadius,
  });

  Color textColor, buttonColor;
  double verticalPadding, borderRadius;
  String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: CommonText(
                text: text,
                color: textColor,
                isBold: true,
              )),
        ),
      ],
    );
  }
}
