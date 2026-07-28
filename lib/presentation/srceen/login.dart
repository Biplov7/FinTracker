import 'package:ecommerce/core/router/app_name.dart';
import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/theme/app_spacing.dart';
import 'package:ecommerce/presentation/widget/my_button.dart';
import 'package:ecommerce/presentation/widget/my_text.dart';
import 'package:ecommerce/presentation/widget/my_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool pw = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Image(
                    height: 200,
                    width: 200,
                    image: AssetImage("assets/logo/welcome.png"),
                  ),
                  SizedBox(height: AppSpacing.md),
                  MyText(
                    text: "Welcome Back",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: AppSpacing.xs),
                  MyText(
                    text: "Signin to continue",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: AppSpacing.lg),
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
                    alignment: Alignment.centerRight,
                    child: MyText(
                      text: "Forget Password?",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  MyButton(
                    text: "Login",
                    color: AppColors.primary,
                    txtColor: AppColors.background,
                  ),
                  SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 4,
                          color: AppColors.textTernary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: MyText(
                          text: "or continue with",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 4,
                          color: AppColors.textTernary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),
                  MyButton(
                    text: "Continue with Google",
                    color: AppColors.background,
                    txtColor: Colors.black,
                    icon: Image.asset(
                      'assets/logo/google.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account?",
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: AppColors.textPrimary),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Do somethings
                              context.goNamed(AppName.signupName);
                            },
                          text: "SignUp",
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
    );
  }
}
