import 'package:ecommerce/data/authentication/datasource/auth_datasource.dart';
import 'package:ecommerce/data/authentication/repositories/auth_repo_implementation.dart';
import 'package:ecommerce/domain/authentication/repositories/auth_repositories.dart';
import 'package:ecommerce/domain/authentication/usecases/getcurrentuser_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/isloggedin_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signin_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signout_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signup_usecase.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  final firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => AuthDatasource(firebaseAuth));
  sl.registerLazySingleton<AuthRepositories>(() => AuthRepoimplementation(sl()));

  sl.registerLazySingleton(() => GetcurrentuserUsecase(sl()));
  sl.registerLazySingleton(() => IsloggedinUsecase(sl()));
  sl.registerLazySingleton(() => SigninUsecase(sl()));
  sl.registerLazySingleton(() => SignoutUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl()));

  sl.registerFactory(
    () => AuthBloc(
      currentUserUseCase: sl(),
      isLoggedInUseCase: sl(),
      signInUseCase: sl(),
      signOutUseCase: sl(),
      signUpUseCase: sl(),
    ),
  );
}
