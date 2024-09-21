import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';

class CommonSegmented extends StatelessWidget {
  CommonSegmented({
    super.key,
    required this.selectedSegment,
    required this.children,
    required this.onSegmentedChanged,
  });

  SegmentedTypeEnum selectedSegment;
  Map<SegmentedTypeEnum, Widget> children;

  Function(SegmentedTypeEnum? type) onSegmentedChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoSlidingSegmentedControl(
            backgroundColor: Colors.white,
            thumbColor: selectedColor,
            groupValue: selectedSegment,
            children: children,
            onValueChanged: onSegmentedChanged,
          ),
        ),
      ],
    );
  }
}
