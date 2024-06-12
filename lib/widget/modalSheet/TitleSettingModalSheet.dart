import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalItem.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonOutlineInputField.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/modalSheet/ColorModalsheet.dart';

class TitleSettingModalSheet extends StatefulWidget {
  TitleSettingModalSheet({
    super.key,
    required this.title,
    required this.colorName,
    required this.onCompleted,
  });

  String title, colorName;
  Function(String title, String colorName) onCompleted;

  @override
  State<TitleSettingModalSheet> createState() => _TitleSettingModalSheetState();
}

class _TitleSettingModalSheetState extends State<TitleSettingModalSheet> {
  String selectedColorName = '남색';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.title;
    selectedColorName = widget.colorName;

    super.initState();
  }

  onColor() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ColorModalSheet(
        selectedColorName: selectedColorName,
        onTap: (String colorName) {
          setState(() => selectedColorName = colorName);
          navigatorPop(context);
        },
      ),
    );
  }

  onEditingComplete() {
    widget.onCompleted(controller.text, selectedColorName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '제목 수정',
        height: 210,
        child: CommonContainer(
          innerPadding: const EdgeInsets.only(
            left: 15,
            top: 0,
            right: 15,
            bottom: 0,
          ),
          child: ListView(
            children: [
              CommonModalItem(
                title: '색상',
                onTap: onColor,
                child: CommonTag(
                  text: getColorClass(selectedColorName).colorName,
                  textColor: getColorClass(selectedColorName).original,
                  bgColor: getColorClass(selectedColorName).s50,
                  onTap: onColor,
                ),
              ),
              CommonSpace(height: 17.5),
              CommonOutlineInputField(
                hintText: '제목을 입력해주세요',
                controller: controller,
                onSuffixIcon: onEditingComplete,
                onEditingComplete: onEditingComplete,
                onChanged: (_) => setState(() {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
