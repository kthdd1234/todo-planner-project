import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';

class SpeedDialButton extends StatelessWidget {
  SpeedDialButton({
    super.key,
    required this.icon,
    required this.activeBackgroundColor,
    required this.backgroundColor,
    required this.children,
  });

  IconData icon;
  Color activeBackgroundColor, backgroundColor;
  List<SpeedDialChild> children;
  Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: icon,
      spacing: 3,
      buttonSize: const Size(47, 47),
      childrenButtonSize: const Size(47, 47),
      spaceBetweenChildren: 7,
      label: CommonText(text: '할 일 추가'),
      iconTheme: const IconThemeData(color: darkButtonColor, size: 30),
      activeIcon: Icons.close,
      activeBackgroundColor: activeBackgroundColor,
      elevation: 0,
      visible: true,
      overlayOpacity: 0.4,
      overlayColor: Colors.black87,
      backgroundColor: backgroundColor,
      children: children,
    );
  }
}
