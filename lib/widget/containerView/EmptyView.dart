import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';

class AddView extends StatelessWidget {
  AddView({
    super.key,
    required this.colorName,
    required this.onTap,
  });

  String colorName;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  CommonText(text: '+ 할 일 추가', color: grey.original),
                  const Spacer(),
                  svgAsset(name: 'mark-d', width: 20, color: grey.s400),
                ],
              ),
            ),
          ),
          HorizentalBorder(colorName: colorName),
        ],
      ),
    );
  }
}
