import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_spacing.dart';
import 'package:fintracker/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';

class MyBalanceCard extends StatefulWidget {
  final double currentBalance;
  const MyBalanceCard({super.key,required this.currentBalance});

  @override
  State<MyBalanceCard> createState() => _MyBalanceCardState();
}

class _MyBalanceCardState extends State<MyBalanceCard> {
  static bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: AppSpacing.xs,
            offset: Offset(1, 2),
            color: Colors.grey,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Balance",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  isVisible ? formatCurrency(widget.currentBalance) : "XXX.XX",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.success,
                      size: AppSpacing.msm,
                      fontWeight: FontWeight.bold,
                    ),
                    Text(
                      "+12.2%",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " than last month",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: isVisible
                  ? Icon(Icons.visibility_outlined, color: Colors.grey)
                  : Icon(Icons.visibility_off_outlined, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

