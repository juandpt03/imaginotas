part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged(this.email);
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);
}

class FormSubmitted extends LoginEvent {
  const FormSubmitted();
}

class FormReset extends LoginEvent {
  const FormReset();
}

class TogglePasswordVisibility extends LoginEvent {
  final bool isPasswordVisible;
  const TogglePasswordVisibility(this.isPasswordVisible);
}

class SetLoading extends LoginEvent {
  final bool isLoading;

  const SetLoading(this.isLoading);
}
