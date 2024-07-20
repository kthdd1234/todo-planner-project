import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/selectedDateTimeProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:provider/provider.dart';

class TodayButton extends StatefulWidget {
  const TodayButton({super.key});

  @override
  State<TodayButton> createState() => _TodayButtonState();
}

class _TodayButtonState extends State<TodayButton> {
  onPress() {
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SpeedDial(
        onPress: onPress,
        label: CommonText(
          text: '오늘로 이동',
          color: Colors.white,
          isBold: true,
          fontSize: 18,
        ),
        buttonSize: const Size(47, 47),
        childrenButtonSize: const Size(47, 47),
        spaceBetweenChildren: 7,
        elevation: 0,
        visible: true,
        overlayOpacity: 0.4,
        overlayColor: Colors.black87,
        backgroundColor: isLight ? blue.s200 : darkButtonColor,
      ),
    );
  }
}
