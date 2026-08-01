import 'package:ecommerce/core/router/app_name.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_bloc.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_event.dart';
import 'package:ecommerce/presentation/authentication/bloc/auth_state.dart';
import 'package:ecommerce/presentation/authentication/widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnAuthenticate) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Logged Out Successfully"),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.danger,
            ),
          );
          context.goNamed(AppName.loginName);
        }
      },
      child: Scaffold(
        body: Center(
          child: MyButton(
            text: "SignOut",
            color: AppColors.textPrimary,
            txtColor: AppColors.background,
            onPressed: () => context.read<AuthBloc>().add(AuthSignOut()),
          ),
        ),
      ),
    );
  }
}
