import 'package:ecommerce/core/error/app_failure.dart';
import 'package:ecommerce/domain/authentication/usecases/getcurrentuser_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/isloggedin_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signin_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signout_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signup_usecase.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_event.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetcurrentuserUsecase currentUserUseCase;
  final IsloggedinUsecase isLoggedInUseCase;
  final SigninUsecase signInUseCase;
  final SignoutUsecase signOutUseCase;
  final SignupUsecase signUpUseCase;
  AuthBloc({
    required this.currentUserUseCase,
    required this.isLoggedInUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.signUpUseCase,
  }) : super(AuthInitial()) {
    on<AuthSignIn>(_authSignIn, transformer: droppable());
    on<AuthSignUp>(_authSignUp, transformer: droppable());
    on<AuthSignOut>(_authSignOut);
    on<CheckAuthRequested>(_checkAuthRequested);
  }

  void _authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    try {
      emit(AuthProgress());
      final user = await signInUseCase(event.login);
      emit(AuthAuthenticate(user));
    } on AppFailure catch (failure) {
      emit(AuthFailure(failure.message));
    } catch (_) {
      emit(AuthFailure('Something went wrong.'));
    }
  }

  void _authSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    try {
      emit(AuthProgress());
      await signOutUseCase();
      emit(AuthUnAuthenticate());
    } catch (e) {
      emit(AuthFailure("Failed to SignOut"));
    }
  }

  void _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    try {
      emit(AuthProgress());
      final user = await signUpUseCase(event.signup);
      emit(AuthAuthenticate(user));
    } on AppFailure catch (failure) {
      emit(AuthFailure(failure.message));
    } catch (_) {
      emit(AuthFailure('Failed to sign up user.'));
    }
  }

  void _checkAuthRequested(
    CheckAuthRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final isLoggedIn = await isLoggedInUseCase();

      if (isLoggedIn) {
        final user = await currentUserUseCase();
        emit(AuthAuthenticate(user!));
      } else {
        emit(AuthUnAuthenticate());
      }
    } catch (e) {
      emit(AuthFailure("User not authenticate"));
    }
  }
}
