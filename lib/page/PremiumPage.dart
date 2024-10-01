// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/themeProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ImageButton.dart';
import 'package:project/widget/popup/LoadingPopup.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  Package? package;

  @override
  void initState() {
    initIAP() async {
      try {
        Offerings offerings = await Purchases.getOfferings();
        List<Package>? availablePackages =
            offerings.getOffering(offeringIdentifier)?.availablePackages;

        if (availablePackages != null && availablePackages.isNotEmpty) {
          setState(() => package = availablePackages[0]);
        }
      } on PlatformException catch (e) {
        log('PlatformException =>> $e');
      }
    }

    initIAP();
    super.initState();
  }

  onPurchase() async {
    if (package != null) {
      try {
        showDialog(
          context: context,
          builder: (context) => LoadingPopup(
            text: '데이터 불러오는 중...',
            color: Colors.white,
          ),
        );

        bool isPurchaseResult = await setPurchasePremium(package!);
        context.read<PremiumProvider>().setPremiumValue(isPurchaseResult);
      } on PlatformException catch (e) {
        PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);

        if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
          log('errorCode =>> $errorCode');
        }
      } finally {
        navigatorPop(context);
      }
    }
  }

  onRestore() async {
    bool isRestorePremium = await isPurchaseRestore();
    context.read<PremiumProvider>().setPremiumValue(isRestorePremium);
  }

  @override
  Widget build(BuildContext context) {
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '프리미엄'),
        body: Column(
          children: [
            CommonContainer(
              outerPadding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: '프리미엄 혜택',
                          isBold: true,
                          color: isLight ? textColor : darkTextColor,
                        ),
                        CommonText(
                          text: '구매 내역 가져오기',
                          color: grey.original,
                          fontSize: 12,
                          isBold: !isLight,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: premiumBenefitList
                        .map(
                          (premiumBenefit) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                svgAsset(
                                  name: premiumBenefit.svgName,
                                  width: 50,
                                ),
                                CommonSpace(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      text: premiumBenefit.mainTitle,
                                      isBold: !isLight,
                                    ),
                                    CommonSpace(height: 5),
                                    CommonText(
                                      text: premiumBenefit.subTitle,
                                      fontSize: 12,
                                      color: grey.original,
                                      isBold: !isLight,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  isPremium
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: CommonSvgText(
                            text: '구매가 완료되었어요 :D',
                            fontSize: 14,
                            isBold: !isLight,
                            svgName: 'premium-badge',
                            svgWidth: 16,
                            svgDirection: SvgDirectionEnum.left,
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: ImageButton(
                                path: 't-4',
                                text: '구매하기',
                                nameArgs: {
                                  "price": package?.storeProduct.priceString ??
                                      'None'
                                },
                                fontSize: 14,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                onTap: onPurchase,
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
