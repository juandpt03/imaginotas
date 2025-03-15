import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginotas/src/core/error/app_exeption.dart';
import 'package:imaginotas/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:imaginotas/src/features/shared/domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases _authUseCases;
  late final StreamSubscription<UserEntity?> _authStateSubscription;
  bool _isSplashComplete = false;

  AuthBloc({required AuthUseCases authUseCases})
    : _authUseCases = authUseCases,
      super(AuthChecking()) {
    _eventHandlers();
    _subscribeToAuthChanges();
    _checkStatus();
  }

  void _eventHandlers() {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthCheckStatusRequested>(_onCheckStatusRequested);
    on<AuthStateChanged>(_onAuthStateChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  // Event handlers
  void _onCheckStatusRequested(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthChecking());
    final currentUser = _authUseCases.currentUser;

    if (currentUser != null) {
      emit(AuthAuthenticated(currentUser));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onAuthStateChanged(AuthStateChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthAuthenticated(event.user!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authUseCases.login(user: event.user);

    result.when(
      left: (exception) => emit(AuthError(exception)),
      right: (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authUseCases.register(user: event.user);

    result.when(
      left: (exception) => emit(AuthError(exception)),
      right: (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authUseCases.logout();

    result.when(
      left: (exception) => emit(AuthError(exception)),
      right: (_) => emit(AuthUnauthenticated()),
    );
  }

  // Event emitters
  void login(UserEntity user) => add(AuthLoginRequested(user: user));

  void register(UserEntity user) => add(AuthRegisterRequested(user: user));

  void logout() => add(AuthLogoutRequested());

  void splashComplete() {
    _isSplashComplete = true;
    add(AuthCheckStatusRequested());
  }

  void _checkStatus() {
    if (!_isSplashComplete) return;
    add(AuthCheckStatusRequested());
  }

  void _subscribeToAuthChanges() {
    if (!_isSplashComplete) return;
    _authStateSubscription = _authUseCases.authStateChanges.listen(
      (user) => add(AuthStateChanged(user)),
    );
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
