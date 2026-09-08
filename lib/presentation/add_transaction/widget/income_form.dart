import 'package:fintracker/core/theme/app_colors.dart';
import 'package:fintracker/core/theme/app_radius.dart';
import 'package:fintracker/core/theme/app_spacing.dart';
import 'package:fintracker/core/utils/form_validators.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_entity.dart';
import 'package:fintracker/domain/add_transaction/entities/income_source.dart';
import 'package:fintracker/presentation/authentication/widget/my_text_field.dart';
import 'package:fintracker/presentation/add_transaction/bloc/transaction_bloc.dart';
import 'package:fintracker/presentation/add_transaction/bloc/transaction_event.dart';
import 'package:fintracker/presentation/add_transaction/bloc/transaction_state.dart';
import 'package:fintracker/presentation/add_transaction/widget/enum_drop_down.dart';
import 'package:fintracker/presentation/add_transaction/widget/transaction_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class IncomeForm extends StatefulWidget {
  const IncomeForm({super.key});

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  IncomeCategory? selectedCategory;
  DateTime? _selectedDate;
  IncomeSource? source;
  bool _isFormSubmitted = false;

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void _clearForm() {
    setState(() {
      amountController.clear();
      descriptionController.clear();
      dateController.clear();
      selectedCategory = null;
      _selectedDate = null;
      source = null;
    });
    _formKey.currentState?.reset();
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
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Amount",
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
                controller: amountController,
                label: "Enter your amount",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validation: FormValidators.validateAmount,
              ),
              SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Category",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(height: AppRadius.small),
              EnumDropDown<IncomeCategory>(
                value: selectedCategory,
                labelText: "Select an income category",
                item: IncomeCategory.values,
                prefixIcon: Icon(
                  incomeCategoryIcon(selectedCategory),
                  color: AppColors.success,
                ),
                itemIcon: incomeCategoryIcon,
                iconColor: AppColors.success,
                onChanged: (value) {
                  setState(() => selectedCategory = value);
                  _formKey.currentState?.validate();
                },
              ),
              if (_isFormSubmitted && selectedCategory == null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Text(
                    FormValidators.validateCategory(selectedCategory) ?? "",
                    style: TextStyle(
                      color: AppColors.danger,
                      fontSize: 12,
                    ),
                  ),
                ),
              SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Wallet",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(height: AppRadius.small),
              EnumDropDown<IncomeSource>(
                value: source,
                labelText: "Wallet",
                item: IncomeSource.values,
                prefixIcon: Icon(
                  incomeSourceIcon(source),
                  color: AppColors.primary,
                ),
                itemIcon: incomeSourceIcon,
                iconColor: AppColors.primary,
                onChanged: (value) {
                  setState(() {
                    source = value;
                  });
                  _formKey.currentState?.validate();
                },
              ),
              if (_isFormSubmitted && source == null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Text(
                    FormValidators.validateWallet(source) ?? "",
                    style: TextStyle(
                      color: AppColors.danger,
                      fontSize: 12,
                    ),
                  ),
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
                validator: FormValidators.validateDate,
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
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 239, 68, 68)),
                  ),
                ),
                onTap: dateTime,
              ),
              SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Note (Optional)",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(height: AppRadius.small),
              TextFormField(
                controller: descriptionController,
                maxLines: 2,
                maxLength: 100,
                validator: FormValidators.validateDescription,
                onChanged: (value) {
                  setState(() {});
                },
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Enter description...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 239, 68, 68)),
                  ),
                ),
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
                    setState(() {
                      _isFormSubmitted = true;
                    });

                    if (_formKey.currentState!.validate() &&
                        selectedCategory != null &&
                        source != null &&
                        _selectedDate != null) {
                      final income = IncomeEntity(
                        amount: double.parse(amountController.text),
                        category: selectedCategory!,
                        description: descriptionController.text,
                        date: _selectedDate!,
                        source: source!,
                      );
                      context.read<TransactionBloc>().add(AddIncomeEvent(income));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please fill all required fields"),
                          backgroundColor: AppColors.danger,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                    ),
                  ),
                  child: Text(
                    "Save income",
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


