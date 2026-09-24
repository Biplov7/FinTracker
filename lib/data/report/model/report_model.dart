import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintracker/domain/report/entities/report_entities.dart';
import 'package:fintracker/domain/add_transaction/entities/expense_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';

class ReportModel extends ReportEntities {
  ReportModel(
    super.totalIncome,
    super.totalExpense,
    super.expenseCategory,
    super.incomeCategory,
    super.incomeByCategory,
    super.expenseByCategory,
    super.startDate,
    super.endDate,
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
          (key, value) => MapEntry(
            IncomeCategory.values.firstWhere(
              (category) => category.name == key,
            ),
            (value as num).toDouble(),
          ),
        ),
      ),

      Map<ExpenseCategory, double>.from(
        (map['expenseByCategory'] ?? {}).map(
          (key, value) => MapEntry(
            ExpenseCategory.values.firstWhere(
              (category) => category.name == key,
            ),
            (value as num).toDouble(),
          ),
        ),
      ),

      (map['startDate'] as Timestamp).toDate(),

      (map['endDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,

      'expenseCategory': expenseCategory.name,
      'incomeCategory': incomeCategory.name,

      'incomeByCategory': incomeByCategory.map(
        (key, value) => MapEntry(key.name, value),
      ),

      'expenseByCategory': expenseByCategory.map(
        (key, value) => MapEntry(key.name, value),
      ),

      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
    };
  }
}