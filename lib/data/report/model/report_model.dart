import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintracker/domain/report/entities/report_entities.dart';
import 'package:fintracker/domain/add_transaction/entities/expense_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';

class ReportModel extends ReportEntities {
  final Map<IncomeCategory, double> incomeByCategory;
  final Map<ExpenseCategory, double> expenseByCategory;
  final DateTime startDate;
  final DateTime endDate;

  ReportModel(
    super.totalIncome,
    super.totalExpense,
    super.expenseCategory,
    super.incomeCategory,
    this.incomeByCategory,
    this.expenseByCategory,
    this.endDate,
    this.startDate,
  );

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      (map['totalIncome'] as num).toDouble(),

      (map['totalExpense'] as num).toDouble(),

      ExpenseCategory.values.firstWhere(
        (category) => category.name == map['expenseCategory'],
      ),

      IncomeCategory.values.firstWhere(
        (category) => category.name == map['incomeCategory'],
      ),

      Map<IncomeCategory, double>.from(
        (map['incomeByCategory'] ?? {}).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),

      Map<ExpenseCategory, double>.from(
        (map['expenseByCategory'] ?? {}).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),

      (map['endDate'] as Timestamp).toDate(),

      (map['startDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,

      'expenseCategory': expenseCategory.name,
      'incomeCategory': incomeCategory.name,

      'incomeByCategory': incomeByCategory,
      'expenseByCategory': expenseByCategory,

      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
    };
  }
}
