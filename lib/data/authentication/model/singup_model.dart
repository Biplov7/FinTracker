import 'package:ecommerce/domain/authentication/entities/signup_entity.dart';

class SignupModel extends SignupEntity {
  SignupModel(
    super.userName,
    super.email,
    super.password,
  );

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      map['userName'] ?? '',
      map['email'] ?? '',
      map['password'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
    };
  }
}