import 'package:flutter/cupertino.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/widget/gridView/ColorGridView.dart';

class ColorModalSheet extends StatelessWidget {
  ColorModalSheet({
    super.key,
    required this.selectedColorName,
    required this.onTap,
  });

  String selectedColorName;
  Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      title: '색상',
      isBack: true,
      height: 400,
      child: CommonContainer(
        child: Center(
          child: ColorGridView(
            selectedColorName: selectedColorName,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
