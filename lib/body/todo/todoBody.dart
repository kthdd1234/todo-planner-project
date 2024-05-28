import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/body/todo/widget/todoGroupItem.dart';
import 'package:project/body/todo/widget/todoGroupTitle.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonContainer.dart';
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
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              CommonAppBar(),
              CommonContainer(
                outerPadding: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: '📚1초를 소홀히 하는 사람은 하루를 잃고 일생을 잃는다.',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              TodoContainer(),
              TodoContainer(),
              TodoContainer(),
              TodoContainer(),
            ],
          ),
        ),
      ],
    );
  }
}

class TodoContainer extends StatelessWidget {
  const TodoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: 7,
      innerPadding: 0,
      child: Column(
        children: [
          TodoGroupTitle(
            title: '📚독서',
            desc: '매일 저녁 10분씩 읽기!',
            color: blue,
          ),
          TodoGroupItem(
            id: '1',
            name: '김동욱 연필통 모의고사 오답노트',
            markType: itemMark.E,
            memo: '오답노트 3번씩 반복해서 쓰기!',
            color: blue,
            actionType: eItemActionMark,
            todoType: eOneday,
          ),
          TodoGroupItem(
            id: '2',
            name: '비문학 독해 205P 문풀 채/오',
            markType: itemMark.E,
            color: blue,
            actionType: eItemActionMark,
            isHighlight: true,
            todoType: eRoutin,
          ),
          TodoGroupItem(
            id: '3',
            name: '문법 49P 문풀 채/오',
            markType: itemMark.E,
            actionType: eItemActionMark,
            isHighlight: true,
            color: blue,
            todoType: eOneday,
          ),
          TodoGroupItem(
            id: '4',
            name: '영단어 50개 외우기 + 복습',
            markType: itemMark.E,
            actionType: eItemActionMark,
            memo: '1H 20M',
            color: blue,
            todoType: eOneday,
          ),
          CommonSpace(height: 15)
        ],
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