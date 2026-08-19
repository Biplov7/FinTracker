import 'package:ecommerce/data/authentication/model/user_model.dart';
import 'package:ecommerce/data/dashboard/datasource/getdashboarddata.dart';
import 'package:ecommerce/data/dashboard/model/dashboard_model.dart';
import 'package:ecommerce/domain/dashboard/entities/dashboard_entities.dart';
import 'package:ecommerce/domain/dashboard/repositories/dashboard_repo.dart';

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
}
