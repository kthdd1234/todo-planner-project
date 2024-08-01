import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/page/PremiumPage.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/ReloadProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class FontPage extends StatefulWidget {
  const FontPage({super.key});

  @override
  State<FontPage> createState() => _FontPageState();
}

class _FontPageState extends State<FontPage> {
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isReload = context.watch<ReloadProvider>().isReload;
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    UserBox? user = userRepository.user;
    String? fontFamily = user.fontFamily ?? initFontFamily;
    String fontName = getFontName(fontFamily);

    List<String> fontPreviewList = [
      "가나다라마바사아자차카타파하",
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      "abcdefghijklnmopqrstuvwxyz",
      "0123456789!@#%^&*()",
    ];

    onTap(String selectedFontFamily) async {
      if (isPremium) {
        user.fontFamily = selectedFontFamily;
        await user.save();

        context.read<ReloadProvider>().setReload(!isReload);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertPopup(
            height: 175,
            buttonText: '프리미엄 구매 페이지로 이동',
            desc: '프리미엄 구매 시\n글씨체를 변경 할 수 있어요',
            onTap: () => movePage(
              context: context,
              page: const PremiumPage(),
            ),
          ),
        );
      }
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '글씨체'),
        body: Column(
          children: [
            CommonContainer(
              innerPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: fontPreviewList
                        .map((text) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                text,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: fontFamily,
                                    color:
                                        isLight ? Colors.black : darkTextColor,
                                    fontWeight: isLight
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            CommonSpace(height: 10),
            Expanded(
              child: CommonContainer(
                innerPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: ListView(
                  children: fontFamilyList
                      .map((item) => InkWell(
                            onTap: () => onTap(item['fontFamily']!),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['name']!.tr(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              fontFamily == item['fontFamily']!
                                                  ? isLight
                                                      ? Colors.black
                                                      : darkTextColor
                                                  : Colors.grey,
                                          fontFamily: item['fontFamily']!,
                                          fontWeight:
                                              fontFamily == item['fontFamily']!
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                      fontFamily == item['fontFamily']!
                                          ? Icon(
                                              Icons.task_alt_rounded,
                                              size: 16,
                                              color: isLight
                                                  ? Colors.black
                                                  : darkTextColor,
                                            )
                                          : const CommonNull(),
                                    ],
                                  ),
                                ),
                                Divider(
                                    color: isLight ? grey.s300 : grey.s400,
                                    thickness: 0.1)
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
