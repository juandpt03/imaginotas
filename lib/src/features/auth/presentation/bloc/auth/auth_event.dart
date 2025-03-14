part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthLoginRequested extends AuthEvent {
  final UserEntity user;
  const AuthLoginRequested({required this.user});
}

final class AuthRegisterRequested extends AuthEvent {
  final UserEntity user;
  const AuthRegisterRequested({required this.user});
}

final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

final class AuthCheckStatusRequested extends AuthEvent {}

final class AuthStateChanged extends AuthEvent {
  final UserEntity? user;
  const AuthStateChanged(this.user);
}

final class AuthSplashCompleted extends AuthEvent {
  const AuthSplashCompleted();
}
