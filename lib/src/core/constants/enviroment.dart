import 'package:imaginotas/src/core/services/injector/injector_conf.dart';
import 'package:imaginotas/src/core/utils/env_loader.dart';

class Environment {
  static final Environment _instance = Environment._internal();
  static final EnvLoader _envLoader = DI.sl.get();

  Environment._internal();

  factory Environment() => _instance;

  final apiUrl = _envLoader.get('API_URL') ?? '';

  final firebaseAndroidApiKey =
      _envLoader.get('FIREBASE_ANDROID_API_KEY') ?? '';
  final firebaseAndroidAppId = _envLoader.get('FIREBASE_ANDROID_APP_ID') ?? '';
  final firebaseAndroidMessagingSenderId =
      _envLoader.get('FIREBASE_ANDROID_MESSAGING_SENDER_ID') ?? '';
  final firebaseAndroidProjectId =
      _envLoader.get('FIREBASE_ANDROID_PROJECT_ID') ?? '';
  final firebaseAndroidStorageBucket =
      _envLoader.get('FIREBASE_ANDROID_STORAGE_BUCKET') ?? '';

  final firebaseIosApiKey = _envLoader.get('FIREBASE_IOS_API_KEY') ?? '';
  final firebaseIosAppId = _envLoader.get('FIREBASE_IOS_APP_ID') ?? '';
  final firebaseIosMessagingSenderId =
      _envLoader.get('FIREBASE_IOS_MESSAGING_SENDER_ID') ?? '';
  final firebaseIosProjectId = _envLoader.get('FIREBASE_IOS_PROJECT_ID') ?? '';
  final firebaseIosStorageBucket =
      _envLoader.get('FIREBASE_IOS_STORAGE_BUCKET') ?? '';
  final firebaseIosBundleId = _envLoader.get('FIREBASE_IOS_BUNDLE_ID') ?? '';
}
