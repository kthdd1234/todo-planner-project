import 'package:flutter/material.dart';
import 'package:project/body/todo/widget/todoGroupItem.dart';
import 'package:project/body/todo/widget/todoGroupTitle.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/common/CommonTextFormField.dart';
import 'package:project/page/ItemSettingPage.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';

class GroupItemListPage extends StatefulWidget {
  const GroupItemListPage({super.key});

  @override
  State<GroupItemListPage> createState() => _GroupItemListPageState();
}

class _GroupItemListPageState extends State<GroupItemListPage> {
  @override
  Widget build(BuildContext context) {
    onAdd() {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => const ItemSettingPage(),
        ),
      );
    }

    onSave() {
      //
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: '2. 할 일 리스트',
        ),
        body: Column(
          children: [
            Expanded(
              child: CommonContainer(
                outerPadding: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TodoGroupTitle(
                      title: '📚독서',
                      desc: '하루라도 책을 읽지 않으면 입안에 가시가 돋는다',
                      isShowAction: false,
                    ),
                    CommonDivider(color: Colors.indigo.shade50),
                    // TodoGroupItem(
                    //   text: '매일 밤 20분 책 읽기',
                    //   materialColor: Colors.green,
                    //   isShowMark: false,
                    // ),
                    CommonButton(
                      text: '+ 할 일을 추가하세요',
                      outerPadding: const EdgeInsets.only(top: 0),
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
              onTap: onSave,
            )
          ],
        ),
      ),
    );
  }
}

// 1. 아이템 이름 설정
// 2. 분류(할 일 또는 목표), 컬러, 메모, 형광펜
