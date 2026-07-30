import 'package:ecommerce/domain/authentication/entities/login_entity.dart';
import 'package:ecommerce/domain/authentication/entities/signup_entity.dart';

abstract class AuthEvent {}


class AuthSignIn extends AuthEvent{
  LoginEntity login;
  AuthSignIn(this.login);
}

class AuthSignUp extends AuthEvent{
  SignupEntity signup;
  AuthSignUp(this.signup);
}

class AuthSignOut extends AuthEvent{}

class CheckAuthRequested extends AuthEvent{}