import 'package:fintracker/core/error/app_failure.dart';
import 'package:fintracker/data/authentication/datasource/auth_datasource.dart';
import 'package:fintracker/data/authentication/model/login_model.dart';
import 'package:fintracker/data/authentication/model/singup_model.dart';
import 'package:fintracker/data/authentication/model/user_model.dart';
import 'package:fintracker/domain/authentication/entities/login_entity.dart';
import 'package:fintracker/domain/authentication/entities/signup_entity.dart';
import 'package:fintracker/domain/authentication/entities/user_entity.dart';
import 'package:fintracker/domain/authentication/repositories/auth_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoimplementation implements AuthRepositories {
  final AuthDatasource ds;
  AuthRepoimplementation(this.ds);

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = ds.getCurrentUser();
    if (user == null) {
      return null;
    }
    return UserModel(
      id: user.uid,
      username: user.displayName ?? "",
      email: user.email!,
    );
  }

  @override
  Future<bool> isLoggedIn() {
    return ds.isLoggedIn();
  }

  @override
  Future<UserEntity> signIn(LoginEntity logIn) async {
    try {
      final credential = await ds.signIn(
        LoginModel(logIn.email, logIn.password),
      );
      final user = credential.user;
      if (user == null || user.email == null) {
        throw const AuthenticationFailure(
          'Sign-in did not return a valid user.',
        );
      }
      return UserModel(
        id: user.uid,
        username: user.displayName ?? '',
        email: user.email!,
      );
    } on FirebaseAuthException catch (error) {
      throw AuthenticationFailure(_messageFor(error));
    }
  }

  @override
  Future<void> signOut() {
    return ds.signOut();
  }

  @override
  Future<UserEntity> signUp(SignupEntity signUp) async {
    try {
      final credential = await ds.signUp(
        SignupModel(signUp.userName, signUp.email, signUp.password),
      );
      final user = credential.user;
      if (user == null || user.email == null) {
        throw const AuthenticationFailure(
          'Sign-up did not return a valid user.',
        );
      }
      await user.updateDisplayName(signUp.userName);
      return UserModel(
        id: user.uid,
        username: signUp.userName,
        email: user.email!,
      );
    } on FirebaseAuthException catch (error) {
      throw AuthenticationFailure(_messageFor(error));
    }
  }

  String _messageFor(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'The email or password is incorrect.';
      case 'email-already-in-use':
        return 'An account already exists for this email address.';
      case 'weak-password':
        return 'Please choose a stronger password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      default:
        return error.message ?? 'Authentication failed. Please try again.';
    }
  }
}

