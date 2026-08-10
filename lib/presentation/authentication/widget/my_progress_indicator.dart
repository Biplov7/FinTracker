import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  final double height;
  final double width;
  final double value;

  const MyProgressIndicator({
    super.key,
    required this.height,
    required this.width,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.veryLarge),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: AppColors.textTernary,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primarys),
        ),
      ),
    );
  }
}
