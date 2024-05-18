import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';

class ItemSettingPage extends StatelessWidget {
  const ItemSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    wTitle(String title) {
      return CommonText(
        text: title,
        fontSize: 14,
        isBold: true,
      );
    }

    onSave() {
      //
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '할 일 추가'),
        body: Column(
          children: [
            Expanded(
              child: CommonContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wTitle('할 일'),
                    wTitle('분류'),
                    wTitle('컬러'),
                    wTitle('형광펜'),
                    wTitle('메모'),
                  ],
                ),
              ),
            ),
            CommonButton(
              text: '추가하기',
              outerPadding: EdgeInsets.only(top: 15),
              textColor: Colors.white,
              buttonColor: themeColor,
              verticalPadding: 15,
              borderRadius: 10,
              onTap: onSave,
            ),
          ],
        ),
      ),
    );
  }
}
