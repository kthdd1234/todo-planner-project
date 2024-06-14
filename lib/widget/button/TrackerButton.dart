import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/util/final.dart';
import 'package:project/widget/button/SpeedDialButton.dart';

class TrackerButton extends StatelessWidget {
  const TrackerButton({super.key});

  onTap() {
    log('클릭!');
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDialButton(
      icon: Icons.format_list_bulleted_rounded,
      activeBackgroundColor: red.s200,
      backgroundColor: indigo.s200,
      children: [],
    );
  }
}
