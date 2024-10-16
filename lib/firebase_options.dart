// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCyVEgQf-dgYkPdBrvR2P-zLNFNLlQE2x4',
    appId: '1:328765857346:web:c63770fb9657f23617d7db',
    messagingSenderId: '328765857346',
    projectId: 'todo-tracker-project',
    authDomain: 'todo-tracker-project.firebaseapp.com',
    storageBucket: 'todo-tracker-project.appspot.com',
    measurementId: 'G-W9WXMYBR79',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7n9QDC9jyPOYd8Dbz4pvYCfggfeLuv8Y',
    appId: '1:328765857346:android:a4d20fcce3e75bec17d7db',
    messagingSenderId: '328765857346',
    projectId: 'todo-tracker-project',
    storageBucket: 'todo-tracker-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOV67TFf0CCaqMXRJ64JOb4yz3WV9nhk4',
    appId: '1:328765857346:ios:c18f82308462e6ec17d7db',
    messagingSenderId: '328765857346',
    projectId: 'todo-tracker-project',
    storageBucket: 'todo-tracker-project.appspot.com',
    iosBundleId: 'com.kthdd.todoPlanner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOV67TFf0CCaqMXRJ64JOb4yz3WV9nhk4',
    appId: '1:328765857346:ios:c18f82308462e6ec17d7db',
    messagingSenderId: '328765857346',
    projectId: 'todo-tracker-project',
    storageBucket: 'todo-tracker-project.appspot.com',
    iosBundleId: 'com.kthdd.todoPlanner',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCyVEgQf-dgYkPdBrvR2P-zLNFNLlQE2x4',
    appId: '1:328765857346:web:8dd55e2f4aee507917d7db',
    messagingSenderId: '328765857346',
    projectId: 'todo-tracker-project',
    authDomain: 'todo-tracker-project.firebaseapp.com',
    storageBucket: 'todo-tracker-project.appspot.com',
    measurementId: 'G-VNCTXW3F6S',
  );
}
