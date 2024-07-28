import 'package:flutter/material.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:provider/provider.dart';

class ThemeModalSheet extends StatefulWidget {
  ThemeModalSheet({super.key, required this.title, required this.theme});

  String title, theme;

  @override
  State<ThemeModalSheet> createState() => _ThemeModalSheetState();
}

class _ThemeModalSheetState extends State<ThemeModalSheet> {
  button({
    required String id,
    required String theme,
    required String name,
  }) {
    bool isSelected = theme == id;
    bool isLight = theme == 'light';
    bool isScreen = widget.title == '화면 테마';
    Color buttonTextColor = {
      '화면 테마': isSelected
          ? Colors.white
          : isLight
              ? textColor
              : grey.s400,
      '위젯 테마': isSelected ? Colors.white : textColor,
    }[widget.title]!;
    Color buttonBgColor = {
      '화면 테마': isSelected
          ? isLight
              ? indigo.s300
              : textColor
          : isLight
              ? Colors.white
              : darkContainerColor,
      '위젯 테마': isSelected ? indigo.s300 : Colors.white,
    }[widget.title]!;

    return ModalButton(
      svgName: id,
      actionText: name,
      isBold: isSelected
          ? true
          : isScreen
              ? !isLight
              : false,
      color: buttonTextColor,
      bgColor: buttonBgColor,
      onTap: () async {
        UserBox user = userRepository.user;

        if (isScreen) {
          context.read<ThemeProvider>().setThemeValue(id);
          user.theme = id;
        } else {
          user.widgetTheme = id;
        }

        await user.save();
        navigatorPop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      title: widget.title,
      height: 190,
      child: Row(
        children: [
          button(theme: widget.theme, id: 'light', name: '밝은 테마'),
          CommonSpace(width: 5),
          button(theme: widget.theme, id: 'dark', name: '어두운 테마'),
        ],
      ),
    );
  }
}
