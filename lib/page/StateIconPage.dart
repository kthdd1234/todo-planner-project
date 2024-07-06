import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';

class StateIconPage extends StatelessWidget {
  const StateIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> eList = ['E'];
    List<String> oList = ['O'];
    List<String> xList = ['X'];
    List<String> mList = ['M'];
    List<String> tList = ['T'];

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '상태 아이콘'),
        body: Column(
          children: [
            CommonContainer(
              outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(text: '기본 상태'),
                  Row(
                    children: [],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
