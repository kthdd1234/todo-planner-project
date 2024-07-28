import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/page/PremiumPage.dart';
import 'package:project/page/StateIconPage.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/appBar/SettingAppBar.dart';
import 'package:project/widget/button/ImageButton.dart';
import 'package:project/widget/modalSheet/ThemeModalSheet.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const SettingAppBar(), ContentView(isLight: isLight)],
      ),
    );
  }
}

class ContentView extends StatefulWidget {
  ContentView({super.key, required this.isLight});

  bool isLight;

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

  onTheme(String theme) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeModalSheet(title: '화면 테마', theme: theme),
    );
  }

  onWidgetTheme(String widgetTheme) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => ThemeModalSheet(title: '위젯 테마', theme: widgetTheme),
    );
    setState(() {});
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

  onValue(text) {
    return CommonSvgText(
      text: text,
      fontSize: 13,
      textColor: widget.isLight ? textColor : Colors.white,
      svgColor: widget.isLight ? textColor : Colors.white,
      svgName: 'dir-right',
      svgWidth: 6,
      svgLeft: 6,
      svgDirection: SvgDirectionEnum.right,
    );
  }

  onMarkIcon() {
    List<String> markList = ['E2', 'O', 'X', 'M', 'T'];

    return Row(
      children: [
        Row(
          children: markList
              .map((state) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: svgAsset(
                      name: 'mark-$state',
                      width: 11,
                      color: widget.isLight ? textColor : Colors.white,
                    ),
                  ))
              .toList(),
        ),
        svgAsset(
          name: 'dir-right',
          width: 6,
          color: widget.isLight ? textColor : Colors.white,
        ),
      ],
    );
  }

  onStateWeek() {
    //
  }

  onStateIcon() {
    movePage(context: context, page: const StateIconPage());
  }

  onInputTask() {
    //
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    String theme = context.watch<ThemeProvider>().theme;
    String widgetTheme = userRepository.user.widgetTheme ?? 'light';

    List<SettingItemClass> settingItemList = [
      SettingItemClass(
        name: '프리미엄',
        svg: 'crown',
        onTap: onPremium,
        value: isPremium
            ? CommonSvgText(
                text: '구매 완료',
                textColor: widget.isLight ? textColor : darkTextColor,
                fontSize: 14,
                isBold: !widget.isLight,
                svgName: 'premium-badge',
                svgWidth: 16,
                svgDirection: SvgDirectionEnum.left,
              )
            : ImageButton(
                path: 't-23',
                text: '광고 제거',
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                fontSize: 12,
                onTap: onPremium,
              ),
      ),
      SettingItemClass(
        name: '화면 테마',
        svg: 'theme',
        value: onValue(widget.isLight ? '밝은 테마' : '어두운 테마'),
        onTap: () => onTheme(theme),
      ),
      SettingItemClass(
        name: '위젯 테마',
        svg: 'widget',
        value: onValue(widgetTheme == 'light' ? '밝은 테마' : '어두운 테마'),
        onTap: () => onWidgetTheme(widgetTheme),
      ),
      // SettingItemClass(
      //   name: '상태 아이콘',
      //   svg: 'premium-state-icon',
      //   value: onMarkIcon(),
      //   onTap: onStateIcon,
      // ),
      // SettingItemClass(
      //   name: '한 주의 시작',
      //   svg: 'start-week',
      //   value: onValue('일요일'),
      //   onTap: onStatWeek,
      // ),
      // SettingItemClass(
      //   name: '할 일, 루틴 입력 후 동작',
      //   svg: 'input',
      //   value: onValue('연속 입력'),
      //   onTap: onInputTask,
      // ),
      SettingItemClass(
        name: '앱 리뷰 작성',
        svg: 'review',
        onTap: onReview,
      ),
      SettingItemClass(
        name: '앱 공유',
        svg: 'share',
        onTap: onShare,
      ),
      SettingItemClass(
        name: '카카오톡 고객센터 문의',
        svg: 'inquire',
        onTap: onInquire,
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
          color: widget.isLight ? grey.original : darkTextColor,
          isBold: !widget.isLight,
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
                            color: widget.isLight
                                ? whiteBgBtnColor
                                : darkSvgBgColor,
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
                          color: widget.isLight ? textColor : darkTextColor,
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
