import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/page/categorySettingPage.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';

class CategoryModalSheet extends StatelessWidget {
  const CategoryModalSheet({super.key});

  onAddCategory(context, title) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => CategorySettingPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      title: '카테고리',
      isBack: true,
      height: 500,
      child: Column(
        children: [
          Expanded(
            child: CommonContainer(
              child: GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 50,
                ),
                children: [
                  CommonButton(
                    text: '운동',
                    textColor: blue.s300,
                    buttonColor: blue.s50,
                    verticalPadding: 15,
                    borderRadius: 7,
                    onTap: () {},
                  ),
                  CommonButton(
                    text: '공부',
                    textColor: red.s300,
                    buttonColor: red.s50,
                    verticalPadding: 15,
                    borderRadius: 7,
                    onTap: () {},
                  ),
                  CommonButton(
                    text: '독서',
                    textColor: teal.s300,
                    buttonColor: teal.s50,
                    verticalPadding: 15,
                    borderRadius: 7,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          CommonButton(
            text: '카테고리 추가',
            textColor: Colors.white,
            buttonColor: buttonColor,
            outerPadding: const EdgeInsets.only(top: 15),
            verticalPadding: 15,
            borderRadius: 7,
            onTap: () => onAddCategory(context, '추가'),
          )
        ],
      ),
    );
  }
}
