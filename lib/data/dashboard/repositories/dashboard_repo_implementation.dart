import 'package:ecommerce/data/authentication/model/user_model.dart';
import 'package:ecommerce/data/dashboard/datasource/getdashboarddata.dart';
import 'package:ecommerce/data/dashboard/model/dashboard_model.dart';
import 'package:ecommerce/data/dashboard/model/recent_transaction_model.dart';
import 'package:ecommerce/data/transaction/model/expense_model.dart';
import 'package:ecommerce/data/transaction/model/income_model.dart';
import 'package:ecommerce/domain/dashboard/entities/dashboard_entities.dart';
import 'package:ecommerce/domain/dashboard/entities/recent_transaction_entity.dart';
import 'package:ecommerce/domain/dashboard/repositories/dashboard_repo.dart';
import 'package:ecommerce/presentation/transaction/screen/add_transaction_screen.dart';

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
    List<IncomeModel> firstFiveIncome = await ds.getFirstFiveIncome();
    List<ExpenseModel> firstFiveExpense = await ds.getFirstFiveExpense();

    final incomeTransaction = firstFiveIncome.map((income) {
      return RecentTransactionModel(
        income.id,
        TransactionType.income,
        income.amount,
        income.date,
      );
    });

    final expenseTransaction = firstFiveExpense.map((expense) {
      return RecentTransactionModel(
        expense.id,
        TransactionType.expense,
        expense.amount,
        expense.date,
      );
    });

    final transaction = [...incomeTransaction, ...expenseTransaction];
    transaction.sort((a, b) => b.date.compareTo(a.date));

    return transaction;
  }

  @override
  Future<void> setBudgetLimit(double budgetLimit) async {
    await ds.updateBudgetLimit(budgetLimit);
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
}
