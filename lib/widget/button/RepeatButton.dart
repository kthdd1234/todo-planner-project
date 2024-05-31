import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';

class RepeatButton extends StatelessWidget {
  RepeatButton(
      {super.key,
      required this.text,
      required this.type,
      required this.selectedRepeat,
      required this.onTap});

  String text, type, selectedRepeat;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    //

    return Expanded(
      child: CommonButton(
        text: text,
        fontSize: 13,
        isBold: selectedRepeat == type,
        textColor: selectedRepeat == type ? Colors.white : grey.s400,
        buttonColor: selectedRepeat == type ? indigo.s200 : whiteBgBtnColor,
        verticalPadding: 10,
        borderRadius: 5,
        onTap: () => onTap(type),
      ),
    );
  }
}
