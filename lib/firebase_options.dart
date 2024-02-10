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
    apiKey: 'AIzaSyDwzV4prdF9cMVrvLsaJuB61qXVBdBk31M',
    appId: '1:1020803690607:web:71915453fbcc9b62f0dd9a',
    messagingSenderId: '1020803690607',
    projectId: 'my-new-111',
    authDomain: 'my-new-111.firebaseapp.com',
    storageBucket: 'my-new-111.appspot.com',
    measurementId: 'G-V0B74D7K76',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAeoZGZdr_UCBvq3Mcdql-M3E7u4-n41Xg',
    appId: '1:1020803690607:android:735332513a3a9372f0dd9a',
    messagingSenderId: '1020803690607',
    projectId: 'my-new-111',
    storageBucket: 'my-new-111.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1rv8nkIo6-ydk0GEWtl29idkG001PKHw',
    appId: '1:1020803690607:ios:fafddac2d51c6ea2f0dd9a',
    messagingSenderId: '1020803690607',
    projectId: 'my-new-111',
    storageBucket: 'my-new-111.appspot.com',
    iosBundleId: 'com.example.flutterApplication2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1rv8nkIo6-ydk0GEWtl29idkG001PKHw',
    appId: '1:1020803690607:ios:8775fdf5a2c56767f0dd9a',
    messagingSenderId: '1020803690607',
    projectId: 'my-new-111',
    storageBucket: 'my-new-111.appspot.com',
    iosBundleId: 'com.example.flutterApplication2.RunnerTests',
  );
}
