import 'package:fintracker/domain/add_transaction/entities/expense_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';

class ReportEntities {
  final double totalIncome;
  final double totalExpense;
  final ExpenseCategory expenseCategory;
  final IncomeCategory incomeCategory;

  ReportEntities(
    this.totalIncome,
    this.totalExpense,
    this.expenseCategory,
    this.incomeCategory,
  );

  ReportEntities copyWith({
    double? totalIncome,
    double? totalExpense,
    ExpenseCategory? expenseCategory,
    IncomeCategory? incomeCategory,
  }) {
    return ReportEntities(
      totalIncome ?? this.totalIncome,
      totalExpense ?? this.totalExpense,
      expenseCategory ?? this.expenseCategory,
      incomeCategory ?? this.incomeCategory
    );
  }
}