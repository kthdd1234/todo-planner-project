import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/body/todo/widget/todoItem.dart';
import 'package:project/body/todo/widget/todoTitle.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonImage.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TodoBody extends StatelessWidget {
  const TodoBody({super.key});

  @override
  Widget build(BuildContext context) {
    onTap() {}

    return Column(
      children: [
        CommonAppBar(),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              MemoContainer(),
              TodoContainer(),
              // TodoContainer(),
              // TodoContainer(),
              // TodoContainer(),
            ],
          ),
        ),
      ],
    );
  }
}

class MemoContainer extends StatelessWidget {
  const MemoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: 7,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 10,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          CommonText(
            text: '큰 목표를 이루고 싶으면 허락을 구하지 마라',
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}

class TodoContainer extends StatelessWidget {
  const TodoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CommonContainer(
        outerPadding: 7,
        innerPadding: 0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                width: 10,
                height: 345,
                decoration: BoxDecoration(
                  color: blue.s50,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  CommonSpace(height: 20),
                  TodoItem(
                    id: '1',
                    name: '김동욱 연필통 모의고사 오답노트',
                    markType: itemMark.O,
                    memo: '오답노트 3번씩 반복해서 쓰기!',
                    color: blue,
                    actionType: eItemActionMark,
                    todoType: eOneday,
                  ),
                  TodoItem(
                    id: '2',
                    name: '비문학 독해 205P 문풀 채/오',
                    markType: itemMark.X,
                    color: blue,
                    actionType: eItemActionMark,
                    isHighlight: true,
                    todoType: eRoutin,
                  ),
                  TodoItem(
                    id: '3',
                    name: '문법 49P 문풀 채/오',
                    markType: itemMark.M,
                    actionType: eItemActionMark,
                    isHighlight: true,
                    color: blue,
                    todoType: eOneday,
                  ),
                  TodoItem(
                    id: '4',
                    name: '비문학 독해 88p ~ 99p',
                    markType: itemMark.T,
                    actionType: eItemActionMark,
                    memo: '1H 20M',
                    color: blue,
                    todoType: eOneday,
                  ),
                  TodoItem(
                    id: '4',
                    name: '모의고사 문제풀이',
                    markType: itemMark.E,
                    actionType: eItemActionMark,
                    color: blue,
                    todoType: eOneday,
                  ),
                  CommonSpace(height: 20)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // CommonSvgText(
              //   text: '메모가 없어요',
              //   fontSize: 14,
              //   svgName: 'pencil',
              //   svgWidth: 12,
              //   svgDirection: SvgDirectionEnum.left,
              //   textColor: grey.original,
              //   svgColor: grey.s400,
              // )
              // CommonImage(unit8List: , height: 280),