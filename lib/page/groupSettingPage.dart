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
import 'package:project/page/ItemSettingPage.dart';
import 'package:project/provider/initGroupProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class GroupSettingPage extends StatefulWidget {
  const GroupSettingPage({super.key});

  @override
  State<GroupSettingPage> createState() => _GroupSettingPageState();
}

class _GroupSettingPageState extends State<GroupSettingPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String selectedColorName = tagIndigo.colorName!;

  @override
  Widget build(BuildContext context) {
    bool isEmptyGroupName = nameController.text == '';

    onNextPage() {
      if (!isEmptyGroupName) {
        context.read<InitGroupProvider>().changeGroupInfo(
              newId: const Uuid().v4(),
              newName: nameController.text,
              newDesc: descController.text,
              newColorName: selectedColorName,
            );
        Navigator.pushNamed(context, 'group-item-list-page');
      }
    }

    onGroupName() {
      FocusScope.of(context).nextFocus();
    }

    onGroupDesc() {
      FocusScope.of(context).unfocus();
    }

    onColorName(String colorName) {
      setState(() => selectedColorName = colorName);
    }

    return CommonBackground(
      child: CommonScaffold(
        resizeToAvoidBottomInset: false,
        appBarInfo: AppBarInfoClass(
          title: '1. 그룹 설정',
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
                    Row(
                      children: [
                        CommonText(text: '그룹 이름', fontSize: 14),
                        CommonText(text: ' *', color: Colors.red, isNotTr: true)
                      ],
                    ),
                    CommonTextFormField(
                      autofocus: true,
                      controller: nameController,
                      hintText: '이름을 입력해주세요',
                      maxLength: 20,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: onGroupName,
                    ),
                    CommonSpace(height: 20),
                    CommonText(text: '한줄 코멘트', fontSize: 14, color: themeColor),
                    CommonTextFormField(
                      controller: descController,
                      maxLength: 30,
                      hintText: '목표, 다짐, 명언 등 자유롭게 입력해주세요',
                      textInputAction: TextInputAction.next,
                      onEditingComplete: onGroupDesc,
                    ),
                    CommonSpace(height: 20),
                    GroupColor(
                      selectedColorName: selectedColorName,
                      onTap: onColorName,
                    )
                  ],
                ),
              ),
            ),
            CommonSpace(height: 10),
            CommonButton(
              text: '다음',
              outerPadding: const EdgeInsets.symmetric(horizontal: 5),
              textColor: isEmptyGroupName ? Colors.grey : Colors.white,
              buttonColor: isEmptyGroupName ? Colors.grey.shade300 : themeColor,
              verticalPadding: 15,
              borderRadius: 100,
              onTap: onNextPage,
            )
          ],
        ),
      ),
    );
  }
}

class GroupColor extends StatelessWidget {
  GroupColor({super.key, required this.selectedColorName, required this.onTap});

  String selectedColorName;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          TodoTitle(title: '컬러'),
          CommonSpace(height: 20),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            children: tagColorList
                .map(
                  (tagColor) => GestureDetector(
                    onTap: () => onTap(tagColor.colorName!),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CommonCircle(color: tagColor.groupColor!, size: 40),
                        selectedColorName == tagColor.colorName
                            ? svgAsset(
                                name: 'mark-V',
                                width: 20,
                                color: Colors.white,
                              )
                            : const CommonNull(),
                      ],
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
