import 'package:flutter/material.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';

class TodoGroupTitle extends StatelessWidget {
  TodoGroupTitle({super.key, required this.title, required this.desc});

  String title, desc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: title, fontSize: 16),
          CommonSpace(height: 2),
          CommonText(text: desc, fontSize: 11, color: Colors.grey),
        ],
      ),
    );
  }
}
