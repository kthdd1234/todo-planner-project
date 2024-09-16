import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';

class StateIconPage extends StatelessWidget {
  const StateIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    stateIconList;
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '상태 아이콘'),
        body: Column(
            children: stateIconList
                .map((state) => CommonContainer(
                      outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(text: state.title),
                          const Row(children: [
                            //
                          ])
                        ],
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
