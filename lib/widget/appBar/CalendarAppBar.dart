import 'package:flutter/material.dart';
import 'package:project/widget/appBar/TaskAppBar.dart';

class CalendarAppBar extends StatelessWidget {
  const CalendarAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(children: [TitleDateTime()]),
    );
  }
}
