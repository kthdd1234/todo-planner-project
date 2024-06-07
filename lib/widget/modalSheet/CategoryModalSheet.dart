import 'package:flutter/material.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/etc/categorySettingPage.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';

class CategoryModalSheet extends StatefulWidget {
  CategoryModalSheet({
    super.key,
    required this.initCategoryId,
    required this.onTap,
  });

  String initCategoryId;
  Function(CategoryClass) onTap;

  @override
  State<CategoryModalSheet> createState() => _CategoryModalSheetState();
}

class _CategoryModalSheetState extends State<CategoryModalSheet> {
  String categoryId = '';

  @override
  void initState() {
    categoryId = widget.initCategoryId;
    super.initState();
  }

  onAddCategory(title) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => CategorySettingPage(title: title),
      ),
    );
  }

  categoryButton(String id, String name, ColorClass color) {
    onTap() {
      navigatorPop(context);
      widget.onTap(CategoryClass(
        id: id,
        name: name,
        colorName: color.colorName,
      ));
    }

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          CommonButton(
            text: name,
            textColor: color.s300,
            buttonColor: color.s50,
            verticalPadding: 15,
            borderRadius: 7,
            onTap: onTap,
          ),
          categoryId == id ? const SelectionMask() : const CommonNull(),
        ],
      ),
    );
  }

  actionButton(String type) {
    return CommonButton(
      text: '추가',
      textColor: Colors.white,
      buttonColor: buttonColor,
      outerPadding: const EdgeInsets.only(top: 15),
      verticalPadding: 15,
      borderRadius: 100,
      onTap: () => onAddCategory('추가'),
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
              child: Column(
                children: [
                  GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 50,
                    ),
                    children: [
                      categoryButton('exercise', '🏃운동', blue),
                      categoryButton('study', '📝공부', red),
                      categoryButton('reading', '📚독서', teal),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actionButton('add')
        ],
      ),
    );
  }
}

class SelectionMask extends StatelessWidget {
  const SelectionMask({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        const Positioned(
          right: 0,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.check_rounded, size: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
