import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonButton.dart';
import 'package:project/common/CommonCircle.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/common/CommonTextFormField.dart';
import 'package:project/etc/TodoSettingPage.dart';
import 'package:project/provider/CategoryProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/gridView/ColorGridView.dart';
import 'package:provider/provider.dart';

class CategorySettingPage extends StatefulWidget {
  CategorySettingPage({super.key, this.title});

  String? title;

  @override
  State<CategorySettingPage> createState() => _CategorySettingPageState();
}

class _CategorySettingPageState extends State<CategorySettingPage> {
  TextEditingController nameController = TextEditingController();
  String selectedColorName = red.colorName;

  @override
  Widget build(BuildContext context) {
    bool isNotEmpty = nameController.text != '';

    onAdd() {
      if (isNotEmpty) {
        //
      }
    }

    onEdit() {
      if (isNotEmpty) {
        //
      }
    }

    onChanged(String value) {
      setState(() {});
    }

    onCategoryName() {
      FocusScope.of(context).unfocus();
    }

    onColorName(String colorName) {
      setState(() => selectedColorName = colorName);
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: '카테고리 ${widget.title}',
          actions: [],
        ),
        body: Column(
          children: [
            Expanded(
              child: CommonContainer(
                outerPadding: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(text: '카테고리'),
                    CommonTextFormField(
                      autofocus: true,
                      controller: nameController,
                      hintText: '카테고리를 입력해주세요',
                      maxLength: 20,
                      onChanged: onChanged,
                      onEditingComplete: onCategoryName,
                    ),
                    CommonSpace(height: 20),
                    CategoryColor(
                      selectedColorName: selectedColorName,
                      onTap: onColorName,
                    )
                  ],
                ),
              ),
            ),
            CommonSpace(height: 10),
            CommonButton(
              text: widget.title ?? '',
              outerPadding: const EdgeInsets.symmetric(horizontal: 5),
              textColor: isNotEmpty ? Colors.white : Colors.grey,
              buttonColor: isNotEmpty ? buttonColor : Colors.grey.shade300,
              verticalPadding: 15,
              borderRadius: 100,
              onTap: onAdd,
            )
          ],
        ),
      ),
    );
  }
}

class CategoryColor extends StatelessWidget {
  CategoryColor({
    super.key,
    required this.selectedColorName,
    required this.onTap,
  });

  String selectedColorName;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TodoTitle(title: '색상'),
        CommonSpace(height: 20),
        ColorGridView(
          selectedColorName: selectedColorName,
          onTap: onTap,
        ),
      ],
    );
  }
}
