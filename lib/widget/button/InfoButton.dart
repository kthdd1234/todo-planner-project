import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/page/HistoryPage.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/SpeedDialButton.dart';

class InfoButton extends StatefulWidget {
  const InfoButton({super.key});

  @override
  State<InfoButton> createState() => _InfoButtonState();
}

class _InfoButtonState extends State<InfoButton> {
  onHistory() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => HistoryPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDialButton(
      icon: Icons.format_list_bulleted_rounded,
      activeBackgroundColor: red.s200,
      backgroundColor: indigo.s200,
      children: [
        speedDialChildButton(
          svg: 'timeline',
          lable: '히스토리',
          color: blue,
          onTap: onHistory,
        )
      ],
    );
  }
}
