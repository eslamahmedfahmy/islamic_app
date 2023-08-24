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
    apiKey: 'AIzaSyDeAXtwE6nxCqvHkyYcMP-Sv_PfO91hBWE',
    appId: '1:706611255029:web:3cb4c50d3ebc47061b97bc',
    messagingSenderId: '706611255029',
    projectId: 'islam-app-d8675',
    authDomain: 'islam-app-d8675.firebaseapp.com',
    storageBucket: 'islam-app-d8675.appspot.com',
    measurementId: 'G-5SBF8QBP8Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBx08-Ssb48Wzzc1emTP1QjPKb0miIWe-M',
    appId: '1:706611255029:android:6c4d66fbbcafee851b97bc',
    messagingSenderId: '706611255029',
    projectId: 'islam-app-d8675',
    storageBucket: 'islam-app-d8675.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvHE2_VywfN_jV0xqV2NCJ3-B7VfhBljg',
    appId: '1:706611255029:ios:000c25f08663d3781b97bc',
    messagingSenderId: '706611255029',
    projectId: 'islam-app-d8675',
    storageBucket: 'islam-app-d8675.appspot.com',
    iosClientId: '706611255029-jcgk8h3r5ajf0s1cb5sa8o41chojhmas.apps.googleusercontent.com',
    iosBundleId: 'com.example.islam_app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvHE2_VywfN_jV0xqV2NCJ3-B7VfhBljg',
    appId: '1:706611255029:ios:000c25f08663d3781b97bc',
    messagingSenderId: '706611255029',
    projectId: 'islam-app-d8675',
    storageBucket: 'islam-app-d8675.appspot.com',
    iosClientId: '706611255029-jcgk8h3r5ajf0s1cb5sa8o41chojhmas.apps.googleusercontent.com',
    iosBundleId: 'com.example.islam_app',
  );
}
