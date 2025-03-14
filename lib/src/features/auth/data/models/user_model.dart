import 'package:firebase_auth/firebase_auth.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';

class UserModel implements UserEntity {
  @override
  final String id;
  @override
  final String email;
  @override
  final String username;
  @override
  final String password;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String userId) {
    return UserModel(
      id: userId,
      email: json["email"] ?? "",
      username: json["username"] ?? "",
      password: json["password"] ?? "",
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? "",
      username: user.displayName ?? "",
      password: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"email": email, "username": username, "password": password};
  }

  @override
  List<Object?> get props => [id, email, username, password];

  @override
  bool? get stringify => true;
}
