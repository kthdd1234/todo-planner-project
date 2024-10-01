import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/provider/ReloadProvider.dart';
import 'package:project/provider/UserInfoProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

class FontPage extends StatelessWidget {
  FontPage({super.key, required this.fontFamily});

  String fontFamily;

  @override
  Widget build(BuildContext context) {
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isReload = context.watch<ReloadProvider>().isReload;

    // UserBox? user = userRepository.user;
    // String? fontFamily = user.fontFamily ?? initFontFamily;
    // String fontName = getFontName(fontFamily);

    List<String> fontPreviewList = [
      "가나다라마바사아자차카타파하",
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      "abcdefghijklnmopqrstuvwxyz",
      "0123456789!@#%^&*()",
    ];

    onTap(String selectedFontFamily) async {
      userInfo.fontFamily = selectedFontFamily;
      await userMethod.updateUser(userInfo: userInfo);

      context.read<ReloadProvider>().setReload(!isReload);
      navigatorPop(context);
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '글씨체'),
        body: Column(
          children: [
            CommonContainer(
              innerPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
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
                                  color: isLight ? Colors.black : darkTextColor,
                                  fontWeight: isLight
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
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
