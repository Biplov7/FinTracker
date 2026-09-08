import 'package:fintracker/domain/authentication/entities/login_entity.dart';
import 'package:fintracker/domain/authentication/entities/signup_entity.dart';

abstract class AuthEvent {}

class AuthSignIn extends AuthEvent {
  final LoginEntity login;
  AuthSignIn(this.login);
}

class AuthSignUp extends AuthEvent {
  final SignupEntity signup;
  AuthSignUp(this.signup);
}

class AuthSignOut extends AuthEvent {}

class CheckAuthRequested extends AuthEvent {}

