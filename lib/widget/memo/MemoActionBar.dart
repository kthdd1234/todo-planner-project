import 'package:flutter/material.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/containerView/MemoView.dart';
import 'package:project/widget/memo/MemoBackground.dart';

class MemoActionBar extends StatelessWidget {
  MemoActionBar({
    super.key,
    required this.containerColor,
    required this.isLight,
    required this.onImage,
    required this.onAlign,
    required this.onClock,
    required this.onSave,
  });

  Color containerColor;
  bool isLight;
  Function() onImage, onAlign, onClock, onSave;

  action({
    required String name,
    required double width,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: svgAsset(name: name, width: width, color: darkButtonColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: containerColor,
      child: CustomPaint(
        painter: MemoBackground(
          isLight: isLight,
          color: orange.s50,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 2,
          ),
          child: Row(
            children: [
              action(name: 'gallery', width: 20, onTap: onImage),
              CommonSpace(width: 3),
              action(name: 'align-left', width: 24, onTap: onAlign),
              action(name: 'clock', width: 21, onTap: onClock),
              const Spacer(),
              action(name: 'mark-O', width: 18, onTap: onSave),
            ],
          ),
        ),
      ),
    );
  }
}
