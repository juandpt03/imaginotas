import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

typedef ResetPasswordCallback = Function(String email);

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordCallback _resetPassword;

  ResetPasswordBloc({required ResetPasswordCallback resetPassword})
    : _resetPassword = resetPassword,
      super(const ResetPasswordState()) {
    on<EmailChanged>(_onEmailChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormReset>(_onFormReset);
    on<SetLoading>(_onSetLoading);
  }

  // Event handlers
  void _onEmailChanged(EmailChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSubmitted: false));

    await _resetPassword(state.email);

    emit(state.copyWith(isLoading: false, isSubmitted: true));
  }

  void _onFormReset(FormReset event, Emitter<ResetPasswordState> emit) {
    emit(const ResetPasswordState());
  }

  void _onSetLoading(SetLoading event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  // Public methods to dispatch events
  void onEmailChanged(String email) => add(EmailChanged(email));
  void onSubmitForm() => add(const FormSubmitted());
  void onResetForm() => add(const FormReset());
  void setLoading(bool isLoading) => add(SetLoading(isLoading));
}
