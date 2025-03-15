import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';

part 'register_event.dart';
part 'register_state.dart';

typedef RegisterCallback = void Function(UserEntity user);

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterCallback _register;

  RegisterBloc({required RegisterCallback register})
    : _register = register,
      super(RegisterState(user: UserEntity())) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormReset>(_onFormReset);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleConfirmPasswordVisibility>(_onToggleConfirmPasswordVisibility);
    on<SetLoading>(_onSetLoading);
  }

  // Event handlers
  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    final updatedUser = state.user.copyWith(email: event.email);
    emit(state.copyWith(user: updatedUser));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    final updatedUser = state.user.copyWith(password: event.password);
    emit(state.copyWith(user: updatedUser));
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  _onFormSubmitted(FormSubmitted event, Emitter<RegisterState> emit) {
    _onLoadingChanged(true);
    _register(state.user);
    _onLoadingChanged(false);
  }

  void _onFormReset(FormReset event, Emitter<RegisterState> emit) {
    emit(
      RegisterState(
        user: UserEntity(email: '', password: ''),
        confirmPassword: '',
        isLoading: false,
        isPasswordVisible: false,
        isConfirmPasswordVisible: false,
      ),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: event.isPasswordVisible));
  }

  void _onToggleConfirmPasswordVisibility(
    ToggleConfirmPasswordVisibility event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(isConfirmPasswordVisible: event.isConfirmPasswordVisible),
    );
  }

  void _onSetLoading(SetLoading event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  // Public methods to dispatch events
  void _onLoadingChanged(bool isLoading) => add(SetLoading(isLoading));
  void onTogglePasswordVisibility(bool isVisible) =>
      add(TogglePasswordVisibility(isVisible));
  void onToggleConfirmPasswordVisibility(bool isVisible) =>
      add(ToggleConfirmPasswordVisibility(isVisible));
  void onResetForm() => add(FormReset());
  void onSubmitForm() => add(FormSubmitted());
  void onEmailChanged(String email) => add(EmailChanged(email));
  void onPasswordChanged(String password) => add(PasswordChanged(password));
  void onConfirmPasswordChanged(String confirmPassword) =>
      add(ConfirmPasswordChanged(confirmPassword));
}
