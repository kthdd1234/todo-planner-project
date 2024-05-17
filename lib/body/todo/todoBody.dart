import 'package:flutter/material.dart';
import 'package:project/body/todo/widget/todoGroupBtnList.dart';
import 'package:project/body/todo/widget/todoGroupItem.dart';
import 'package:project/body/todo/widget/todoGroupTitle.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/util/final.dart';

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // TodoGroupImage(),
                        TodoGroupTitle(title: '📚국어', desc: '매일 저녁 10분씩 읽기!'),
                        const TodoGroupBtnList(),
                      ],
                    ),
                    TodoGroupItem(
                      text: '김동욱 연필통 모의고사 오답노트',
                      markType: itemMark.O,
                      memo: '오답노트 3번씩 반복해서 쓰기!',
                      materialColor: Colors.green,
                      isContinue: true,
                    ),
                    TodoGroupItem(
                      text: '비문학 독해 205P 문풀 채/오',
                      markType: itemMark.X,
                      materialColor: Colors.red,
                      isHighlight: true,
                      isContinue: true,
                    ),
                    TodoGroupItem(
                      text: '문법 49P 문풀 채/오',
                      markType: itemMark.M,
                      isHighlight: true,
                      materialColor: Colors.orange,
                    ),
                    TodoGroupItem(
                      text: '영단어 50개 외우기 + 복습',
                      markType: itemMark.T,
                      memo: '1H 20M',
                      materialColor: Colors.purple,
                    ),
                    TodoGroupItem(
                      text: '영어독해 연습 27강 복습',
                      markType: itemMark.E,
                      isShade50: true,
                      materialColor: Colors.indigo,
                    ),
                    CommonButton(
                      text: '+ 할 일을 추가하세요',
                      outerPadding: const EdgeInsets.only(top: 20),
                      verticalPadding: 15,
                      borderRadius: 7,
                      textColor: Colors.white,
                      buttonColor: Colors.indigo.shade200,
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
