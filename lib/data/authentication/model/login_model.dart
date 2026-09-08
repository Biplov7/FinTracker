import 'package:fintracker/domain/authentication/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel(
    super.email,
    super.password,
  );

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      map['email'] ?? '',
      map['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
