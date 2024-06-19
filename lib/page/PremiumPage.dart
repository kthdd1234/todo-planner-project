import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/util/class.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/button/ImageButton.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        CommonText(text: '프리미엄 혜택'),
                        CommonText(
                          text: '구매 복원하기',
                          color: grey.original,
                          fontSize: 12,
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
                                    name: premiumBenefit.svgName, width: 50),
                                CommonSpace(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(text: premiumBenefit.mainTitle),
                                    CommonSpace(height: 5),
                                    CommonText(
                                      text: premiumBenefit.subTitle,
                                      fontSize: 12,
                                      color: grey.original,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ImageButton(
                          path: 't-23',
                          text: '구매하기 (??)',
                          fontSize: 14,
                          padding: const EdgeInsets.symmetric(vertical: 15),
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

// 평생 무료
// 광고 제거
// 사진 추가