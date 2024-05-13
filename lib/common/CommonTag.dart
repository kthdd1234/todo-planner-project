import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';

class CommonTag extends StatelessWidget {
  CommonTag({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(5),
        ),
        child: CommonText(
          text: text,
        ),
      ),
    );
  }
}
