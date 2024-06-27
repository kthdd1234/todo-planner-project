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
  const ThemeModalSheet({super.key});

  @override
  State<ThemeModalSheet> createState() => _ThemeModalSheetState();
}

class _ThemeModalSheetState extends State<ThemeModalSheet> {
  button({
    required String theme,
    required String target,
    required String name,
  }) {
    return ModalButton(
      svgName: target,
      actionText: name,
      isBold: theme == target,
      color: theme == target ? Colors.white : grey.original,
      bgColor: theme == target ? textColor : Colors.white,
      onTap: () async {
        UserBox user = userRepository.user;

        context.read<ThemeProvider>().setThemeValue(target);
        user.theme = target;

        await user.save();
        navigatorPop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String theme = context.watch<ThemeProvider>().themeValue();

    return CommonModalSheet(
      title: '화면 테마',
      height: 190,
      child: Row(
        children: [
          button(theme: theme, target: 'light', name: '기본 테마'),
          CommonSpace(width: 5),
          button(theme: theme, target: 'dark', name: '어두운 테마'),
        ],
      ),
    );
  }
}
