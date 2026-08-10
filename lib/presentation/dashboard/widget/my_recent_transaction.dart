import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class MyRecentTransaction extends StatelessWidget {
  const MyRecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 12, bottom: 12, right: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: AppSpacing.xs,
            offset: Offset(1, 2),
            color: Colors.grey,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Transaction",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "See All",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.msm),
        ],
      ),
    );
  }
}
