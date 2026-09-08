import 'package:fintracker/core/router/app_name.dart';
import 'package:fintracker/domain/authentication/entities/signup_entity.dart';
import 'package:fintracker/presentation/authentication/bloc/auth_bloc.dart';
import 'package:fintracker/presentation/authentication/bloc/auth_event.dart';
import 'package:fintracker/presentation/authentication/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_spacing.dart';
import 'package:fintracker/presentation/authentication/widget/my_button.dart';
import 'package:fintracker/presentation/authentication/widget/my_text.dart';
import 'package:fintracker/presentation/authentication/widget/my_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool pw = true;
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegExp.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticate) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("SignIn successfully"),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.success,
            ),
          );
          context.goNamed(AppName.homeName);
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.danger,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        Image(
                          height: 160,
                          width: 160,
                          image: AssetImage("assets/logo/create_acc.png"),
                        ),
                        SizedBox(height: AppSpacing.md),
                        MyText(
                          text: "Create Account",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: AppSpacing.xs),
                        MyText(
                          text: "Let's get you started",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: AppSpacing.lg),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: "Full Name",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        MyTextField(
                          controller: name,
                          label: "Enter your full name",
                          keyboardType: TextInputType.name,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a username";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppSpacing.md),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: "Email",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        MyTextField(
                          controller: email,
                          label: "Enter your email",
                          keyboardType: TextInputType.emailAddress,
                          validation: _validateEmail,
                        ),
                        SizedBox(height: AppSpacing.md),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: "Password",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        MyTextField(
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a password";
                            }
                            if (value.length < 8) {
                              return "Password must be at least 8 character";
                            }

                            final specialCharRegex = RegExp(
                              r'[!@#$%^&*(),.?":{}|<>]',
                            );

                            if (!specialCharRegex.hasMatch(value)) {
                              return "Password must contain at least one special character";
                            }
                            return null;
                          },
                          controller: password,
                          hide: pw,
                          label: "Enter your password",
                          keyboardType: TextInputType.text,
                          icon: IconButton(
                            onPressed: () {
                              setState(() {
                                pw = !pw;
                              });
                            },
                            icon: pw
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined),
                          ),
                        ),
                        SizedBox(height: AppSpacing.md),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: "Confirm Password",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        MyTextField(
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != password.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                          controller: confirmPassword,
                          hide: pw,
                          label: "Confirm your password",
                          keyboardType: TextInputType.text,
                          icon: IconButton(
                            onPressed: () {
                              setState(() {
                                pw = !pw;
                              });
                            },
                            icon: pw
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined),
                          ),
                        ),
                        SizedBox(height: AppSpacing.lg),
                        state is AuthProgress
                            ? const CircularProgressIndicator()
                            : MyButton(
                                text: "Sign Up",
                                color: AppColors.primary,
                                txtColor: AppColors.background,
                                onPressed: () {
                                  if (_globalKey.currentState!.validate()) {
                                    final signup = SignupEntity(
                                      name.text.trim(),
                                      email.text.trim(),
                                      password.text,
                                    );
                                    context.read<AuthBloc>().add(
                                      AuthSignUp(signup),
                                    );
                                  }
                                },
                              ),
                        SizedBox(height: AppSpacing.lg),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an account?",
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(color: AppColors.textPrimary),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Do somethings
                                    context.goNamed(AppName.loginName);
                                  },
                                text: "Login",
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

