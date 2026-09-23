import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

class ExpenseOverview extends StatefulWidget {
  const ExpenseOverview({super.key});

  @override
  State<ExpenseOverview> createState() => _ExpenseOverviewState();
}

class _ExpenseOverviewState extends State<ExpenseOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        color: AppColors.card,
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: AppRadius.medium,
          vertical: AppRadius.medium,
        ),
        child: Column(
          children: [
            Text(
              "Expense Overview",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(children: [
              
            ],)
          ],
        ),
      ),
    );
  }
}
