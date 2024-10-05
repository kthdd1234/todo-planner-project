import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/page/FontPage.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/page/PremiumPage.dart';
import 'package:project/page/BackgroundPage.dart';
import 'package:project/page/ProfilePage.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/ReloadProvider.dart';
import 'package:project/provider/UserInfoProvider.dart';
import 'package:project/provider/bottomTabIndexProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/appBar/SettingAppBar.dart';
import 'package:project/widget/button/ImageButton.dart';
import 'package:project/widget/modalSheet/AppStartIndexModalSheet.dart';
import 'package:project/widget/modalSheet/LanguageModalSheet.dart';
import 'package:project/widget/modalSheet/ThemeModalSheet.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SettingAppBar(), ContentView()],
      ),
    );
  }
}

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  String appVerstion = '';
  String appBuildNumber = '';

  @override
  void initState() {
    getInfo() async {
      Map<String, dynamic> appInfo = await getAppInfo();

      appVerstion = appInfo['appVerstion'];
      appBuildNumber = appInfo['appBuildNumber'];

      setState(() {});
    }

    getInfo();
    super.initState();
  }

  onPremium() {
    movePage(context: context, page: const PremiumPage());
  }

  onPrivate() async {
    Uri url = Uri(
      scheme: 'https',
      host: 'nettle-dill-e85.notion.site',
      path: 'c065423d61494b74b4d284ebdf6ec532',
      queryParameters: {'pvs': '4'},
    );

    await canLaunchUrl(url) ? await launchUrl(url) : throw 'launchUrl error';
  }

  onReview() {
    InAppReview inAppReview = InAppReview.instance;
    String? appleId = dotenv.env['APPLE_ID'];
    String? androidId = dotenv.env['ANDROID_ID'];

    inAppReview.openStoreListing(
      appStoreId: appleId,
      microsoftStoreId: androidId,
    );
  }

  onShare() {
    Platform.isIOS
        ? Share.share(APP_STORE_LINK, subject: '투두트래커')
        : Share.share('', subject: '투두트래커');
  }

  onInquire() async {
    Uri url = Uri(
      scheme: 'https',
      host: 'open.kakao.com',
      path: 'o/szS9jCzg',
    );

    await canLaunchUrl(url) ? await launchUrl(url) : print('err');
  }

  onVersion() async {
    Uri url = Uri(
      scheme: 'https',
      host: 'apps.apple.com',
      path:
          'app/%ED%88%AC%EB%91%90-%ED%94%8C%EB%9E%98%EB%84%88-todo-planner/id6504663551',
    );

    await canLaunchUrl(url) ? await launchUrl(url) : print('err');
  }

  onBackground() {
    movePage(context: context, page: const BackgroundPage());
  }

  onLanguage() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageModalSheet(),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ReloadProvider>().isReload;

    String locale = context.locale.toString();
    bool isLight = context.read<ThemeProvider>().isLight;
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    String loginType = userInfo.loginType;
    String screenTheme = userInfo.theme;
    String widgetTheme = userInfo.widgetTheme;
    String background = userInfo.background;
    String fontFamily = userInfo.fontFamily;
    int appStartIndex = userInfo.appStartIndex;

    onScreenTheme() {
      showModalBottomSheet(
        context: context,
        builder: (context) => ThemeModalSheet(
          title: '화면 테마',
          theme: screenTheme,
          onTap: (selectedTheme) async {
            userInfo.theme = selectedTheme;

            context.read<ThemeProvider>().setThemeValue(selectedTheme);
            await userMethod.updateUser(userInfo: userInfo);

            navigatorPop(context);
          },
        ),
      );
    }

    onWidgetTheme() async {
      await showModalBottomSheet(
        context: context,
        builder: (context) => ThemeModalSheet(
          title: '위젯 테마',
          theme: widgetTheme,
          onTap: (selectedTheme) async {
            userInfo.widgetTheme = selectedTheme;
            await userMethod.updateUser(userInfo: userInfo);

            navigatorPop(context);
          },
        ),
      );
      setState(() {});
    }

    onFont() {
      movePage(context: context, page: FontPage(fontFamily: fontFamily));
    }

    onUser() {
      movePage(context: context, page: ProfilePage());
    }

    onValue(String text, bool? isNotTr) {
      return CommonSvgText(
        text: text,
        fontSize: 13,
        textColor: isLight ? textColor : Colors.white,
        svgColor: isLight ? textColor : Colors.white,
        svgName: 'dir-right',
        svgWidth: 6,
        svgLeft: 6,
        isNotTr: isNotTr,
        svgDirection: SvgDirectionEnum.right,
      );
    }

    onStart(bool isPremium) async {
      isPremium == false
          ? movePage(context: context, page: const PremiumPage())
          : await showModalBottomSheet(
              context: context,
              builder: (context) => AppStartIndexModalSheet(),
            );
    }

    List<SettingItemClass> settingItemList = [
      SettingItemClass(
        name: '프리미엄',
        svg: 'crown',
        onTap: onPremium,
        value: isPremium
            ? onValue('구매 완료', null)
            : ImageButton(
                path: 't-4',
                text: '광고 제거',
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                fontSize: 11,
                onTap: onPremium,
              ),
      ),
      SettingItemClass(
        name: '프로필',
        svg: 'user',
        value: onValue('${authButtonInfo[loginType]!['name']}', null),
        onTap: onUser,
      ),
      SettingItemClass(
        name: '화면 테마',
        svg: 'mode',
        value: onValue(screenTheme == 'light' ? '밝은 테마' : '어두운 테마', null),
        onTap: onScreenTheme,
      ),
      SettingItemClass(
        name: '위젯 테마',
        svg: 'widget',
        value: onValue(widgetTheme == 'light' ? '밝은 테마' : '어두운 테마', null),
        onTap: onWidgetTheme,
      ),
      SettingItemClass(
        name: '글씨체',
        svg: 'font',
        value: onValue(getFontName(fontFamily), null),
        onTap: onFont,
      ),
      SettingItemClass(
        name: '언어',
        svg: 'language',
        value: onValue(getLocaleName(locale), true),
        onTap: onLanguage,
      ),
      SettingItemClass(
        name: '앱 시작 화면',
        svg: 'premium-start',
        value: onValue(getBnName(appStartIndex), null),
        onTap: () => onStart(isPremium),
      ),
      SettingItemClass(
        name: '앱 배경',
        svg: 'premium-background',
        value: onValue(
            backroundClassList
                .expand((list) => list)
                .toList()
                .firstWhere((item) => item.path == background)
                .name,
            true),
        onTap: onBackground,
      ),
      SettingItemClass(
        name: '앱 공유',
        svg: 'share',
        onTap: onShare,
      ),
      SettingItemClass(
        name: '앱 리뷰',
        svg: 'review',
        onTap: onReview,
      ),
      SettingItemClass(
        name: '개인정보처리방침',
        svg: 'private',
        onTap: onPrivate,
      ),
      SettingItemClass(
        name: '앱 버전',
        svg: 'version',
        onTap: onVersion,
        value: CommonText(
          text: '$appVerstion ($appBuildNumber)',
          color: isLight ? grey.original : darkTextColor,
          isBold: !isLight,
          isNotTr: true,
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: settingItemList
            .map((item) => InkWell(
                  onTap: item.onTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.5),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isLight ? Colors.white : darkSvgBgColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: svgAsset(name: item.svg, width: 17),
                        ),
                        CommonSpace(width: 15),
                        CommonText(
                          text: item.name,
                          isBold: true,
                          color: isLight ? textColor : darkTextColor,
                        ),
                        const Spacer(),
                        item.value != null ? item.value! : const CommonNull()
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
