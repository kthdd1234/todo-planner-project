import 'package:flutter/material.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/ReloadProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:provider/provider.dart';

class SettingAppBar extends StatelessWidget {
  const SettingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    context.watch<ReloadProvider>().isReload;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: CommonText(text: '더보기', fontSize: 18, isBold: !isLight),
    );
  }
}
