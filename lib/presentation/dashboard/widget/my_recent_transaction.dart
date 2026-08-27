import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/theme/app_spacing.dart';
import 'package:ecommerce/core/utils/currency_formatter.dart';
import 'package:ecommerce/domain/transaction/entities/expense_category.dart';
import 'package:ecommerce/domain/transaction/entities/income_category.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:ecommerce/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:ecommerce/presentation/transaction/screen/add_transaction_screen.dart';
import 'package:ecommerce/presentation/transaction/widget/transaction_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MyRecentTransaction extends StatelessWidget {
  const MyRecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DashboardFailure) {
          return Center(child: Text(state.error));
        }

        if (state is DashboardLoaded) {
          if (state.recentTransaction.isEmpty) {
            return const Center(child: Text("No Transaction Yet"));
          }

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.recentTransaction.length,
                  itemBuilder: (context, index) {
                    final transaction = state.recentTransaction[index];
                    return ListTile(
                      leading: transaction.type == TransactionType.income
                          ? Icon(
                              incomeCategoryIcon(
                                IncomeCategory.values.firstWhere(
                                  (element) =>
                                      element.name == transaction.category,
                                ),
                              ),
                            )
                          : Icon(
                              expenseCategoryIcon(
                                ExpenseCategory.values.firstWhere(
                                  (element) =>
                                      element.name == transaction.category,
                                ),
                              ),
                            ),
                      title: Text(
                        transaction.category,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat('MMMM d, yyyy').format(transaction.date),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: transaction.type == TransactionType.income
                          ? Text(
                              "+ ${formatCurrency(transaction.amount)}",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.success),
                            )
                          : Text(
                              "- ${formatCurrency(transaction.amount)}",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.danger),
                            ),
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
