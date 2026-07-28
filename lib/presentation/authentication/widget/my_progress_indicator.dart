import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.veryLarge),
        color: AppColors.textTernary,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.veryLarge),
            color: AppColors.primarys,
          ),
        ),
      ),
    );
  }
}
