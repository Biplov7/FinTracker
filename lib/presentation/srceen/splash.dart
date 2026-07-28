import 'package:ecommerce/core/router/app_name.dart';
import 'package:ecommerce/presentation/widget/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    context.goNamed(AppName.loginName);
  }

  @override
  Widget build(BuildContext context) {
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
              MyProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
