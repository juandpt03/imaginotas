import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/shared/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<Either<AppException, UserEntity>> login({required UserEntity user});
  Future<Either<AppException, UserEntity>> register({required UserEntity user});
}
