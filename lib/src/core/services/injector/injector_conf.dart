import 'package:get_it/get_it.dart';
import 'package:imaginotas/src/core/core.dart';

import 'injector.dart';

class DI {
  DI._internal();
  static final sl = GetIt.I;

  static setup() async {
    sl.registerLazySingleton(() => AppRouteConf());
    await EnvLoader().loadEnv('.env');
    sl.registerLazySingleton(() => EnvLoader());
    sl.registerLazySingleton(() => Environment());
    sl.registerLazySingleton(() => AppTheme());
    AuthDepedency.init();
  }
}
