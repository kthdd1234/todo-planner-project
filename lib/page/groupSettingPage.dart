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

class GroupSettingPage extends StatefulWidget {
  const GroupSettingPage({super.key});

  @override
  State<GroupSettingPage> createState() => _GroupSettingPageState();
}

class _GroupSettingPageState extends State<GroupSettingPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    onNext() {
      Navigator.pushNamed(context, 'group-item-list-page');
    }

    onName() {
      //
    }

    onDesc() {
      //
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: '1. 그룹 설정',
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
                        ),
                        CommonText(
                          text: ' *',
                          color: Colors.red,
                          isNotTr: true,
                        )
                      ],
                    ),
                    CommonTextFormField(
                      controller: nameController,
                      hintText: '이름을 입력해주세요',
                      maxLength: 20,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: onName,
                    ),
                    CommonSpace(height: 20),
                    CommonText(
                      text: '한줄 코멘트',
                      fontSize: 14,
                      color: themeColor,
                    ),
                    CommonTextFormField(
                      controller: descController,
                      maxLength: 25,
                      hintText: '목표, 다짐, 명언 등 자유롭게 입력해주세요',
                      textInputAction: TextInputAction.next,
                      onEditingComplete: onDesc,
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

    // CommonTextFormField(
    //                         controller: todoController,
    //                         autofocus: true,
    //                         hintText: '할 일을 입력해주세요',
    //                         maxLength: 20,
    //                         onEditingComplete: onTodo,
    //                       )
