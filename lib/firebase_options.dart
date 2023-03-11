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
    apiKey: 'AIzaSyAYWTAUc5m-x1OoUyV4JceQt3NqHSd_GGU',
    appId: '1:224413618818:web:61187635035a204df81a9b',
    messagingSenderId: '224413618818',
    projectId: 'dtifoodapp',
    authDomain: 'dtifoodapp.firebaseapp.com',
    storageBucket: 'dtifoodapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYHueoHnBVeqlGpuxCuDDexMquNEeJOlg',
    appId: '1:224413618818:android:d3e906a3f0c106d3f81a9b',
    messagingSenderId: '224413618818',
    projectId: 'dtifoodapp',
    storageBucket: 'dtifoodapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5ssQJMTMP46eqg4Svyj4jNWh31S3g70I',
    appId: '1:224413618818:ios:ce64f689a5f23695f81a9b',
    messagingSenderId: '224413618818',
    projectId: 'dtifoodapp',
    storageBucket: 'dtifoodapp.appspot.com',
    iosClientId: '224413618818-ke5g7juntp1bpbnkpmq0tpi6ajce8nmr.apps.googleusercontent.com',
    iosBundleId: 'com.example.dti2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5ssQJMTMP46eqg4Svyj4jNWh31S3g70I',
    appId: '1:224413618818:ios:ce64f689a5f23695f81a9b',
    messagingSenderId: '224413618818',
    projectId: 'dtifoodapp',
    storageBucket: 'dtifoodapp.appspot.com',
    iosClientId: '224413618818-ke5g7juntp1bpbnkpmq0tpi6ajce8nmr.apps.googleusercontent.com',
    iosBundleId: 'com.example.dti2',
  );
}
