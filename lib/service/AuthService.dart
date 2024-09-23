import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:project/service/DatabaseService.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
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

      if (userDetails != null) {
        Map<String, dynamic> userInfoMap = {
          "email": userDetails.email,
          "name": userDetails.displayName,
          "imgUrl": userDetails.photoURL,
          "id": userDetails.uid
        };
        await DatabaseService()
            .addUser(userDetails.uid, userInfoMap)
            .then((result) => log('${userDetails}'));
      }
    } catch (e) {
      log('error => $e');
    }
  }

  signInWithApple() async {
    AppleAuthProvider appleProvider = AppleAuthProvider();
    UserCredential result =
        await FirebaseAuth.instance.signInWithProvider(appleProvider);
    final userDetails = result.user;

    if (userDetails != null) {
      Map<String, dynamic> userInfoMap = {
        "email": userDetails.email,
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL,
        "id": userDetails.uid
      };
      await DatabaseService()
          .addUser(userDetails.uid, userInfoMap)
          .then((result) => log('${userDetails}'));
    }
  }

  signInWithKakao() async {
    OAuthProvider provider = OAuthProvider("oidc.todo-tracker");
    OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
    OAuthCredential credential = provider.credential(
      idToken: token.idToken,
      accessToken: token.accessToken,
    );
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final userDetails = result.user;

    if (userDetails != null) {
      Map<String, dynamic> userInfoMap = {
        "email": userDetails.email,
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL,
        "id": userDetails.uid
      };
      await DatabaseService()
          .addUser(userDetails.uid, userInfoMap)
          .then((result) => log('${userDetails}'));
    }
  }
}
