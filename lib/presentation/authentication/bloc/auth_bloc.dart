import 'package:ecommerce/domain/authentication/usecases/getcurrentuser_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/isloggedin_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signin_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signout_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signup_usecase.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_event.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
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
  }):super(AuthInitial()){
    on<AuthSignIn>(_authSignIn);
    on<AuthSignUp>(_authSignUp);
    on<AuthSignOut>(_authSignOut);
    on<CheckAuthRequested>(_checkAuthRequested);
  }

  void _authSignIn(AuthSignIn event,Emitter<AuthState> emit){

  }
  void _authSignOut(AuthSignOut event, Emitter<AuthState> emit){
    emit(AuthProgress());
    try{
      SignoutUsecase();
    }catch(e){
      emit(AuthFailure("Failed to SignOut"));
    }
  }
  void _authSignUp(AuthSignUp event,Emitter<AuthState> emit){

  }
  void _checkAuthRequested(CheckAuthRequested event,Emitter<AuthState> emit){

  }
}