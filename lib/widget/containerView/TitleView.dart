import 'package:flutter/material.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonTag.dart';
import 'package:project/main.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/border/HorizentalBorder.dart';
import 'package:project/widget/modalSheet/TitleSettingModalSheet.dart';
import 'package:provider/provider.dart';

class TitleView extends StatefulWidget {
  TitleView({super.key, required this.groupInfo});

  GroupInfoClass groupInfo;

  @override
  State<TitleView> createState() => _TitleViewState();
}

class _TitleViewState extends State<TitleView> {
  onTitle() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TitleSettingModalSheet(groupInfo: widget.groupInfo),
    );
  }

  onOpen() async {
    widget.groupInfo.isOpen = !widget.groupInfo.isOpen;
    await groupMethod.updateGroup(
      gid: widget.groupInfo.gid,
      groupInfo: widget.groupInfo,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    String title = widget.groupInfo.name;
    bool isOpen = widget.groupInfo.isOpen;
    String colorName = widget.groupInfo.colorName;
    ColorClass color = getColorClass(colorName);

    return Column(
      children: [
        Row(
          children: [
            CommonTag(
              text: title,
              isNotTr: true,
              isBold: !isLight,
              textColor: isLight ? color.original : color.s200,
              bgColor: isLight ? color.s50 : darkButtonColor,
              onTap: onTitle,
            ),
            const Spacer(),
            InkWell(
              onTap: onOpen,
              child: svgAsset(
                name: '${isOpen ? 'open' : 'close'}-light',
                width: 20,
                color: color.s200,
              ),
            ),
            CommonSpace(width: 2)
          ],
        ),
        isOpen
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: HorizentalBorder(colorName: colorName),
              )
            : const CommonNull(),
      ],
    );
  }
}
