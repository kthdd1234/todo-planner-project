import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';

class CalendarAppBar extends StatelessWidget {
  const CalendarAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          CommonText(text: '2023년 7월', fontSize: 18),
        ],
      ),
    );
  }
}
