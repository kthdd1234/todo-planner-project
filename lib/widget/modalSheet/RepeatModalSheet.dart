import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';

class RepeatModalSheet extends StatefulWidget {
  const RepeatModalSheet({super.key});

  @override
  State<RepeatModalSheet> createState() => _RepeatModalSheetState();
}

class _RepeatModalSheetState extends State<RepeatModalSheet> {
  String selectedRepeat = repeat.select;

  @override
  Widget build(BuildContext context) {
    onRepeat(String newValue) {
      setState(() => selectedRepeat = newValue);
    }

    onCompleted() {
      //
    }

    return CommonModalSheet(
      title: '반복',
      isBack: true,
      height: 500,
      child: Column(
        children: [
          Expanded(
            child: CommonContainer(
              child: Column(
                children: [
                  Row(
                    children: [
                      RepeatButton(
                        text: '날짜 지정',
                        type: repeat.select,
                        selectedRepeat: selectedRepeat,
                        onTap: onRepeat,
                      ),
                      CommonSpace(width: 5),
                      RepeatButton(
                        text: '매주',
                        type: repeat.everyWeek,
                        selectedRepeat: selectedRepeat,
                        onTap: onRepeat,
                      ),
                      CommonSpace(width: 5),
                      RepeatButton(
                        text: '매달',
                        type: repeat.everyMonth,
                        selectedRepeat: selectedRepeat,
                        onTap: onRepeat,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          CommonButton(
            text: '완료',
            textColor: Colors.white,
            buttonColor: buttonColor,
            outerPadding: const EdgeInsets.only(top: 15),
            verticalPadding: 15,
            borderRadius: 100,
            onTap: onCompleted,
          )
        ],
      ),
    );
  }
}

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
