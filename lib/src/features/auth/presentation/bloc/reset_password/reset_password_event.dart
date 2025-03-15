part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends ResetPasswordEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class FormSubmitted extends ResetPasswordEvent {
  const FormSubmitted();
}

class FormReset extends ResetPasswordEvent {
  const FormReset();
}

class SetLoading extends ResetPasswordEvent {
  final bool isLoading;

  const SetLoading(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}
