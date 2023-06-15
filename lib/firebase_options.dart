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
    apiKey: 'AIzaSyDUVxCtzaK5QK-LdyyJRrnwa27Y5ERpoJ4',
    appId: '1:891625459915:web:fe050059ce67e54b4dcb4e',
    messagingSenderId: '891625459915',
    projectId: 'chat-app-flutter-firestore',
    authDomain: 'chat-app-flutter-firestore.firebaseapp.com',
    storageBucket: 'chat-app-flutter-firestore.appspot.com',
    measurementId: 'G-DGZC0SRQ7N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZZTtvLxddzg3CFGTlSWllUrFny8uvEPo',
    appId: '1:891625459915:android:f5d491193f6b009b4dcb4e',
    messagingSenderId: '891625459915',
    projectId: 'chat-app-flutter-firestore',
    storageBucket: 'chat-app-flutter-firestore.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsfFeYkBwv-M_Y9ato6dmZaWJGbxGEtJQ',
    appId: '1:891625459915:ios:489f667338b27ec24dcb4e',
    messagingSenderId: '891625459915',
    projectId: 'chat-app-flutter-firestore',
    storageBucket: 'chat-app-flutter-firestore.appspot.com',
    iosClientId: '891625459915-mnk2dvtlqvvrpuj9ekdf8tkkmes3fjf0.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatAppFlutterFirestore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsfFeYkBwv-M_Y9ato6dmZaWJGbxGEtJQ',
    appId: '1:891625459915:ios:2a5b4ed85f5498ae4dcb4e',
    messagingSenderId: '891625459915',
    projectId: 'chat-app-flutter-firestore',
    storageBucket: 'chat-app-flutter-firestore.appspot.com',
    iosClientId: '891625459915-475kjfcqdtgmh5fa90g0j9nkbte1avjo.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatAppFlutterFirestore.RunnerTests',
  );
}