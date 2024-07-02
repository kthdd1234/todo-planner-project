import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonText.dart';

class HistoryMemo extends StatelessWidget {
  HistoryMemo({super.key, required this.isLight, required this.memo});

  bool isLight;
  String? memo;

  @override
  Widget build(BuildContext context) {
    return memo != null
        ? Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CommonText(
              text: memo!,
              textAlign: TextAlign.start,
              isBold: !isLight,
            ),
          )
        : const CommonNull();
  }
}
