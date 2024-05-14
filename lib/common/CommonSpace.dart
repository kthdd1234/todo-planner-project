import 'package:flutter/material.dart';

class CommonSpace extends StatelessWidget {
  CommonSpace({super.key, this.width, this.height});

  double? width, height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
