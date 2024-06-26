import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/page/PremiumPage.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ImageButton.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
    String? appStoreLink = dotenv.env['APP_STORE_LINK'];
    String? playStoreLink = dotenv.env['PLAY_STORE_LINK'];

    Platform.isIOS
        ? Share.share(appStoreLink!, subject: '투두 플래너')
        : Share.share(playStoreLink!, subject: '투두 플래너');
  }

  onVersion() {
    //
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;

    List<SettingItemClass> settingItemList = [
      SettingItemClass(
        name: '프리미엄',
        svg: 'crown',
        onTap: onPremium,
        value: isPremium
            ? CommonSvgText(
                text: '구매 완료',
                textColor: textColor,
                fontSize: 14,
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
        name: '개인정보처리방침',
        svg: 'private',
        onTap: onPrivate,
      ),
      SettingItemClass(
        name: '앱 버전',
        svg: 'version',
        onTap: () {},
        value: CommonText(
          text: '$appVerstion ($appBuildNumber)',
          color: grey.original,
        ),
      ),
    ];

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '설정'),
        body: Column(
          children: settingItemList
              .map((item) => InkWell(
                    onTap: item.onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.5,
                        horizontal: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: whiteBgBtnColor,
                              borderRadius: BorderRadius.all(
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
                            color: textColor,
                          ),
                          const Spacer(),
                          item.value != null ? item.value! : const CommonNull()
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
