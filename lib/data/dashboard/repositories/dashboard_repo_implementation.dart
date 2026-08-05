import 'package:ecommerce/data/dashboard/datasource/getdashboarddata.dart';
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
}
