import 'package:flutter/material.dart';
import 'package:project/common/CommonModalSheet.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/page/PremiumPage.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ModalButton.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class AppStartIndexModalSheet extends StatelessWidget {
  AppStartIndexModalSheet({super.key, required this.appStartIndex});

  int appStartIndex;

  @override
  Widget build(BuildContext context) {
    int seletedIdx = context.watch<BottomTabIndexProvider>().seletedIdx;
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    return CommonModalSheet(
      title: '앱 시작 화면',
      height: 185,
      child: Row(
        children: getBnClassList(isLight, seletedIdx)
            .map(
              (bn) => bn.index != 3
                  ? ModalButton(
                      innerPadding: const EdgeInsets.only(right: 5),
                      svgName: bn.svgName,
                      actionText: bn.name,
                      color: bn.index == appStartIndex
                          ? Colors.white
                          : isLight
                              ? textColor
                              : darkTextColor,
                      isBold: bn.index == appStartIndex,
                      bgColor: bn.index == appStartIndex
                          ? isLight
                              ? indigo.s300
                              : textColor
                          : isLight
                              ? Colors.white
                              : darkContainerColor,
                      onTap: () async {
                        if (isPremium == false) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertPopup(
                              desc: '프리미엄 구매 시\n화면을 설정할 수 있어요',
                              buttonText: '프리미엄 구매 페이지로 이동',
                              height: 175,
                              onTap: () => movePage(
                                context: context,
                                page: const PremiumPage(),
                              ),
                            ),
                          );
                        } else {
                          UserBox? user = userRepository.user;
                          user.appStartIndex = bn.index;

                          await user.save();
                          navigatorPop(context);
                        }
                      },
                    )
                  : const CommonNull(),
            )
            .toList(),
      ),
    );
  }
}
