import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_spacing.dart';
import 'package:fintracker/core/utils/currency_formatter.dart';
import 'package:fintracker/presentation/authentication/widget/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBudgetProgress extends StatefulWidget {
  final double budgetLimit;
  final double budgetUsed;
  const MyBudgetProgress({
    super.key,
    required this.budgetLimit,
    required this.budgetUsed,
  });

  @override
  State<MyBudgetProgress> createState() => _MyBudgetProgressState();
}

class _MyBudgetProgressState extends State<MyBudgetProgress> {
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
                "Budget Progress",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('MMMM yyyy').format(DateTime.now()),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.msm),

          Row(
            children: [
              Column(
                children: [
                  Text('80%', style: Theme.of(context).textTheme.headlineLarge),
                  Text(
                    "of \$5,000",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      MyProgressIndicator(
                        height: 10,
                        width: double.infinity,
                        value: 0.8,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${formatCurrency(widget.budgetUsed)} used",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                          Text(
                            "${formatCurrency(widget.budgetLimit)} left",
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

