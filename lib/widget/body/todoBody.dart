import 'package:flutter/material.dart';
import 'package:project/common/CommonAppBar.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgButton.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/common/CommonText.dart';
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/image/test.png',
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        CommonSpace(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(text: '📚숲과 별이 만날 때'),
                            CommonSpace(height: 3),
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
                        CommonTag(
                          text: '할 일 3',
                          tagColor: tagIndigo,
                          fontSize: 10,
                          isBold: true,
                        ),
                        CommonSpace(width: 5),
                        CommonTag(
                          text: '습관 2',
                          tagColor: tagIndigo,
                          fontSize: 10,
                          isBold: true,
                        ),
                      ],
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
