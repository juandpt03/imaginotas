import 'package:imaginotas/src/core/error/app_exeption.dart';
import 'package:imaginotas/src/core/functional/either.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<Either<AppException<Exception>, UserEntity>> login({
    required UserEntity user,
  }) => datasource.login(user: user);

  @override
  Future<Either<AppException<Exception>, UserEntity>> register({
    required UserEntity user,
  }) => datasource.register(user: user);

  @override
  Stream<UserEntity?> get authStateChanges => datasource.authStateChanges;

  @override
  UserEntity? get currentUser => datasource.currentUser;

  @override
  Future<Either<AppException<Exception>, void>> logout() => datasource.logout();
}
