import 'package:flutter/material.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:project/widget/modalSheet/TaskTitleModalSheet.dart';
import 'package:project/widget/popup/MarkPopup.dart';

class TaskBody extends StatelessWidget {
  const TaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAppBar(),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              MemoContainer(),
              TaskContainer(),
              // TaskContainer(),
              // TaskContainer(),
              // TaskContainer(),
            ],
          ),
        ),
      ],
    );
  }
}

class MemoContainer extends StatelessWidget {
  const MemoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      innerPadding: EdgeInsets.all(20),
      outerPadding: 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: '큰 목표를 이루고 싶으면 허락을 구하지 마라',
            fontSize: 15,
          ),
          //
        ],
      ),
    );
  }
}

class TaskContainer extends StatefulWidget {
  const TaskContainer({super.key});

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  onTitle() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TaskTitleModalSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: 7,
      innerPadding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTag(
            text: '할 일, 루틴 리스트',
            textColor: indigo.original,
            bgColor: indigo.s50,
            onTap: onTitle,
          ),
          CommonSpace(height: 5),
          TaskItem(
            id: '1',
            name: '김동욱 연필통 모의고사 오답노트',
            markType: itemMark.O,
            memo: '오답노트 3번씩 반복해서 쓰기!',
            color: blue,
            task: tRoutin,
          ),
          TaskItem(
            id: '2',
            name: '비문학 독해 205P 문풀 채/오',
            markType: itemMark.X,
            color: red,
            isHighlight: true,
            task: tRoutin,
          ),
          TaskItem(
            id: '3',
            name: '문법 49P 문풀 채/오',
            markType: itemMark.M,
            isHighlight: true,
            color: orange,
            task: tTodo,
          ),
          TaskItem(
            id: '4',
            name: '비문학 독해 88p ~ 99p',
            markType: itemMark.T,
            memo: '1H 20M',
            color: purple,
            task: tTodo,
          ),
          TaskItem(
            id: '4',
            name: '모의고사 문제풀이',
            markType: itemMark.E,
            color: teal,
            task: tRoutin,
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  TaskItem({
    super.key,
    required this.id,
    required this.name,
    required this.color,
    required this.task,
    this.markType,
    this.isHighlight,
    this.memo,
  });

  String id, name;
  TaskClass task;
  String? memo, markType;
  bool? isHighlight;
  ColorClass color;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  wAction({
    required String svgName,
    required Color actionColor,
    required double width,
    required Function() onTap,
  }) {
    return Expanded(
      flex: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 5),
        child: CommonSvgButton(
          width: width,
          name: svgName,
          color: actionColor,
          onTap: onTap,
        ),
      ),
    );
  }

  onMark() {
    showDialog(
      context: context,
      builder: (context) => MarkPopup(taskId: ''),
    );
  }

  onMore() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => CommonModalSheet(
        title: widget.name,
        height: 200,
        child: Row(
          children: [
            ModalButton(
              svgName: 'highlighter',
              actionText: '수정하기',
              color: textColor,
              onTap: () {
                //
              },
            ),
            CommonSpace(width: 5),
            ModalButton(
              svgName: 'remove',
              actionText: '삭제하기',
              color: red.s200,
              onTap: () {
                //
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: IntrinsicHeight(
        child: Row(
          children: [
            VerticalBorder(color: widget.color.s50),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: onMore,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: widget.name,
                      textAlign: TextAlign.start,
                      highlightColor:
                          widget.isHighlight == true ? widget.color.s50 : null,
                    ),
                    CommonSpace(height: 5),
                    CommonText(
                      text: widget.task.name,
                      color: grey.original,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
            ),
            wAction(
              svgName: 'mark-${widget.markType}',
              width: 25,
              actionColor: widget.color.s100,
              onTap: onMark,
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalBorder extends StatelessWidget {
  const VerticalBorder({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 5,
        height: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(2),
            bottom: Radius.circular(2),
          ),
        ),
      ),
    );
  }
}

              // CommonImage(unit8List: , height: 280),
                  // Padding(
                //   padding: const EdgeInsets.only(left: 0),
                //   child: Container(
                //     width: 5,
                //     height: 385,
                //     decoration: BoxDecoration(
                //       color: blue.s50,
                //       borderRadius: BorderRadius.circular(2),
                //     ),
                //   ),
                // ),

                    // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 20,
                  //     top: 15,
                  //     bottom: 10,
                  //     right: 20,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                        // CommonTag(
                        //   text: '📚독서',
                        //   textColor: blue.original,
                        //   bgColor: blue.s50,
                        //   onTap: () {},
                        // ),
                  //       Icon(
                  //         Icons.keyboard_arrow_down_rounded,
                  //         color: blue.s100,
                  //         size: 30,
                  //       )
                  //     ],
                  //   ),
                  // ),