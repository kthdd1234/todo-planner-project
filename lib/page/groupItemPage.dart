import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/body/todo/widget/todoGroupTitle.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';

class GroupItemPage extends StatelessWidget {
  const GroupItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    onAdd() {}

    onCompleted() {
      //
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: '2. 할 일 추가',
          centerTitle: true,
          actions: [],
        ),
        body: Column(
          children: [
            Expanded(
              child: CommonContainer(
                outerPadding: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TodoGroupTitle(
                          title: '📚독서',
                          desc: '하루라도 책을 읽지 않으면 입안에 가시가 돋는다',
                        ),
                      ],
                    ),
                    CommonButton(
                      text: '+ 할 일을 추가하세요',
                      outerPadding: const EdgeInsets.only(top: 20),
                      verticalPadding: 15,
                      borderRadius: 7,
                      textColor: Colors.white,
                      buttonColor: Colors.indigo.shade200,
                      onTap: onAdd,
                    ),
                  ],
                ),
              ),
            ),
            CommonSpace(height: 10),
            CommonButton(
              text: '완료',
              outerPadding: const EdgeInsets.symmetric(horizontal: 5),
              textColor: Colors.white,
              buttonColor: themeColor,
              verticalPadding: 15,
              borderRadius: 100,
              onTap: onCompleted,
            )
          ],
        ),
      ),
    );
  }
}
