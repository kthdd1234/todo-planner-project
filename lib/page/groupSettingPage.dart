import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';

class GroupSettingPage extends StatelessWidget {
  const GroupSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: '1. 그룹 설정',
          centerTitle: true,
          actions: [],
        ),
        body: CommonContainer(
          outerPadding: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.info_outline,
                      size: 12,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  CommonText(
                    text: '사진은 앱 내 저장 공간에 저장돼요',
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ],
              ),
              // 사진
              Row(
                children: [
                  CommonText(
                    text: '그룹 이름',
                    fontSize: 14,
                    color: themeColor,
                    isBold: true,
                  ),
                  const Text(' *', style: TextStyle(color: Colors.red))
                ],
              ),
              TextFormField(
                autofocus: true,
                maxLength: 20,
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: themeColor,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    hintText: '이름을 입력해주세요. (필수)',
                    hintStyle: const TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
