import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/body/todo/widget/todoGroupItem.dart';
import 'package:project/body/todo/widget/todoGroupTitle.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/page/ItemSettingPage.dart';
import 'package:project/provider/initGroupProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

class GroupItemListPage extends StatelessWidget {
  const GroupItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    InitGroupProvider group = context.watch<InitGroupProvider>();
    ColorClass color = getColor(group.colorName);

    onAdd() {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => ItemSettingPage(isEdit: false),
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
                  children: [
                    TodoGroupTitle(
                      title: group.name,
                      desc: group.desc != '' ? group.desc : 'ㅡ',
                      color: color,
                      isShowAction: false,
                    ),
                    group.todoList.isNotEmpty
                        ? Column(
                            children: group.todoList
                                .map((todo) => TodoGroupItem(
                                      id: todo.id,
                                      name: todo.name,
                                      todoType: todo.type,
                                      color: color,
                                      isHighlight: todo.isHighlighter,
                                      memo: todo.memo,
                                      actionType: eItemActionEdit,
                                    ))
                                .toList(),
                          )
                        : Column(
                            children: [
                              CommonSpace(height: 20),
                              Column(
                                children: [
                                  CommonText(
                                    text: '추가된 할 일이 없어요',
                                    color: Colors.grey,
                                  ),
                                  CommonText(
                                    text: '아래의 버튼을 눌러 할 일을 추가해보세요',
                                    color: Colors.grey,
                                  ),
                                  CommonSpace(height: 10),
                                  svgAsset(
                                    name: 'arrow-down',
                                    width: 15,
                                    color: Colors.grey.shade300,
                                  )
                                ],
                              ),
                              CommonSpace(height: 20),
                            ],
                          ),
                    CommonButton(
                      text: '+ 할 일 추가',
                      outerPadding: const EdgeInsets.only(top: 0),
                      verticalPadding: 15,
                      borderRadius: 7,
                      textColor: Colors.white,
                      buttonColor: buttonColor,
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
              buttonColor: buttonColor,
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
