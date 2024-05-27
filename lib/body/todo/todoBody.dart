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
        CommonAppBar(),
        Expanded(
          child: CarouselSlider(
            items: [
              TodoContainer(),
              TodoContainer(),
              TodoContainer(),
              TodoContainer(),
            ],
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
            ),
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
    return Column(
      children: [
        CommonContainer(
          outerPadding: 7,
          child: Column(
            children: [
              // CommonSvgText(
              //   text: '메모가 없어요',
              //   fontSize: 14,
              //   svgName: 'edit-pencil',
              //   svgWidth: 12,
              //   svgDirection: SvgDirectionEnum.left,
              //   textColor: grey.original,
              //   svgColor: grey.s400,
              // )
              CommonImage(unit8List: unit8List, height: height),
            ],
          ),
        ),
        Expanded(
          child: CommonContainer(
            outerPadding: 7,
            innerPadding: 0,
            child: ListView(
              shrinkWrap: true,
              children: [
                // TodoGroupTitle(
                //   title: '할 일 리스트',
                //   desc: '매일 저녁 10분씩 읽기!',
                //   color: indigo,
                // ),
                TodoGroupItem(
                  id: '1',
                  name: '김동욱 연필통 모의고사 오답노트',
                  markType: itemMark.M,
                  memo: '오답노트 3번씩 반복해서 쓰기!',
                  color: green,
                  actionType: eItemActionMark,
                  todoType: eOneday,
                ),
                TodoGroupItem(
                  id: '2',
                  name: '비문학 독해 205P 문풀 채/오',
                  markType: itemMark.T,
                  color: red,
                  actionType: eItemActionMark,
                  isHighlight: true,
                  todoType: eRoutin,
                ),
                TodoGroupItem(
                  id: '3',
                  name: '문법 49P 문풀 채/오',
                  markType: itemMark.X,
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
                  color: purple,
                  todoType: eOneday,
                ),
                TodoGroupItem(
                  id: '5',
                  name: '영어독해 연습 27강 복습',
                  markType: itemMark.E,
                  actionType: eItemActionMark,
                  isShade50: true,
                  color: orange,
                  todoType: eOneday,
                ),
                TodoGroupItem(
                  id: '5',
                  name: '영어독해 연습 27강 복습',
                  markType: itemMark.E,
                  actionType: eItemActionMark,
                  isShade50: true,
                  color: orange,
                  todoType: eOneday,
                ),
                TodoGroupItem(
                  id: '5',
                  name: '영어독해 연습 27강 복습',
                  markType: itemMark.E,
                  actionType: eItemActionMark,
                  isShade50: true,
                  color: orange,
                  todoType: eOneday,
                ),
                TodoGroupItem(
                  id: '5',
                  name: '영어독해 연습 27강 복습',
                  markType: itemMark.E,
                  actionType: eItemActionMark,
                  isShade50: true,
                  color: orange,
                  todoType: eOneday,
                ),
                CommonSpace(height: 100)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
