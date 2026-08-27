import 'package:ecommerce/core/router/app_name.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_bloc.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_event.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_state.dart';
import 'package:ecommerce/presentation/authentication/widget/my_progress_indicator.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce/injection.dart' as di;
import 'dart:async';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _initialization();
  }

  Future<void> _initialization() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check authentication
    context.read<AuthBloc>().add(CheckAuthRequested());
  }

  Future<void> _preloadDashboardData() async {
    try {
      final dashboardBloc = di.sl<DashboardBloc>();
      dashboardBloc.add(LoadDashboard());

      // Wait for the dashboard data to load using a Completer
      final completer = Completer<void>();
      late StreamSubscription subscription;

      subscription = dashboardBloc.stream.listen((state) {
        if (state is DashboardLoaded) {
          subscription.cancel();
          completer.complete();
        } else if (state is DashboardFailure) {
          subscription.cancel();
          completer.complete(); // Complete anyway so we don't hang
        }
      });

      // Wait for the data to load
      await completer.future;
    } catch (e) {
      // Silently fail
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticate) {
          // Preload dashboard data before navigating
          _preloadDashboardData().then((_) {
            if (mounted) {
              // ignore: use_build_context_synchronously
              context.goNamed(AppName.homeName);
            }
          });
        }
        if (state is AuthUnAuthenticate) {
          context.goNamed(AppName.loginName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: AssetImage("assets/logo/fintrack_logo.png"),
                    height: 270,
                    width: 160,
                  ),
                  MyProgressIndicator(height: 5, width: 92, value: 0.67),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
