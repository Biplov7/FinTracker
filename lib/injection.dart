import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/authentication/datasource/auth_datasource.dart';
import 'package:ecommerce/data/authentication/repositories/auth_repo_implementation.dart';
import 'package:ecommerce/data/dashboard/datasource/getdashboarddata.dart';
import 'package:ecommerce/data/dashboard/repositories/dashboard_repo_implementation.dart';
import 'package:ecommerce/data/transaction/repositories/transaction_repo_implementation.dart';
import 'package:ecommerce/data/transaction/datasource/transaction_datasource.dart';
import 'package:ecommerce/domain/authentication/repositories/auth_repositories.dart';
import 'package:ecommerce/domain/authentication/usecases/getcurrentuser_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/isloggedin_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signin_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signout_usecase.dart';
import 'package:ecommerce/domain/authentication/usecases/signup_usecase.dart';
import 'package:ecommerce/domain/dashboard/repositories/dashboard_repo.dart';
import 'package:ecommerce/domain/dashboard/usecases/getdashboarddata_usecase.dart';
import 'package:ecommerce/domain/dashboard/usecases/setbudget_usecase.dart';
import 'package:ecommerce/domain/transaction/repositories/transaction_repositories.dart';
import 'package:ecommerce/domain/transaction/usecases/addexpense_usecase.dart';
import 'package:ecommerce/domain/transaction/usecases/addincome_usecase.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_bloc.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:ecommerce/presentation/transaction/bloc/transaction_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => AuthDatasource(firebaseAuth));
  sl.registerLazySingleton(() => Getdashboarddata(firebaseStore, firebaseAuth));
  sl.registerLazySingleton<AuthRepositories>(
    () => AuthRepoimplementation(sl()),
  );

  sl.registerLazySingleton(() => GetcurrentuserUsecase(sl()));
  sl.registerLazySingleton(() => IsloggedinUsecase(sl()));
  sl.registerLazySingleton(() => SigninUsecase(sl()));
  sl.registerLazySingleton(() => SignoutUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl(), sl()));

  sl.registerFactory(
    () => AuthBloc(
      currentUserUseCase: sl(),
      isLoggedInUseCase: sl(),
      signInUseCase: sl(),
      signOutUseCase: sl(),
      signUpUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<DashboardRepo>(
    () => DashboardRepoImplementation(sl()),
  );

  sl.registerLazySingleton(() => GetdashboarddataUsecase(sl()));

  sl.registerLazySingleton(() => SetBudgetUsecase(sl()));

  sl.registerFactory(() => DashboardBloc(getdashboarddataUsecase: sl()));

  sl.registerLazySingleton(
    () => TransactionDatasource(firebaseStore, firebaseAuth),
  );
  sl.registerLazySingleton<TransactionRepositories>(
    () => TransactionRepoImplementation(sl()),
  );

  sl.registerLazySingleton(() => AddexpenseUsecase(sl()));

  sl.registerLazySingleton(() => AddincomeUsecase(sl()));

  sl.registerFactory(
    () => TransactionBloc(
      addexpenseUsecase: sl(),
      addincomeUsecase: sl(),
      setBudgetUsecase: sl(),
    ),
  );
}
