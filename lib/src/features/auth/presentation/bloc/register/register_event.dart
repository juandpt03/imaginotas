part of 'register_bloc.dart';

sealed class RegisterEvent {
  const RegisterEvent();
}

class EmailChanged extends RegisterEvent {
  final String email;
  const EmailChanged(this.email);
}

class PasswordChanged extends RegisterEvent {
  final String password;
  const PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);
}

class FormSubmitted extends RegisterEvent {
  const FormSubmitted();
}

class FormReset extends RegisterEvent {
  const FormReset();
}

class TogglePasswordVisibility extends RegisterEvent {
  final bool isPasswordVisible;
  const TogglePasswordVisibility(this.isPasswordVisible);
}

class ToggleConfirmPasswordVisibility extends RegisterEvent {
  final bool isConfirmPasswordVisible;
  const ToggleConfirmPasswordVisibility(this.isConfirmPasswordVisible);
}

class SetLoading extends RegisterEvent {
  final bool isLoading;
  const SetLoading(this.isLoading);
}
