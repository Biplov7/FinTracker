import 'package:ecommerce/core/theme/app_colors.dart';
import 'package:ecommerce/core/theme/app_radius.dart';
import 'package:ecommerce/core/theme/app_spacing.dart';
import 'package:ecommerce/presentation/authentication/widget/my_text_field.dart';
import 'package:ecommerce/presentation/transaction/bloc/transaction_bloc.dart';
import 'package:ecommerce/presentation/transaction/bloc/transaction_event.dart';
import 'package:ecommerce/presentation/transaction/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BudgetForm extends StatefulWidget {
  const BudgetForm({super.key});

  @override
  State<BudgetForm> createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  final TextEditingController budgetLimitController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    budgetLimitController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void _clearForm() {
    setState(() {
      budgetLimitController.clear();
      dateController.clear();
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> dateTime() async {
      final DateTime? picker = await showDatePicker(
        initialDate: _selectedDate ?? DateTime.now(),
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (picker != null) {
        setState(() {
          _selectedDate = picker;
          dateController.text = DateFormat('MMMM d, yyyy').format(picker);
        });
      }
    }

    return BlocConsumer<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionSuccess) {
          _clearForm();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.success,
            ),
          );
        }
        if (state is TransactionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.danger,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is TransactionLoading) {
          return Expanded(child: Center(child: CircularProgressIndicator()));
        }
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Budget Limit",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: AppRadius.small),
              MyTextField(
                preIcon: Icon(
                  LucideIcons.dollarSign,
                  color: AppColors.primary,
                  size: AppRadius.large,
                ),
                controller: budgetLimitController,
                label: "Enter your budget limit",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a budget limit";
                  }
                  final amount = double.tryParse(value);

                  if (amount == null) {
                    return "Enter a valid amount";
                  }
                  if (amount < 0) {
                    return "Budget limit must be greater than 0";
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Date",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(height: AppRadius.small),
              TextFormField(
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(
                  hintText: "Select Date",
                  prefixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.primary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                onTap: dateTime,
              ),
              SizedBox(height: AppSpacing.md),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  color: AppColors.primary,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (budgetLimitController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a budget limit"),
                          backgroundColor: AppColors.danger,
                        ),
                      );
                      return;
                    }

                    final budgetLimit = double.parse(budgetLimitController.text);
                    context.read<TransactionBloc>().add(
                      AddBudgetEvent(budgetLimit),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                    ),
                  ),
                  child: Text(
                    "Set Budget",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.card,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
