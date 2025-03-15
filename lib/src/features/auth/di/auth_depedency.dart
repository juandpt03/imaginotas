import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/data/data.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';

class AuthDepedency {
  AuthDepedency._();

  static void init() {
    DI.sl.registerLazySingleton<AuthDatasource>(
      () => FirebaseAuthDatasource(firebaseAuth: DI.sl()),
    );
    DI.sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(datasource: DI.sl()),
    );
    DI.sl.registerLazySingleton<AuthUseCases>(
      () => AuthUseCases(authRepository: DI.sl()),
    );
  }
}
