import 'dart:async';
import 'package:fintracker/data/add_transaction/model/expense_model.dart';
import 'package:fintracker/data/add_transaction/model/income_model.dart';
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
  Stream<ReportEntities> getReport(ReportPeroid peroid) {
    final now = DateTime.now();

    final startDate = _startingDate(now, peroid);
    final endDate = _endDate(now, peroid);

    final incomeStream = rs.getIncome(startDate: startDate, endDate: endDate);

    final expenseStream = rs.getExpense(startDate: startDate, endDate: endDate);

    return _combineStreams(incomeStream, expenseStream).map((data) {
      return _createReport(data.$1, data.$2, startDate, endDate);
    });
  }

  Stream<(List<IncomeModel>, List<ExpenseModel>)> _combineStreams(
    Stream<List<IncomeModel>> streamA,
    Stream<List<ExpenseModel>> streamB,
  ) {
    late StreamController<(List<IncomeModel>, List<ExpenseModel>)> controller;
    StreamSubscription? subA;
    StreamSubscription? subB;
    List<IncomeModel>? latestA;
    List<ExpenseModel>? latestB;

    void emitIfReady() {
      if (latestA != null && latestB != null && !controller.isClosed) {
        controller.add((latestA!, latestB!));
      }
    }

    controller = StreamController<(List<IncomeModel>, List<ExpenseModel>)>(
      onListen: () {
        subA = streamA.listen(
          (data) {
            latestA = data;
            emitIfReady();
          },
          onError: (e) {
            if (!controller.isClosed) controller.addError(e);
          },
        );
        subB = streamB.listen(
          (data) {
            latestB = data;
            emitIfReady();
          },
          onError: (e) {
            if (!controller.isClosed) controller.addError(e);
          },
        );
      },
      onCancel: () async {
        await subA?.cancel();
        await subB?.cancel();
      },
    );

    return controller.stream;
  }

  ReportEntities _createReport(
    List<IncomeModel> income,
    List<ExpenseModel> expense,
    DateTime startDate,
    DateTime endDate,
  ) {
    double totalIncome = 0;
    double totalExpense = 0;

    Map<IncomeCategory, double> incomeByCategory = {};
    Map<ExpenseCategory, double> expenseByCategory = {};

    for (final incomeValue in income) {
      totalIncome += incomeValue.amount;

      incomeByCategory[incomeValue.category] =
          (incomeByCategory[incomeValue.category] ?? 0) + incomeValue.amount;
    }

    for (final expenseValue in expense) {
      totalExpense += expenseValue.amount;

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
      topExpenseCategory = expenseByCategory.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
    }

    IncomeCategory topIncomeCategory = IncomeCategory.other;

    if (incomeByCategory.isNotEmpty) {
      topIncomeCategory = incomeByCategory.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
    }

    return ReportModel(
      totalIncome,
      totalExpense,
      topExpenseCategory,
      topIncomeCategory,
      incomeByCategory,
      expenseByCategory,
      startDate,
      endDate,
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
        return DateTime(now.year, now.month, now.day + 1);

      case ReportPeroid.monthly:
        return DateTime(now.year, now.month + 1, 1);

      case ReportPeroid.yearly:
        return DateTime(now.year + 1, 1, 1);
    }
  }

  double _calculatePercentage(double value, double totalValue) {
    if (totalValue == 0) {
      return 0;
    }

    return (value / totalValue) * 100;
  }
}
