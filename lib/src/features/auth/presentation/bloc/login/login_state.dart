part of 'login_bloc.dart';

class LoginState extends Equatable {
  final UserEntity user;
  final bool isLoading;
  final bool isPasswordVisible;

  const LoginState({
    required this.user,
    this.isLoading = false,
    this.isPasswordVisible = false,
  });

  LoginState copyWith({
    final UserEntity? user,
    final bool? isLoading,
    final bool? isPasswordVisible,
  }) {
    return LoginState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object> get props => [user, isLoading, isPasswordVisible];
}
