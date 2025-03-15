part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  final String email;
  final bool isLoading;
  final bool isSubmitted;

  const ResetPasswordState({
    this.email = '',
    this.isLoading = false,
    this.isSubmitted = false,
  });

  ResetPasswordState copyWith({
    String? email,
    bool? isLoading,
    bool? isSubmitted,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object> get props => [email, isLoading, isSubmitted];
}
