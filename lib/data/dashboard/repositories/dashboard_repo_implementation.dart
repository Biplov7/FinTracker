import 'package:fintracker/data/authentication/model/user_model.dart';
import 'package:fintracker/data/dashboard/datasource/getdashboarddata.dart';
import 'package:fintracker/data/dashboard/model/dashboard_model.dart';
import 'package:fintracker/data/dashboard/model/recent_transaction_model.dart';
import 'package:fintracker/data/add_transaction/model/expense_model.dart';
import 'package:fintracker/data/add_transaction/model/income_model.dart';
import 'package:fintracker/domain/authentication/entities/user_entity.dart';
import 'package:fintracker/domain/dashboard/entities/dashboard_entities.dart';
import 'package:fintracker/domain/dashboard/entities/recent_transaction_entity.dart';
import 'package:fintracker/domain/dashboard/repositories/dashboard_repo.dart';
import 'package:fintracker/domain/add_transaction/entities/transaction_type.dart';

class DashboardRepoImplementation implements DashboardRepo {
  final Getdashboarddata ds;
  DashboardRepoImplementation(this.ds);
  @override
  Future<DashboardEntities> getDashboardData() async {
    final result = await ds.getDashboardData();
    return DashboardEntities(
      result.currentBalance,
      result.totalIncome,
      result.totalExpenses,
      result.totalSaving,
      result.budgetUsed,
      result.budgetLimit,
    );
  }

  @override
  Future<void> initializeUserDashboard({
    required String userId,
    required String username,
    required String email,
  }) async {
    await ds.createDefaultProfile(
      userId,
      UserModel(id: userId, username: username, email: email),
    );
    await ds.createDefaultDashboard(userId, DashboardModel(0, 0, 0, 0, 0, 0));
  }

  @override
  Future<List<RecentTransactionEntity>> getRecentTransaction() async {
    // Run both queries in parallel instead of sequentially
    final results = await Future.wait([
      ds.getFirstFiveIncome(),
      ds.getFirstFiveExpense(),
    ]);

    final firstFiveIncome = results[0] as List<IncomeModel>;
    final firstFiveExpense = results[1] as List<ExpenseModel>;

    final income = firstFiveIncome
        .map((income) => RecentTransactionModel(
              income.id,
              TransactionType.income,
              income.category.name,
              income.amount,
              income.date,
            ))
        .toList();
    final expense = firstFiveExpense
        .map((expense) => RecentTransactionModel(
              expense.id,
              TransactionType.expense,
              expense.category.name,
              expense.amount,
              expense.date,
            ))
        .toList();

    final result = [...income, ...expense];
    result.sort((a, b) => b.date.compareTo(a.date));
    final transaction = result.take(5).toList();
    return transaction;
  }

  @override
  Future<DashboardEntities> updateDashboardData() async {
    final result = await ds.calculateDashboard();
    return DashboardEntities(
      result.currentBalance,
      result.totalIncome,
      result.totalExpenses,
      result.totalSaving,
      result.budgetUsed,
      result.budgetLimit,
    );
  }

  @override
  Future<UserEntity> getUserProfile() async {
    final result = await ds.getUserProfile();
    return UserEntity(
      id: result.id,
      username: result.username,
      email: result.email,
    );
  }

  @override
  Stream<DashboardEntities> streamDashboardData() {
    return ds.streamDashboardData().map((model) => DashboardEntities(
          model.currentBalance,
          model.totalIncome,
          model.totalExpenses,
          model.totalSaving,
          model.budgetUsed,
          model.budgetLimit,
        ));
  }

  @override
  Stream<List<RecentTransactionEntity>> streamRecentTransactions() {
    return ds.streamRecentTransactions().map((transactions) {
      List<IncomeModel> incomes = [];
      List<ExpenseModel> expenses = [];

      for (var transaction in transactions) {
        if (transaction is IncomeModel) {
          incomes.add(transaction);
        } else if (transaction is ExpenseModel) {
          expenses.add(transaction);
        }
      }

      final income = incomes
          .map((inc) => RecentTransactionModel(
              inc.id, TransactionType.income, inc.category.name, inc.amount, inc.date))
          .toList();
      final expense = expenses
          .map((exp) => RecentTransactionModel(
              exp.id, TransactionType.expense, exp.category.name, exp.amount, exp.date))
          .toList();

      final result = [...income, ...expense];
      result.sort((a, b) => b.date.compareTo(a.date));
      return result.take(5).toList();
    });
  }
}

