import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_radius.dart';
import 'package:fintracker/presentation/add_transaction/widget/expense_form.dart';
import 'package:fintracker/presentation/add_transaction/widget/income_form.dart';
import 'package:fintracker/presentation/add_transaction/widget/budget_form.dart';
import 'package:fintracker/presentation/add_transaction/bloc/transaction_bloc.dart';
import 'package:fintracker/presentation/add_transaction/bloc/transaction_state.dart';
import 'package:fintracker/domain/add_transaction/entities/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TransactionType selectedType = TransactionType.expense;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Add Income"),
        centerTitle: true,
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.grey.withValues(alpha: 0.12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedType = TransactionType.expense;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: selectedType == TransactionType.expense
                                  ? AppColors.danger
                                  : AppColors.transp,
                            ),
                            child: Center(
                              child: Text(
                                "Expense",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          selectedType ==
                                              TransactionType.expense
                                          ? AppColors.card
                                          : DarkTheme.darkbackground,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedType = TransactionType.income;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: selectedType == TransactionType.income
                                  ? AppColors.primary
                                  : AppColors.transp,
                            ),
                            child: Center(
                              child: Text(
                                "Income",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          selectedType == TransactionType.income
                                          ? AppColors.card
                                          : DarkTheme.darkbackground,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedType = TransactionType.budget;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: selectedType == TransactionType.budget
                                  ? AppColors.primary
                                  : AppColors.transp,
                            ),
                            child: Center(
                              child: Text(
                                "Budget",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          selectedType == TransactionType.budget
                                          ? AppColors.card
                                          : DarkTheme.darkbackground,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppRadius.large),

                    selectedType == TransactionType.income
                        ? IncomeForm()
                        : selectedType == TransactionType.budget
                            ? BudgetForm()
                            : ExpenseForm(),
                  ],
                ),
              ),
            ),
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is! TransactionLoading) {
                  return const SizedBox.shrink();
                }

                return const Positioned.fill(
                  child: ColoredBox(
                    color: Color(0x1F000000),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

