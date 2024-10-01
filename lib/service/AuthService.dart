import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:project/main.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';

class AuthService {
  commonSignIn(
    BuildContext context,
    userDetails,
    String loginType,
  ) async {
    try {
      String locale = context.locale.toString();
      DateTime createDateTime = DateTime.now();
      String uid = userDetails.uid;
      bool isUser = await userMethod.isUser;

      log('userDetails.uid ${userDetails.uid}');

      if (isUser == false) {
        String gid = uuid();
        UserInfoClass userInfo = UserInfoClass(
          uid: uid,
          loginType: loginType,
          createDateTime: createDateTime,
          email: userDetails.email,
          displayName: userDetails.displayName,
          imgUrl: userDetails.photoURL,
          groupOrderList: [gid],
          fontFamily: initFontFamily,
          background: '0',
          theme: 'light',
          widgetTheme: 'light',
        );
        GroupInfoClass groupInfo = GroupInfoClass(
          gid: gid,
          name: getGroupName(locale),
          colorName: '남색',
          createDateTime: createDateTime,
          isOpen: true,
          taskOrderList: [],
          taskInfoList: [],
        );

        await userMethod.addUser(userInfo: userInfo);
        await groupMethod.addGroup(gid: gid, groupInfo: groupInfo);
      }

      navigatorRemoveUntil(context: context, page: HomePage(locale: locale));
    } catch (e) {
      log('$e');
    }
  }

  signInWithGoogle(BuildContext context) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      GoogleSignIn googleSignIn = GoogleSignIn();

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      UserCredential result =
          await firebaseAuth.signInWithCredential(credential);
      final userDetails = result.user;

      if (userDetails != null) commonSignIn(context, userDetails, 'google');
    } catch (e) {
      log('error => $e');
    }
  }

  signInWithApple(BuildContext context) async {
    try {
      AppleAuthProvider appleProvider = AppleAuthProvider();

      UserCredential result =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
      final userDetails = result.user;

      if (userDetails != null) commonSignIn(context, userDetails, 'apple');
    } catch (e) {
      log('error => $e');
    }
  }

  signInWithKakao(BuildContext context) async {
    try {
      OAuthProvider provider = OAuthProvider("oidc.todo-tracker");
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      OAuthCredential credential = provider.credential(
        idToken: token.idToken,
        accessToken: token.accessToken,
      );
      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final userDetails = result.user;

      if (userDetails != null) commonSignIn(context, userDetails, 'kakao');
    } catch (e) {
      log('error => $e');
    }
  }
}
