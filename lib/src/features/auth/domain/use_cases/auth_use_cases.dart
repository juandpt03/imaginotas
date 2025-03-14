import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';

class AuthUseCases {
  final AuthRepository authRepository;

  AuthUseCases({required this.authRepository});

  Future<Either<AppException, UserEntity>> login({required UserEntity user}) =>
      authRepository.login(user: user);

  Future<Either<AppException, UserEntity>> register({
    required UserEntity user,
  }) => authRepository.register(user: user);
}
