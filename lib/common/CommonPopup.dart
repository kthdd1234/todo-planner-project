import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';

class CommonPopup extends StatelessWidget {
  CommonPopup({
    super.key,
    this.title,
    required this.desc,
    required this.buttonText,
    required this.height,
    required this.onTap,
  });

  String? title;
  String desc, buttonText;
  double height;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(text: title!, fontSize: 16),
                InkWell(
                    onTap: () => navigatorPop(context),
                    child: const Icon(Icons.close_rounded, size: 20))
              ],
            )
          : null,
      shape: roundedRectangleBorder,
      backgroundColor: whiteBgBtnColor,
      content: SizedBox(
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
      ),
    );
  }
}
