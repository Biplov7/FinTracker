import 'package:fintracker/domain/add_transaction/entities/expense_category.dart';

class ReportEntities {
  final double totalIncome;
  final double totalExpense;
  final ExpenseCategory expenseCategory;

  ReportEntities(
    this.totalIncome,
    this.totalExpense,
    this.expenseCategory,
  );

  ReportEntities copyWith({
    double? totalIncome,
    double? totalExpense,
    ExpenseCategory? expenseCategory,
  }) {
    return ReportEntities(
      totalIncome ?? this.totalIncome,
      totalExpense ?? this.totalExpense,
      expenseCategory ?? this.expenseCategory,
    );
  }
}