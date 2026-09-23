import 'package:fintracker/data/report/datasource/report_datasource.dart';
import 'package:fintracker/data/report/model/report_model.dart';
import 'package:fintracker/domain/add_transaction/entities/expense_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';
import 'package:fintracker/domain/report/entities/report_entities.dart';
import 'package:fintracker/domain/report/entities/report_peroid.dart';
import 'package:fintracker/domain/report/repositories/report_repos.dart';

class ReportRepositoires implements ReportRepo {
  final ReportDatasource rs;
  ReportRepositoires(this.rs);
  @override
  Future<ReportEntities> getReport(ReportPeroid peroid) async {
    final now = DateTime.now();
    double totalIncome = 0;
    double totalExpense = 0;
    Map<IncomeCategory, double> incomeByCategory = {};
    Map<ExpenseCategory, double> expenseByCategory = {};
    final income = await rs.getIncome(
      startDate: _startingDate(now, peroid),
      endDate: _endDate(now, peroid),
    );
    final expense = await rs.getExpense(
      startDate: _startingDate(now, peroid),
      endDate: _endDate(now, peroid),
    );

    for (var incomeValue in income) {
      totalIncome = totalIncome + incomeValue.amount;
      incomeByCategory[incomeValue.category] =
          (incomeByCategory[incomeValue.category] ?? 0) + incomeValue.amount;
    }

    for (var expenseValue in expense) {
      totalExpense = totalExpense + expenseValue.amount;
      expenseByCategory[expenseValue.category] =
          (expenseByCategory[expenseValue.category] ?? 0) + expenseValue.amount;
    }

    expenseByCategory = expenseByCategory.map((key, value) {
      return MapEntry(key, _calculatePercentage(value, totalExpense));
    });

    incomeByCategory = incomeByCategory.map((key, value) {
      return MapEntry(key, _calculatePercentage(value, totalIncome));
    });

    ExpenseCategory topExpenseCategory = ExpenseCategory.other;
    if (expenseByCategory.isNotEmpty) {
      final topCategory = expenseByCategory.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
      topExpenseCategory = topCategory;
    }

    IncomeCategory topIncomeCategory = IncomeCategory.other;
    if (incomeByCategory.isNotEmpty) {
      final topCategory = incomeByCategory.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
      topIncomeCategory = topCategory;
    }

    return ReportModel(
      totalIncome,
      totalExpense,
      topExpenseCategory,
      topIncomeCategory,
      incomeByCategory,
      expenseByCategory,
      _startingDate(now, peroid),
      _endDate(now, peroid),
    );
  }

  DateTime _startingDate(DateTime now, ReportPeroid peroid) {
    switch (peroid) {
      case ReportPeroid.daily:
        return DateTime(now.year, now.month, now.day);
      case ReportPeroid.monthly:
        return DateTime(now.year, now.month, 1);
      case ReportPeroid.yearly:
        return DateTime(now.year, 1, 1);
    }
  }

  DateTime _endDate(DateTime now, ReportPeroid peroid) {
    switch (peroid) {
      case ReportPeroid.daily:
        return DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
      case ReportPeroid.monthly:
        final nextMonth = now.month == 12
            ? DateTime(now.year + 1, 1, 1)
            : DateTime(now.year, now.month + 1, 1);
        return nextMonth.subtract(Duration(milliseconds: 1));
      case ReportPeroid.yearly:
        return DateTime(now.year + 1, 12, 31, 23, 59, 59, 999);
    }
  }

  double _calculatePercentage(double value, double totalValue) {
    return (value / totalValue) * 100;
  }
}
