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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyBh89RtEGcYz3INTFW_kzScAM76aodLtA8',
    appId: '1:282338631910:web:b797c8905c60870b7d5b27',
    messagingSenderId: '282338631910',
    projectId: 'bloodshare-94c37',
    authDomain: 'bloodshare-94c37.firebaseapp.com',
    databaseURL: 'https://bloodshare-94c37-default-rtdb.firebaseio.com',
    storageBucket: 'bloodshare-94c37.appspot.com',
    measurementId: 'G-CCW4K9CET6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChGK0uNqWR4F4xCmOuqiQTbIVz-hzb0vY',
    appId: '1:282338631910:android:0dada5c3e91125b17d5b27',
    messagingSenderId: '282338631910',
    projectId: 'bloodshare-94c37',
    databaseURL: 'https://bloodshare-94c37-default-rtdb.firebaseio.com',
    storageBucket: 'bloodshare-94c37.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIScuxKPDXSYSQgkmxTvATzYL-kSDoOR8',
    appId: '1:282338631910:ios:46e495e7ebd4a5307d5b27',
    messagingSenderId: '282338631910',
    projectId: 'bloodshare-94c37',
    databaseURL: 'https://bloodshare-94c37-default-rtdb.firebaseio.com',
    storageBucket: 'bloodshare-94c37.appspot.com',
    iosBundleId: 'com.example.bloodshare',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAIScuxKPDXSYSQgkmxTvATzYL-kSDoOR8',
    appId: '1:282338631910:ios:0ef34de0bd661e027d5b27',
    messagingSenderId: '282338631910',
    projectId: 'bloodshare-94c37',
    databaseURL: 'https://bloodshare-94c37-default-rtdb.firebaseio.com',
    storageBucket: 'bloodshare-94c37.appspot.com',
    iosBundleId: 'com.example.bloodshare.RunnerTests',
  );
}