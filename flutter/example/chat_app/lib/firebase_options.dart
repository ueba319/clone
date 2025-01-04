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
    apiKey: 'AIzaSyDijmcFqvp8_iPcBCgCUMTtSPwHezUbi1g',
    appId: '1:153110385711:web:681e37f118d1e6fd2122da',
    messagingSenderId: '153110385711',
    projectId: 'chat-app-c9afc',
    authDomain: 'chat-app-c9afc.firebaseapp.com',
    storageBucket: 'chat-app-c9afc.firebasestorage.app',
    measurementId: 'G-BKS5W54046',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMtk6-8PHHPKl2MEcyXDuayzFh2J-hAxc',
    appId: '1:153110385711:android:e67d6c348374d0302122da',
    messagingSenderId: '153110385711',
    projectId: 'chat-app-c9afc',
    storageBucket: 'chat-app-c9afc.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDD69uL9nY7SXIJ3uFAnwIgxNF7tjR598',
    appId: '1:153110385711:ios:5d4fa9db4e52eded2122da',
    messagingSenderId: '153110385711',
    projectId: 'chat-app-c9afc',
    storageBucket: 'chat-app-c9afc.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDD69uL9nY7SXIJ3uFAnwIgxNF7tjR598',
    appId: '1:153110385711:ios:5d4fa9db4e52eded2122da',
    messagingSenderId: '153110385711',
    projectId: 'chat-app-c9afc',
    storageBucket: 'chat-app-c9afc.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDijmcFqvp8_iPcBCgCUMTtSPwHezUbi1g',
    appId: '1:153110385711:web:4f03a804eec299d42122da',
    messagingSenderId: '153110385711',
    projectId: 'chat-app-c9afc',
    authDomain: 'chat-app-c9afc.firebaseapp.com',
    storageBucket: 'chat-app-c9afc.firebasestorage.app',
    measurementId: 'G-CQMP0EFVK9',
  );
}