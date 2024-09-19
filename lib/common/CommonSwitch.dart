import 'package:flutter/cupertino.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:provider/provider.dart';

class CommonSwitch extends StatelessWidget {
  CommonSwitch({
    super.key,
    required this.activeColor,
    required this.value,
    required this.onChanged,
  });

  Color activeColor;
  bool value;
  Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return SizedBox(
      height: 25,
      child: CupertinoSwitch(
        trackColor: isLight ? null : darkNotSelectedBgColor,
        activeColor: activeColor,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
