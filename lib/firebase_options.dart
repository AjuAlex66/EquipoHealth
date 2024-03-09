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
    apiKey: 'AIzaSyCiD6G8TSkue0QQpdEjBarQsMXc7nVHg7c',
    appId: '1:590666906347:web:34deb3632e9cd3ea495cae',
    messagingSenderId: '590666906347',
    projectId: 'my-second-project-14356',
    authDomain: 'my-second-project-14356.firebaseapp.com',
    databaseURL: 'https://my-second-project-14356.firebaseio.com',
    storageBucket: 'my-second-project-14356.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAL7glHgpa8ucOUE6Ix8bq_TdbvXAkYQoE',
    appId: '1:590666906347:android:5abf9ec59e424b57495cae',
    messagingSenderId: '590666906347',
    projectId: 'my-second-project-14356',
    databaseURL: 'https://my-second-project-14356.firebaseio.com',
    storageBucket: 'my-second-project-14356.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAk8zKxkU0Bbd2Z9ix5BXmlRSOpF6Dq5GU',
    appId: '1:590666906347:ios:fd9450403bcc27db495cae',
    messagingSenderId: '590666906347',
    projectId: 'my-second-project-14356',
    databaseURL: 'https://my-second-project-14356.firebaseio.com',
    storageBucket: 'my-second-project-14356.appspot.com',
    androidClientId:
        '590666906347-941lhegrpemj9taknua5bd662bstl5bq.apps.googleusercontent.com',
    iosClientId:
        '590666906347-54j9e06qn0fgblmoi92n9hpglt4hhgfe.apps.googleusercontent.com',
    iosBundleId: 'com.example.equipohealth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAk8zKxkU0Bbd2Z9ix5BXmlRSOpF6Dq5GU',
    appId: '1:590666906347:ios:5ca82699d4867f85495cae',
    messagingSenderId: '590666906347',
    projectId: 'my-second-project-14356',
    databaseURL: 'https://my-second-project-14356.firebaseio.com',
    storageBucket: 'my-second-project-14356.appspot.com',
    androidClientId:
        '590666906347-941lhegrpemj9taknua5bd662bstl5bq.apps.googleusercontent.com',
    iosClientId:
        '590666906347-2sekgqj09sc0dctns9b5at4j2eaumn7s.apps.googleusercontent.com',
    iosBundleId: 'com.example.equipohealth.RunnerTests',
  );
}