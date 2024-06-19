import 'package:flutter/material.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/final.dart';

class CommonEmpty extends StatelessWidget {
  CommonEmpty({
    super.key,
    required this.height,
    required this.line_1,
    required this.line_2,
  });

  double height;
  String line_1, line_2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonText(text: line_1, color: grey.original),
          CommonSpace(height: 2),
          CommonText(text: line_2, color: grey.original),
        ],
      ),
    );
  }
}
