import 'package:flutter/material.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalItem.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonOutlineInputField.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/model/group_box/group_box.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/listView/ColorListView.dart';
import 'package:provider/provider.dart';

class TitleSettingModalSheet extends StatefulWidget {
  TitleSettingModalSheet({super.key, this.groupBox});

  GroupBox? groupBox;

  @override
  State<TitleSettingModalSheet> createState() => _TitleSettingModalSheetState();
}

class _TitleSettingModalSheetState extends State<TitleSettingModalSheet> {
  String selectedColorName = '남색';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.groupBox != null) {
      controller.text = widget.groupBox!.name;
      selectedColorName = widget.groupBox!.colorName;
    }

    super.initState();
  }

  onColor(String colorName) {
    setState(() => selectedColorName = colorName);
  }

  onEditingComplete() async {
    DateTime now = DateTime.now();

    if (widget.groupBox == null) {
      String newGroupId = uuid();

      groupRepository.updateGroup(
        key: newGroupId,
        group: GroupBox(
          createDateTime: now,
          id: newGroupId,
          name: controller.text,
          colorName: selectedColorName,
          isOpen: true,
        ),
      );

      // userRepository.user.groupOrderList?.add({'id': newGroupId, 'list': []});
    } else {
      widget.groupBox!.name = controller.text;
      widget.groupBox!.colorName = selectedColorName;

      await widget.groupBox!.save();
    }

    navigatorPop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CommonModalSheet(
        title: '그룹 ${widget.groupBox == null ? '추가' : '수정'}',
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
                onTap: () {},
                child: ColorListView(
                  selectedColorName: selectedColorName,
                  onColor: onColor,
                ),
              ),
              CommonSpace(height: 17.5),
              CommonOutlineInputField(
                controller: controller,
                hintText: '제목을 입력해주세요',
                selectedColor: isLight
                    ? getColorClass(selectedColorName).s200
                    : getColorClass(selectedColorName).s300,
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
