import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_radius.dart';
import 'package:fintracker/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';

class WalletContainer extends StatelessWidget {
  final String accountName;
  final double amount;
  final String title;
  final Color colorContent;
  final IconData iconContent;

  const WalletContainer({
    super.key,
    required this.accountName,
    required this.amount,
    required this.title,
    required this.colorContent,
    required this.iconContent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorContent,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 5),
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ), 
      child: Row(
        children: [
          // Wallet icon
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(iconContent, size: 28, color: Colors.black87),
          ),

          const SizedBox(width: 16),

          // Wallet information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accountName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.background,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  formatCurrency(amount),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.background,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.background,
                  ),
                ),
              ],
            ),
          ),

          // More button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.more_vert,
                  size: 22,
                  color: AppColors.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}