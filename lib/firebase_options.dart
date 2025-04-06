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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyAPASsC8ljKFaXAc6H_JHQORtW2NXKcZZk",
      authDomain: "mycart-c9241.firebaseapp.com",
      projectId: "mycart-c9241",
      storageBucket: "mycart-c9241.firebasestorage.app",
      messagingSenderId: "247046966539",
      appId: "1:247046966539:web:b5a50c4ba86687638f660e",
      measurementId: "G-FMS0BSGM2X"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHdkoLmg2gRESyydphdZHxjBCeBfY4vM4',
    appId: '1:247046966539:android:37c2ed17adb1794f8f660e',
    messagingSenderId: '247046966539',
    projectId: 'mycart-c9241',
    storageBucket: 'mycart-c9241.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_IOS_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_IOS_STORAGE_BUCKET',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    appId: 'YOUR_MACOS_APP_ID',
    messagingSenderId: 'YOUR_MACOS_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_MACOS_STORAGE_BUCKET',
    iosClientId: 'YOUR_MACOS_CLIENT_ID',
    iosBundleId: 'YOUR_MACOS_BUNDLE_ID',
  );
}
