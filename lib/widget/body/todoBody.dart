import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonDivider.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonSvgTag.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';

class TodoBody extends StatelessWidget {
  const TodoBody({super.key});

  @override
  Widget build(BuildContext context) {
    onTap() {
      //
    }

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 15),
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(5),
                            //     child: Image.asset(
                            //       'assets/image/test.png',
                            //       width: 35,
                            //       height: 35,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(text: '📚국어', fontSize: 16),
                                CommonSpace(height: 2),
                                CommonText(
                                  text: '매일 저녁 10분씩 읽기!',
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            CommonSvgButton(
                              name: 'edit-pencil',
                              width: 18,
                              color: Colors.grey.shade400,
                              onTap: onTap,
                            ),
                            CommonSpace(width: 13),
                            CommonSvgButton(
                              name: 'calendar-check',
                              width: 20,
                              color: Colors.grey.shade400,
                              onTap: onTap,
                            ),
                            CommonSpace(width: 13),
                            CommonSvgButton(
                              name: 'timeline',
                              width: 20,
                              color: Colors.grey.shade400,
                              onTap: onTap,
                            ),
                          ],
                        ),
                      ],
                    ),
                    CommonDivider(color: Colors.indigo.shade50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CommonCircle(),
                            CommonText(text: '김동욱 연필통 모의고사 오답노트')
                          ],
                        ),
                        CommonCheckBox(
                          markColor: Colors.green.shade100,
                          markSvg: 'circle-mark',
                        ),
                      ],
                    ),
                    CommonDivider(color: Colors.indigo.shade50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          CommonCircle(),
                          CommonText(
                            text: '비문학 독해 205P 문풀 채/오',
                            highlightColor: Colors.indigo.shade50,
                          )
                        ]),
                        CommonCheckBox(
                          markColor: Colors.red.shade100,
                          markSvg: 'delete-mark',
                        ),
                      ],
                    ),
                    CommonDivider(color: Colors.indigo.shade50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: '문법 49P 문풀 채/오',
                          highlightColor: Colors.indigo.shade50,
                        ),
                        CommonCheckBox(
                          markColor: Colors.orange.shade100,
                          markSvg: 'tri-mark',
                        ),
                      ],
                    ),
                    CommonDivider(color: Colors.indigo.shade50),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: '영단어 50개 외우기 + 복습',
                            highlightColor: Colors.indigo.shade50,
                          ),
                          CommonCheckBox(
                            markColor: Colors.purple.shade100,
                            markSvg: 'next-mark',
                          ),
                        ]),
                    CommonDivider(color: Colors.indigo.shade50),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(text: '영어독해 연습 27강 복습'),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: CommonSvgButton(
                              name: 'select-square-2',
                              width: 27,
                              color: Colors.indigo.shade50,
                              onTap: onTap,
                            ),
                          ),
                        ]),
                    CommonSpace(height: 20),
                    CommonButton(
                      text: '+ 할 일을 추가하세요',
                      verticalPadding: 15,
                      borderRadius: 7,
                      textColor: Colors.white,
                      buttonColor: Colors.indigo.shade200,
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

class CommonCheckBox extends StatelessWidget {
  CommonCheckBox({
    super.key,
    required this.markColor,
    required this.markSvg,
  });

  String markSvg;
  Color markColor;

  @override
  Widget build(BuildContext context) {
    onTap() {
      //
    }

    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Row(
        children: [
          CommonSvgButton(
            name: markSvg,
            width: 28,
            color: markColor,
            onTap: onTap,
          ),
          CommonSpace(width: 15),
          CommonSvgButton(
            name: 'note',
            width: 28,
            color: markColor,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

// 습관 svg
// 만 표시(할 일 svg는 표시 x)
