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
    apiKey: 'AIzaSyCUYNAkmnzHyUwlFkVF2IqtYqIhy_NBTIs',
    appId: '1:402355417473:web:c3bbc5fe731c3800d67880',
    messagingSenderId: '402355417473',
    projectId: 'dispatch-unit',
    authDomain: 'dispatch-unit.firebaseapp.com',
    storageBucket: 'dispatch-unit.appspot.com',
    measurementId: 'G-X8EW7TJQYZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4hVqG1wkyZt6qK15oFJSX6eANm6ImwNA',
    appId: '1:402355417473:android:78d65e6e8ada8387d67880',
    messagingSenderId: '402355417473',
    projectId: 'dispatch-unit',
    storageBucket: 'dispatch-unit.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBaX5jpeEk9mhCMQoyFIvPd89BysfHNAs',
    appId: '1:402355417473:ios:d58dbbf08caf75a4d67880',
    messagingSenderId: '402355417473',
    projectId: 'dispatch-unit',
    storageBucket: 'dispatch-unit.appspot.com',
    iosBundleId: 'com.example.dispatchSystem',
  );
}
