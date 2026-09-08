import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintracker/data/authentication/datasource/auth_datasource.dart';
import 'package:fintracker/data/authentication/repositories/auth_repo_implementation.dart';
import 'package:fintracker/data/dashboard/datasource/getdashboarddata.dart';
import 'package:fintracker/data/dashboard/repositories/dashboard_repo_implementation.dart';
import 'package:fintracker/data/add_transaction/repositories/transaction_repo_implementation.dart';
import 'package:fintracker/data/add_transaction/datasource/transaction_datasource.dart';
import 'package:fintracker/data/transaction/datasource/gettransactiondata.dart';
import 'package:fintracker/data/transaction/repositories/transaction_repo.dart';
import 'package:fintracker/domain/authentication/repositories/auth_repositories.dart';
import 'package:fintracker/domain/authentication/usecases/getcurrentuser_usecase.dart';
import 'package:fintracker/domain/authentication/usecases/isloggedin_usecase.dart';
import 'package:fintracker/domain/authentication/usecases/signin_usecase.dart';
import 'package:fintracker/domain/authentication/usecases/signout_usecase.dart';
import 'package:fintracker/domain/authentication/usecases/signup_usecase.dart';
import 'package:fintracker/domain/dashboard/repositories/dashboard_repo.dart';
import 'package:fintracker/domain/dashboard/usecases/getdashboarddata_usecase.dart';
import 'package:fintracker/domain/dashboard/usecases/getuserprofile_usecase.dart';
import 'package:fintracker/domain/dashboard/usecases/getrecenttransaction_usecase.dart';
import 'package:fintracker/domain/dashboard/usecases/updatedashboarddata_usecase.dart';
import 'package:fintracker/domain/add_transaction/usecases/setbudget_usecase.dart';
import 'package:fintracker/domain/add_transaction/repositories/transaction_repositories.dart';
import 'package:fintracker/domain/add_transaction/usecases/addexpense_usecase.dart';
import 'package:fintracker/domain/add_transaction/usecases/addincome_usecase.dart';
import 'package:fintracker/domain/transaction/repositories/viewtransaction_repostiories.dart';
import 'package:fintracker/domain/transaction/usecases/loadtransaction_usecases.dart';
import 'package:fintracker/presentation/authentication/bloc/auth_bloc.dart';
import 'package:fintracker/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:fintracker/presentation/add_transaction/bloc/transaction_bloc.dart';
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

  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));

  sl.registerLazySingleton(() => GetrecenttransactionUsecase(sl()));

  sl.registerLazySingleton(() => UpdatedashboarddataUsecase(sl()));

  sl.registerLazySingleton(() => SetBudgetUsecase(sl()));

  sl.registerFactory(
    () => DashboardBloc(
      getdashboarddataUsecase: sl(),
      getrecenttransactionUsecase: sl(),
      updatedashboarddataUsecase: sl(),
      getUserProfileUseCase: sl(),
    ),
  );

  // Add Transaction (Expense/Income) - For adding new transactions
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
      updatedashboarddataUsecase: sl()
    ),
  );

  // View Transactions - For loading/viewing transactions
  sl.registerLazySingleton(
    () => Gettransactiondata(firebaseStore, firebaseAuth),
  );
  sl.registerLazySingleton<ViewtransactionRepostiories>(
    () => TransactionRepo(sl()),
  );

  sl.registerLazySingleton(() => LoadtransactionUsecases(sl()));
}

