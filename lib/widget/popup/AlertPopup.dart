import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonPopup.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';

class AlertPopup extends StatelessWidget {
  AlertPopup({
    super.key,
    required this.desc,
    required this.buttonText,
    required this.height,
    required this.onTap,
  });

  double height;
  String desc, buttonText;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CommonPopup(
      insetPaddingHorizontal: 20,
      height: height,
      child: Column(
        children: [
          CommonContainer(child: CommonText(text: desc)),
          CommonButton(
            text: buttonText,
            outerPadding: const EdgeInsets.only(top: 15),
            textColor: Colors.white,
            buttonColor: buttonColor,
            verticalPadding: 15,
            borderRadius: 7,
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
