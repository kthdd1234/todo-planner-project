import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';

class NativeAdWidget extends StatefulWidget {
  NativeAdWidget({super.key, required this.isLight});

  bool isLight;

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;

  loadNativeAd() async {
    nativeAd = NativeAd(
      adUnitId: getAdId('native'),
      listener: NativeAdListener(
        onAdLoaded: (adLoaded) {
          log('$adLoaded loaded~~~!!');
          nativeAdIsLoaded = true;
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          log('$NativeAd failed to load: $error');
          nativeAdIsLoaded = false;
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor:
            widget.isLight ? whiteBgBtnColor : darkNotSelectedBgColor,
        cornerRadius: 5.0,
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: widget.isLight ? textColor : darkTextColor,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: widget.isLight ? textColor : darkTextColor,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: widget.isLight ? textColor : darkTextColor,
        ),
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          backgroundColor: textColor,
          size: 16.0,
        ),
      ),
    )..load();
  }

  @override
  void initState() {
    loadNativeAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: const EdgeInsets.fromLTRB(7, 0, 7, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: '광고',
            fontSize: 12,
            isBold: true,
            color: widget.isLight ? textColor : darkTextColor,
          ),
          CommonSpace(height: 10),
          SizedBox(
            width: double.maxFinite,
            height: 320,
            child: nativeAdIsLoaded
                ? AdWidget(ad: nativeAd!)
                : const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
