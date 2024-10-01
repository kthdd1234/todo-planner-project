import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:project/main.dart';
import 'package:project/page/HomePage.dart';
import 'package:project/page/IntroPage.dart';
import 'package:project/util/class.dart';
import 'package:project/util/constants.dart';
import 'package:project/util/func.dart';
import 'package:provider/provider.dart';

class UserMethod {
  String get uid => auth.currentUser!.uid;

  Future<bool> get isUser async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await firestore.collection(usersCollection).doc(uid).get();

    return user.exists;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> get userSnapshots {
    return firestore.collection(usersCollection).doc(uid).snapshots();
  }

  Future<bool> addUser({required UserInfoClass userInfo}) async {
    await firestore.collection(usersCollection).doc(uid).set(userInfo.toJson());
    return true;
  }

  Future<bool> updateUser({required UserInfoClass userInfo}) async {
    await firestore
        .collection(usersCollection)
        .doc(uid)
        .update(userInfo.toJson());

    return true;
  }

  Future<bool> deleteUser(
    BuildContext context,
    String loginType,
    List<GroupInfoClass> groupInfoList,
    List<MemoInfoClass> memoInfoList,
  ) async {
    bool isReauthenticate = await reauthenticateWithProvider(loginType);

    if (isReauthenticate) {
      await firestore.collection(usersCollection).doc(uid).delete();
      await groupMethod.removeAllGroup(
        groupIdList: groupInfoList.map((groupInfo) => groupInfo.gid).toList(),
      );
      await memoMethod.removeAllMemo(
        memoIdList: memoInfoList
            .map((memoInfo) => memoInfo.dateTimeKey.toString())
            .toList(),
      );
      await auth.currentUser!.delete();
      navigatorRemoveUntil(context: context, page: const IntroPage());
    }

    return true;
  }

  Future<bool> reauthenticateWithProvider(String loginType) async {
    try {
      if (loginType == 'kakao') {
        OAuthProvider provider = OAuthProvider("oidc.todo-tracker");
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        OAuthCredential credential = provider.credential(
          idToken: token.idToken,
          accessToken: token.accessToken,
        );

        await auth.currentUser!.reauthenticateWithCredential(credential);
      } else if (loginType == 'google') {
        GoogleSignIn googleSignIn = GoogleSignIn();
        GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signInSilently();
        GoogleSignInAuthentication? googleSignInAuthentication =
            await googleSignInAccount?.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken,
        );

        await auth.currentUser!.reauthenticateWithCredential(credential);
      } else {
        AppleAuthProvider appleProvider = AppleAuthProvider();
        await auth.currentUser!.reauthenticateWithProvider(appleProvider);
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
