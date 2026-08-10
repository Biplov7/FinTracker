import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class MyStatCard extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;
  final IconData icon;
  const MyStatCard({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.19),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Icon(icon, color: color)],
                ),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                amount,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
