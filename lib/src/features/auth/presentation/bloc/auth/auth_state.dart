part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthChecking extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

final class AuthUnauthenticated extends AuthState {}

final class AuthFailure extends AuthState {
  final AppException error;
  const AuthFailure(this.error);
  @override
  List<Object> get props => [error];
}
