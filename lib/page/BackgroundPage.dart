import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonNull.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/model/user_box/user_box.dart';
import 'package:project/page/PremiumPage.dart';
import 'package:project/provider/PremiumProvider.dart';
import 'package:project/provider/ReloadProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        return CommonBackground(
          child: CommonScaffold(
            appBarInfo: AppBarInfoClass(title: '앱 배경'),
            body: CommonContainer(
              child: SingleChildScrollView(
                child: Column(
                  children: backroundClassList
                      .map(
                        (backgroundList) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(children: [
                            BackgroundItem(
                              path: backgroundList[0].path,
                              name: backgroundList[0].name,
                            ),
                            CommonSpace(width: 20),
                            BackgroundItem(
                              path: backgroundList[1].path,
                              name: backgroundList[1].name,
                            )
                          ]),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BackgroundItem extends StatefulWidget {
  BackgroundItem({
    super.key,
    required this.path,
    required this.name,
  });

  String path, name;

  @override
  State<BackgroundItem> createState() => _BackgroundItemState();
}

class _BackgroundItemState extends State<BackgroundItem> {
  UserBox user = userRepository.user;

  @override
  Widget build(BuildContext context) {
    String theme = user.background ?? '1';
    bool isPremium = context.watch<PremiumProvider>().isPremium;
    bool isReload = context.watch<ReloadProvider>().isReload;

    onBackground(String path) async {
      if (isPremium) {
        user.background = path;
        await user.save();

        context.read<ReloadProvider>().setReload(!isReload);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertPopup(
            height: 175,
            desc: '프리미엄 구매 시\n배경을 변경 할 수 있어요.',
            buttonText: '프리미엄 구매 페이지로 이동',
            onTap: () => movePage(context: context, page: const PremiumPage()),
          ),
        );
      }
    }

    return Expanded(
      child: InkWell(
        onTap: () => onBackground(widget.path),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/image/b-${widget.path}.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                widget.path == theme
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Mask(height: 200, opacity: 0.2),
                          Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                  size: 30,
                                  weight: 1,
                                ),
                                CommonSpace(height: 5),
                                CommonText(
                                  text: '적용 중',
                                  color: Colors.white,
                                  isBold: true,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : const CommonNull()
              ],
            ),
            CommonSpace(height: 5),
            CommonText(
              text: widget.name,
              fontSize: 12,
              color: textColor,
              isNotTr: true,
            )
          ],
        ),
      ),
    );
  }
}

class Mask extends StatelessWidget {
  Mask({super.key, this.height, this.opacity});

  double? height, opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(opacity ?? 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
