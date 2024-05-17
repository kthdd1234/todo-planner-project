import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/common/CommonTextFormField.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';

class GroupSettingPage extends StatelessWidget {
  const GroupSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    onNext() {
      Navigator.pushNamed(context, 'group-item-page');
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: '1. 그룹 설정',
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
                        CommonText(
                          text: '그룹 이름',
                          fontSize: 14,
                          color: themeColor,
                          isBold: true,
                        ),
                        CommonText(text: ' *', color: Colors.red, isNotTr: true)
                      ],
                    ),
                    CommonTextFormField(
                      hintText: '이름을 입력해주세요',
                      maxLength: 20,
                      textInputAction: TextInputAction.next,
                    ),
                    CommonSpace(height: 20),
                    CommonText(
                      text: '한줄 코멘트',
                      fontSize: 14,
                      color: themeColor,
                      isBold: true,
                    ),
                    CommonTextFormField(
                      maxLength: 25,
                      hintText: '목표, 다짐, 명언 등 자유롭게 입력해주세요',
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
            ),
            CommonSpace(height: 10),
            CommonButton(
              text: '다음',
              outerPadding: const EdgeInsets.symmetric(horizontal: 5),
              textColor: Colors.white,
              buttonColor: themeColor,
              verticalPadding: 15,
              borderRadius: 100,
              onTap: onNext,
            )
          ],
        ),
      ),
    );
  }
}
