
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
          'DefaultFirebaseOptions have not been configured for linux. '
              'You can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  ///  Web config
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBzMdsUVR1194W2LYmmO3us0KrHsNrO4RY",
    authDomain: "my-habit-tracker-b1cdc.firebaseapp.com",
    projectId: "my-habit-tracker-b1cdc",
    storageBucket: "my-habit-tracker-b1cdc.firebasestorage.app",
    messagingSenderId: "955570163418",
    appId: "1:955570163418:web:f78acc223f915265839fe3",
  );

  ///  Android config (from google-services.json)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBS2JTGMsBdhpUfzkyo3DUW6kacQDdngS8",
    appId: "1:955570163418:android:eddb98ca830adff3839fe3",
    messagingSenderId: "955570163418",
    projectId: "my-habit-tracker-b1cdc",
    storageBucket: "my-habit-tracker-b1cdc.firebasestorage.app",
  );

  ///  iOS config (from Firebase console)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyBzMdsUVR1194W2LYmmO3us0KrHsNrO4RY", // from your console/plist
    appId: "1:955570163418:ios:b99171aa0b03b0ac839fe3", // App ID
    messagingSenderId: "955570163418",
    projectId: "my-habit-tracker-b1cdc",
    storageBucket: "my-habit-tracker-b1cdc.firebasestorage.app",
    iosBundleId: "com.example.habitTrackerFinal",
  );

  static const FirebaseOptions macos = ios;

  static const FirebaseOptions windows = web;
}
