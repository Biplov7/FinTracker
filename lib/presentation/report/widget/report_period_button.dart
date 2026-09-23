import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_radius.dart';
import 'package:fintracker/domain/report/entities/report_peroid.dart';
import 'package:fintracker/presentation/report/helper/peroid_helper.dart';
import 'package:flutter/material.dart';

class ReportPeriodButton extends StatelessWidget {
  final ReportPeroid period;
  final ReportPeroid selectedPeriod;
  final VoidCallback onTap;

  const ReportPeriodButton({
    super.key,
    required this.period,
    required this.selectedPeriod,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = period == selectedPeriod;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primarys
                : AppColors.transp,
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
          child: Center(
            child: Text(
              PeroidHelper.getPeroid(period),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.card
                    : DarkTheme.darkbackground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}