import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';

part 'login_event.dart';
part 'login_state.dart';

typedef LoginCallback = void Function(UserEntity user);

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginCallback _login;

  LoginBloc({required LoginCallback login})
    : _login = login,
      super(LoginState(user: UserEntity())) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormReset>(_onFormReset);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<SetLoading>(_onSetLoading);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final updatedUser = state.user.copyWith(email: event.email);
    emit(state.copyWith(user: updatedUser));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final updatedUser = state.user.copyWith(password: event.password);
    emit(state.copyWith(user: updatedUser));
  }

  _onFormSubmitted(FormSubmitted event, Emitter<LoginState> emit) {
    _onLoadingChanged(true);
    _login(state.user);
    _onLoadingChanged(false);
  }

  void _onFormReset(FormReset event, Emitter<LoginState> emit) {
    emit(
      LoginState(
        user: UserEntity(email: '', password: ''),
        isLoading: false,
        isPasswordVisible: false,
      ),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: event.isPasswordVisible));
  }

  void _onSetLoading(SetLoading event, Emitter<LoginState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _onLoadingChanged(bool isLoading) => add(SetLoading(isLoading));
  void onTogglePasswordVisibility(bool isVisible) =>
      add(TogglePasswordVisibility(isVisible));

  void onResetForm() => add(FormReset());
  void onSubmitForm() => add(FormSubmitted());
  void onEmailChanged(String email) => add(EmailChanged(email));
  void onPasswordChanged(String password) => add(PasswordChanged(password));
}
