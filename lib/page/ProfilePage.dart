import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/common/CommonBackground.dart';
import 'package:project/common/CommonContainer.dart';
import 'package:project/common/CommonScaffold.dart';
import 'package:project/common/CommonSpace.dart';
import 'package:project/common/CommonSvgText.dart';
import 'package:project/common/CommonText.dart';
import 'package:project/main.dart';
import 'package:project/page/IntroPage.dart';
import 'package:project/provider/GroupInfoListProvider.dart';
import 'package:project/provider/MemoInfoListProvider.dart';
import 'package:project/provider/UserInfoProvider.dart';
import 'package:project/util/class.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/util/enum.dart';
import 'package:project/util/final.dart';
import 'package:project/util/func.dart';
import 'package:project/widget/popup/AlertPopup.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;

  button({
    required String title,
    required Color color,
    required Widget child,
    required Function() onTap,
  }) {
    return CommonContainer(
      onTap: onTap,
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        CommonText(text: title, color: color),
        const Spacer(),
        child
      ]),
    );
  }

  loading() {
    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 11,
            height: 11,
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: red.original,
            ),
          ),
          CommonSpace(width: 7),
          CommonText(text: '회원 탈퇴 중...', color: red.s400)
        ],
      ),
    );
  }

  onLogout() async {
    try {
      await auth.signOut();
      navigatorRemoveUntil(context: context, page: const IntroPage());
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserInfoClass userInfo = context.watch<UserInfoProvider>().userInfo;
    List<GroupInfoClass> groupInfoList =
        context.watch<GroupInfoListProvider>().groupInfoList;
    List<MemoInfoClass> memoInfoList =
        context.watch<MemoInfoListProvider>().memoInfoList;

    onLeave() async {
      navigatorPop(context);
      setState(() => isLoading = true);

      try {
        await userMethod.deleteUser(
          context,
          userInfo.loginType,
          groupInfoList,
          memoInfoList,
        );

        setState(() => isLoading = false);
      } catch (e) {
        log('$e');
        return null;
      }
    }

    onDeletePopup() async {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '정말 회원 탈퇴할까요?',
          isCancel: true,
          buttonText: '탈퇴하기',
          height: 155,
          onTap: onLeave,
        ),
      );
    }

    String loginText = authButtonInfo[userInfo.loginType]!['name'];
    String svg = authButtonInfo[userInfo.loginType]!['svg'];

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '프로필'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              button(
                title: '로그인 연동',
                color: Colors.black,
                child: CommonSvgText(
                  text: loginText,
                  fontSize: 14,
                  svgWidth: 12,
                  svgName: svg,
                  svgDirection: SvgDirectionEnum.left,
                  svgColor: svg == 'apple-logo' ? Colors.black : null,
                ),
                onTap: () {},
              ),
              button(
                title: '로그아웃',
                color: red.s400,
                child: svgAsset(name: 'dir-right', width: 7),
                onTap: onLogout,
              ),
              isLoading
                  ? loading()
                  : button(
                      title: '회원 탈퇴',
                      color: red.s400,
                      child: svgAsset(name: 'dir-right', width: 7),
                      onTap: onDeletePopup,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
