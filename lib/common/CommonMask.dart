import 'package:flutter/material.dart';

class CommonMask extends StatelessWidget {
  CommonMask({super.key, this.width, this.height, this.opacity});

  double? width, height, opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(opacity ?? 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
