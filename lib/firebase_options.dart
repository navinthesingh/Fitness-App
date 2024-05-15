// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCE0IPVwheJprKUUgShzqAy6xn_d2nZJFg',
    appId: '1:798472347626:web:c70427adbe66b608e35c93',
    messagingSenderId: '798472347626',
    projectId: 'smartfitnessapplication-73806',
    authDomain: 'smartfitnessapplication-73806.firebaseapp.com',
    databaseURL:
        'https://smartfitnessapplication-73806-default-rtdb.firebaseio.com',
    storageBucket: 'smartfitnessapplication-73806.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChQB037pTPc4igT4haFX0drrdDlCKjk2U',
    appId: '1:798472347626:android:cddffdfec63eeb8ee35c93',
    messagingSenderId: '798472347626',
    projectId: 'smartfitnessapplication-73806',
    databaseURL:
        'https://smartfitnessapplication-73806-default-rtdb.firebaseio.com',
    storageBucket: 'smartfitnessapplication-73806.appspot.com',
  );
}
