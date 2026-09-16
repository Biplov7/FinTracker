import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_radius.dart';
import 'package:fintracker/core/theme/app_spacing.dart';
import 'package:fintracker/domain/transaction/entity/transaction_enum.dart';
import 'package:fintracker/domain/transaction/enum/transaction_peroid.dart';
import 'package:fintracker/presentation/add_transaction/widget/transaction_icons.dart';
import 'package:fintracker/presentation/transaction/bloc/transaction_bloc.dart';
import 'package:fintracker/presentation/transaction/bloc/transaction_event.dart';
import 'package:fintracker/presentation/transaction/bloc/transaction_state.dart';
import 'package:fintracker/presentation/transaction/widget/category_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  int onSelect = 0;
  List<TransactionPeroid> category = TransactionPeroid.values;
  TransactionPeroid selectPeroid = TransactionPeroid.thisYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Transactions", style: TextTheme.of(context).titleMedium),
        actions: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(
                onPressed: () async {
                  final peroid = await showDialog<TransactionPeroid>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(
                                AppRadius.medium,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text("Close"),
                            ),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.large),
                        ),
                        titlePadding: EdgeInsets.all(AppSpacing.md),
                        contentPadding: EdgeInsets.only(
                          left: AppSpacing.md,
                          right: AppSpacing.md,
                          bottom: AppSpacing.md,
                        ),
                        title: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.medium,
                                ),
                              ),
                              child: Icon(
                                LucideIcons.filter,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Filter Period',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _periodTile(
                              context,
                              period: TransactionPeroid.today,
                              icon: LucideIcons.sun,
                            ),
                            _periodTile(
                              context,
                              period: TransactionPeroid.thisWeek,
                              icon: LucideIcons.calendarDays,
                            ),
                            _periodTile(
                              context,
                              period: TransactionPeroid.thisMonth,
                              icon: LucideIcons.calendarRange,
                            ),
                            _periodTile(
                              context,
                              period: TransactionPeroid.thisYear,
                              icon: LucideIcons.history,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                  if (peroid != null) {
                    setState(() {
                      selectPeroid = peroid;
                    });
                  }
                },
                icon: Icon(Icons.filter_list),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppRadius.small),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryButton(
                    label: "All",
                    index: 0,
                    isSelected: onSelect == 0,
                    onTap: () {
                      setState(() {
                        onSelect = 0;
                        context.read<TransactionBloc>().add(
                          LoadTransactionEvent(
                            period: selectPeroid,
                            type: TransactionEnum.all,
                          ),
                        );
                      });
                    },
                  ),
                  CategoryButton(
                    label: "Income",
                    index: 1,
                    isSelected: onSelect == 1,
                    onTap: () {
                      setState(() {
                        onSelect = 1;
                        context.read<TransactionBloc>().add(
                          LoadTransactionEvent(
                            period: selectPeroid,
                            type: TransactionEnum.income,
                          ),
                        );
                      });
                    },
                  ),
                  CategoryButton(
                    label: "Expense",
                    index: 2,
                    isSelected: onSelect == 2,
                    onTap: () {
                      setState(() {
                        onSelect = 2;
                        context.read<TransactionBloc>().add(
                          LoadTransactionEvent(
                            period: selectPeroid,
                            type: TransactionEnum.expense,
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: BlocConsumer<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is TransactionSuccess) {
                      if (state.transactions.isEmpty) {
                        return Center(child: Text("No transaction found"));
                      }
                      return ListView.builder(
                        itemCount: state.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = state.transactions[index];
                          final isIncome = transaction.incomeCategory != null;
                          final isIcon = isIncome
                              ? incomeCategoryIcon(transaction.incomeCategory)
                              : expenseCategoryIcon(
                                  transaction.expenseCategory,
                                );
                          final categoryName = isIncome
                              ? transaction.incomeCategory?.name ?? 'Income'
                              : transaction.expenseCategory?.name ?? 'Expense';
                          return ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isIncome
                                    ? AppColors.primary
                                    : AppColors.danger,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                isIcon,
                                color: isIncome
                                    ? AppColors.primary
                                    : AppColors.danger,
                              ),
                            ),
                            title: Text(categoryName),
                          );
                        },
                      );
                    }
                    return Center(child: Text("Select a filter"));
                  },
                  listener: (context, state) {
                    if (state is TransactionFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Cannot load the data"),
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _periodTile(
  BuildContext context, {
  required TransactionPeroid period,
  required IconData icon,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Icon(icon, size: 20, color: AppColors.primary),
    ),
    title: Text(
      period.name,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
    ),
    onTap: () {
      Navigator.pop(context, period);
    },
  );
}
