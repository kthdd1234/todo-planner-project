import 'package:flutter/cupertino.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/func.dart';

class ModalButton extends StatelessWidget {
  ModalButton({
    super.key,
    required this.svgName,
    required this.actionText,
    required this.color,
    required this.onTap,
  });

  String svgName;
  String actionText;
  Color color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CommonContainer(
        onTap: onTap,
        radius: 7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgAsset(name: svgName, width: 25, color: color),
            CommonSpace(height: 10),
            CommonText(text: actionText, color: color)
          ],
        ),
      ),
    );
  }
}
