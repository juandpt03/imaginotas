import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginotas/src/core/error/app_exeption.dart';
import 'package:imaginotas/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:imaginotas/src/features/shared/domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases _authUseCases;

  AuthBloc({required AuthUseCases authUseCases})
    : _authUseCases = authUseCases,
      super(AuthChecking()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthChecking());

    final result = await _authUseCases.login(user: event.user);

    result.when(
      left: (exception) => emit(AuthError(exception)),
      right: (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthChecking());

    final result = await _authUseCases.register(user: event.user);

    result.when(
      left: (exception) => emit(AuthError(exception)),
      right: (user) => emit(AuthAuthenticated(user)),
    );
  }

  void login(UserEntity user) => add(AuthLoginRequested(user: user));

  void signUp(UserEntity user) => add(AuthSignUpRequested(user: user));
}
