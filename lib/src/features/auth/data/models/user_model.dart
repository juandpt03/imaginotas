import 'package:firebase_auth/firebase_auth.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';

class UserModel implements UserEntity {
  @override
  final String id;
  @override
  final String email;
  @override
  final String password;

  const UserModel({
    required this.id,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String userId) {
    return UserModel(
      id: userId,
      email: json["email"] ?? "",
      password: json["password"] ?? "",
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(id: user.uid, email: user.email ?? "", password: "");
  }

  @override
  List<Object?> get props => [id, email, password];

  @override
  bool? get stringify => true;

  @override
  UserEntity copyWith({
    final String? id,
    final String? email,
    final String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
