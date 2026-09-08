import 'package:fintracker/core/router/app_name.dart';
import 'package:fintracker/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:fintracker/presentation/dashboard/screen/dashboard.dart';
import 'package:fintracker/presentation/authentication/srceen/login.dart';
import 'package:fintracker/presentation/authentication/srceen/signup.dart';
import 'package:fintracker/presentation/authentication/srceen/splash.dart';
import 'package:fintracker/presentation/add_transaction/screen/add_transaction_screen.dart';
import 'package:fintracker/injection.dart' as di;
import 'package:fintracker/presentation/add_transaction/bloc/transaction_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  // Create singleton instances to preserve state across route changes
  static final DashboardBloc _dashboardBloc = di.sl<DashboardBloc>();

  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: AppName.splashName,
        builder: (context, state) {
          return Splash();
        },
      ),
      GoRoute(
        path: '/login',
        name: AppName.loginName,
        builder: (context, state) {
          return Login();
        },
      ),
      GoRoute(
        path: '/signup',
        name: AppName.signupName,
        builder: (context, state) {
          return Signup();
        },
      ),
      GoRoute(
        path: '/home',
        name: AppName.homeName,
        builder: (context, state) {
          return BlocProvider.value(
            value: _dashboardBloc,
            child: Dashboard(),
          );
        },
      ),
      GoRoute(
        path: '/addTransaction',
        name: AppName.addTransactionName,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => di.sl<TransactionBloc>(),
            child: const AddTransactionScreen(),
          );
        },
      ),
    ],
  );
}

