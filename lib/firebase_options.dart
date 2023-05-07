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
    apiKey: 'AIzaSyBS2Il0C6mnXsyq2AfcW6UOKqKm7-gk_3g',
    appId: '1:9408683174:web:379b087ec43d6a8b1da867',
    messagingSenderId: '9408683174',
    projectId: 'dev-odyssey-109b2',
    authDomain: 'dev-odyssey-109b2.firebaseapp.com',
    storageBucket: 'dev-odyssey-109b2.appspot.com',
    measurementId: 'G-N9WE8RWYWJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUmXxnutUXm47mVeQQe8WgwWb1dodzTb0',
    appId: '1:9408683174:android:c15a7dfec6b92d431da867',
    messagingSenderId: '9408683174',
    projectId: 'dev-odyssey-109b2',
    storageBucket: 'dev-odyssey-109b2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvqm8xBMWFum_KIZzeROfIDRDMQgA4VN0',
    appId: '1:9408683174:ios:c8eb776cdb6836c41da867',
    messagingSenderId: '9408683174',
    projectId: 'dev-odyssey-109b2',
    storageBucket: 'dev-odyssey-109b2.appspot.com',
    iosClientId: '9408683174-2tgg8giojb736qi2sa2rnf90rsj7bjkb.apps.googleusercontent.com',
    iosBundleId: 'io.terracorp.devOdyssey',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvqm8xBMWFum_KIZzeROfIDRDMQgA4VN0',
    appId: '1:9408683174:ios:c8eb776cdb6836c41da867',
    messagingSenderId: '9408683174',
    projectId: 'dev-odyssey-109b2',
    storageBucket: 'dev-odyssey-109b2.appspot.com',
    iosClientId: '9408683174-2tgg8giojb736qi2sa2rnf90rsj7bjkb.apps.googleusercontent.com',
    iosBundleId: 'io.terracorp.devOdyssey',
  );
}
