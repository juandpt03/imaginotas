import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:imaginotas/src/core/core.dart';

class DefaultFirebaseOptions {
  static Environment environment = Environment();
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: environment.firebaseAndroidApiKey,
    appId: environment.firebaseAndroidAppId,
    messagingSenderId: environment.firebaseAndroidMessagingSenderId,
    projectId: environment.firebaseAndroidProjectId,
    storageBucket: environment.firebaseAndroidStorageBucket,
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: environment.firebaseIosApiKey,
    appId: environment.firebaseIosAppId,
    messagingSenderId: environment.firebaseIosMessagingSenderId,
    projectId: environment.firebaseIosProjectId,
    storageBucket: environment.firebaseIosStorageBucket,
    iosBundleId: environment.firebaseIosBundleId,
  );
}
