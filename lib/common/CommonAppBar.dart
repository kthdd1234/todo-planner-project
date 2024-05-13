import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarTitle(),
        AppBarCalendar(),
      ],
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonText(text: '2024년 5월 13일'),
      ],
    );
  }
}

class AppBarCalendar extends StatelessWidget {
  const AppBarCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
