part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthLoginRequested extends AuthEvent {
  final UserEntity user;
  const AuthLoginRequested({required this.user});
}

final class AuthSignUpRequested extends AuthEvent {
  final UserEntity user;
  const AuthSignUpRequested({required this.user});
}

final class AuthLogoutRequested extends AuthEvent {
  final UserEntity user;
  const AuthLogoutRequested({required this.user});
}

final class AuthCheckStatusRequested extends AuthEvent {
  final UserEntity user;
  const AuthCheckStatusRequested({required this.user});
}
