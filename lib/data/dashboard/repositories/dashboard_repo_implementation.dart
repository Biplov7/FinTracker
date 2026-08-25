import 'package:ecommerce/data/authentication/model/user_model.dart';
import 'package:ecommerce/data/dashboard/datasource/getdashboarddata.dart';
import 'package:ecommerce/data/dashboard/model/dashboard_model.dart';
import 'package:ecommerce/data/dashboard/model/recent_transaction_model.dart';
import 'package:ecommerce/data/transaction/model/expense_model.dart';
import 'package:ecommerce/data/transaction/model/income_model.dart';
import 'package:ecommerce/domain/authentication/entities/user_entity.dart';
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

    final income = firstFiveIncome.map((income)=> RecentTransactionModel(income.id, TransactionType.income, income.category.name, income.amount, income.date)).toList();
    final expense = firstFiveExpense.map((expense)=> RecentTransactionModel(expense.id, TransactionType.expense, expense.category.name, expense.amount, expense.date)).toList();

    final result = [
      ...income ,
      ...expense
    ];

    result.sort((a, b) => b.date.compareTo(a.date),);
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
}
