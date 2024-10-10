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
    apiKey: 'AIzaSyC2ZI4c63xnEFvWinfo5tiWwxlDq-rkVZM',
    appId: '1:547340854789:web:483d863b5b47d3ff481e6c',
    messagingSenderId: '547340854789',
    projectId: 'readygreen-e9025',
    authDomain: 'readygreen-e9025.firebaseapp.com',
    storageBucket: 'readygreen-e9025.appspot.com',
    measurementId: 'G-18BNSNHJ81',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6n-efYDH45BhSymFhyEFHKuvwOjrIA64',
    appId: '1:547340854789:android:cd5b15fe09d3560b481e6c',
    messagingSenderId: '547340854789',
    projectId: 'readygreen-e9025',
    storageBucket: 'readygreen-e9025.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwy9LhHeTF_PlbAoXpOnaAJuzbZMftNNg',
    appId: '1:547340854789:ios:4c228a96e39a82c3481e6c',
    messagingSenderId: '547340854789',
    projectId: 'readygreen-e9025',
    storageBucket: 'readygreen-e9025.appspot.com',
    iosBundleId: 'com.ddubucks.readygreen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwy9LhHeTF_PlbAoXpOnaAJuzbZMftNNg',
    appId: '1:547340854789:ios:4c228a96e39a82c3481e6c',
    messagingSenderId: '547340854789',
    projectId: 'readygreen-e9025',
    storageBucket: 'readygreen-e9025.appspot.com',
    iosBundleId: 'com.ddubucks.readygreen',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC2ZI4c63xnEFvWinfo5tiWwxlDq-rkVZM',
    appId: '1:547340854789:web:e24ee1eb2d6ade33481e6c',
    messagingSenderId: '547340854789',
    projectId: 'readygreen-e9025',
    authDomain: 'readygreen-e9025.firebaseapp.com',
    storageBucket: 'readygreen-e9025.appspot.com',
    measurementId: 'G-V0VY6G12JG',
  );
}