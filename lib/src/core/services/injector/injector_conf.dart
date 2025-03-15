import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:imaginotas/src/core/core.dart';

import 'injector.dart';

class DI {
  DI._internal();
  static final sl = GetIt.I;

  static setup() async {
    await EnvLoader().loadEnv('.env');
    sl.registerLazySingleton(() => EnvLoader());
    sl.registerLazySingleton(() => Environment());

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    sl.registerLazySingleton(() => FirebaseAuth.instance);
    sl.registerLazySingleton(() => AppTheme());
    AuthDepedency.init();
  }
}
