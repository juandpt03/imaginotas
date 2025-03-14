import 'package:imaginotas/src/features/shared/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String email,
    required String username,
    required String password,
  }) : super(id: id, email: email, username: username, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json, String userId) {
    return UserModel(
      id: userId,
      email: json["email"],
      username: json["username"],
      password: json["password"],
    );
  }
}
