import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/user_box/user_box.dart';

class AnalyzeAppBar extends StatelessWidget {
  AnalyzeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [CommonText(text: '분석')],
    );
  }
}
