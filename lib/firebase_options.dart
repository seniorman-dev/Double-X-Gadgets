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
    apiKey: 'AIzaSyDpCjkDhu64oyxXTLIg-BbMOmhviRMAXl0',
    appId: '1:642464167886:web:b24e029a70562fba7b9d9f',
    messagingSenderId: '642464167886',
    projectId: 'monspeet-apps',
    authDomain: 'monspeet-apps.firebaseapp.com',
    databaseURL: 'https://monspeet-apps-default-rtdb.firebaseio.com',
    storageBucket: 'monspeet-apps.appspot.com',
    measurementId: 'G-J7W2QESGLS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDV2RVLjoFkIBzAqnBy4a0CWF4bSoMJ34s',
    appId: '1:642464167886:android:fef5ef8f5de46f8d7b9d9f',
    messagingSenderId: '642464167886',
    projectId: 'monspeet-apps',
    databaseURL: 'https://monspeet-apps-default-rtdb.firebaseio.com',
    storageBucket: 'monspeet-apps.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0UXJYuSrCkcXEHr-lLfgTgvyhtPxK334',
    appId: '1:642464167886:ios:0de9b28fe835bd677b9d9f',
    messagingSenderId: '642464167886',
    projectId: 'monspeet-apps',
    databaseURL: 'https://monspeet-apps-default-rtdb.firebaseio.com',
    storageBucket: 'monspeet-apps.appspot.com',
    iosClientId: '642464167886-9gobqkvdvqq33q159llkf5383r14d155.apps.googleusercontent.com',
    iosBundleId: 'com.example.elokaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC0UXJYuSrCkcXEHr-lLfgTgvyhtPxK334',
    appId: '1:642464167886:ios:0de9b28fe835bd677b9d9f',
    messagingSenderId: '642464167886',
    projectId: 'monspeet-apps',
    databaseURL: 'https://monspeet-apps-default-rtdb.firebaseio.com',
    storageBucket: 'monspeet-apps.appspot.com',
    iosClientId: '642464167886-9gobqkvdvqq33q159llkf5383r14d155.apps.googleusercontent.com',
    iosBundleId: 'com.example.elokaApp',
  );
}
