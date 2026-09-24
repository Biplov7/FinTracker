import 'package:fintracker/domain/add_transaction/entities/expense_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';

class ReportEntities {
  final double totalIncome;
  final double totalExpense;

  final ExpenseCategory expenseCategory;
  final IncomeCategory incomeCategory;

  final Map<IncomeCategory, double> incomeByCategory;
  final Map<ExpenseCategory, double> expenseByCategory;

  final DateTime startDate;
  final DateTime endDate;

  ReportEntities(
    this.totalIncome,
    this.totalExpense,
    this.expenseCategory,
    this.incomeCategory,
    this.incomeByCategory,
    this.expenseByCategory,
    this.startDate,
    this.endDate,
  );
}