import 'package:ecommerce/domain/authentication/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState{}

class AuthProgress extends AuthState{}

class AuthAuthenticate extends AuthState{
  final UserEntity user;
  AuthAuthenticate(this.user);
}

class AuthUnAuthenticate extends AuthState{}

class AuthFailure extends AuthState{
  final String errorMsg;
  AuthFailure(this.errorMsg);
}

