import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';

class ReportAppBar extends StatelessWidget {
  ReportAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          CommonText(text: '주간 리포트', fontSize: 18),
        ],
      ),
    );
  }
}
