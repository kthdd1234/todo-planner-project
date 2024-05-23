import 'package:flutter/material.dart';
import 'package:project/body/todo/widget/todoGroupItem.dart';
import 'package:project/body/todo/widget/todoGroupTitle.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class TodoBody extends StatelessWidget {
  const TodoBody({super.key});

  @override
  Widget build(BuildContext context) {
    onTap() {}

    return Column(
      children: [
        CommonAppBar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              CommonContainer(
                child: Column(
                  children: [
                    TodoGroupTitle(
                      title: '📚국어',
                      desc: '매일 저녁 10분씩 읽기!',
                      color: green,
                    ),
                    TodoGroupItem(
                      id: '1',
                      name: '김동욱 연필통 모의고사 오답노트',
                      markType: itemMark.O,
                      memo: '오답노트 3번씩 반복해서 쓰기!',
                      color: green,
                      actionType: eItemActionMark,
                      todoType: eOneday,
                    ),
                    TodoGroupItem(
                      id: '2',
                      name: '비문학 독해 205P 문풀 채/오',
                      markType: itemMark.X,
                      color: green,
                      actionType: eItemActionMark,
                      isHighlight: true,
                      todoType: eRoutin,
                    ),
                    TodoGroupItem(
                      id: '3',
                      name: '문법 49P 문풀 채/오',
                      markType: itemMark.M,
                      actionType: eItemActionMark,
                      isHighlight: true,
                      color: green,
                      todoType: eOneday,
                    ),
                    TodoGroupItem(
                      id: '4',
                      name: '영단어 50개 외우기 + 복습',
                      markType: itemMark.T,
                      actionType: eItemActionMark,
                      memo: '1H 20M',
                      color: green,
                      todoType: eOneday,
                    ),
                    TodoGroupItem(
                      id: '5',
                      name: '영어독해 연습 27강 복습',
                      markType: itemMark.E,
                      actionType: eItemActionMark,
                      isShade50: true,
                      color: green,
                      todoType: eOneday,
                    ),
                    CommonButton(
                      text: '+ 할 일 추가',
                      verticalPadding: 15,
                      borderRadius: 7,
                      textColor: Colors.white,
                      buttonColor: buttonColor,
                      onTap: onTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
