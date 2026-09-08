import 'package:fintracker/domain/authentication/entities/login_entity.dart';
import 'package:fintracker/domain/authentication/entities/signup_entity.dart';
import 'package:fintracker/domain/authentication/entities/user_entity.dart';

abstract class AuthRepositories {
  Future<UserEntity> signUp(SignupEntity signUp);
  Future<UserEntity> signIn(LoginEntity logIn);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
  Future<bool> isLoggedIn();
}
