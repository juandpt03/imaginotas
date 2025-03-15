part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final UserEntity user;
  final String confirmPassword;
  final bool isLoading;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const RegisterState({
    required this.user,
    this.confirmPassword = '',
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  RegisterState copyWith({
    UserEntity? user,
    String? confirmPassword,
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return RegisterState(
      user: user ?? this.user,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }

  @override
  List<Object> get props => [
    user,
    confirmPassword,
    isLoading,
    isPasswordVisible,
    isConfirmPasswordVisible,
  ];
}
