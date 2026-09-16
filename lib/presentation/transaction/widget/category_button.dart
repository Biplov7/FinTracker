import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSpacing.xxl,
        width: MediaQuery.of(context).size.width * 0.24,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.textSecondary.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(AppSpacing.msm),
          color: isSelected ? AppColors.primarys : AppColors.transp,
        ),
        child: Center(
          child: Text(
            label,
            style: TextTheme.of(context).bodyMedium?.copyWith(
              color: isSelected ? AppColors.background : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
