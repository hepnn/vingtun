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
    apiKey: 'AIzaSyCCmvQPw3QgZxHZ46nZFqHPc_71FvO2ASw',
    appId: '1:896873111788:web:63548f9993ebf00a9d45c9',
    messagingSenderId: '896873111788',
    projectId: 'vingtun-f8009',
    authDomain: 'vingtun-f8009.firebaseapp.com',
    storageBucket: 'vingtun-f8009.appspot.com',
    measurementId: 'G-9T59ZF042S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCn6OlViVtoWC-P3AufEB0K1cWhNzPIGaQ',
    appId: '1:896873111788:android:315abaf3fe38eec19d45c9',
    messagingSenderId: '896873111788',
    projectId: 'vingtun-f8009',
    storageBucket: 'vingtun-f8009.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJZReF7DTtVFqEBAQiWsmqo4xzvDnbTQA',
    appId: '1:896873111788:ios:982e738c0d6e824b9d45c9',
    messagingSenderId: '896873111788',
    projectId: 'vingtun-f8009',
    storageBucket: 'vingtun-f8009.appspot.com',
    iosClientId: '896873111788-34j78rkdfh3l1idsqibabjt6b0ir4btg.apps.googleusercontent.com',
    iosBundleId: 'com.example.vingtun',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJZReF7DTtVFqEBAQiWsmqo4xzvDnbTQA',
    appId: '1:896873111788:ios:982e738c0d6e824b9d45c9',
    messagingSenderId: '896873111788',
    projectId: 'vingtun-f8009',
    storageBucket: 'vingtun-f8009.appspot.com',
    iosClientId: '896873111788-34j78rkdfh3l1idsqibabjt6b0ir4btg.apps.googleusercontent.com',
    iosBundleId: 'com.example.vingtun',
  );
}
