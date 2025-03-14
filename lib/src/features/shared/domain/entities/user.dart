import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String password;
  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id, username, email, password];
}
