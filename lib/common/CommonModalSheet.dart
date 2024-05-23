import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';

class CommonModalSheet extends StatelessWidget {
  CommonModalSheet({
    super.key,
    required this.title,
    required this.height,
    required this.child,
  });

  String title;
  double height;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      height: height,
      isRadius: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CommonText(text: title, fontSize: 15),
              CommonSpace(height: 15),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
