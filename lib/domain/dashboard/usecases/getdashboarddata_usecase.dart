import 'package:ecommerce/domain/dashboard/entities/dashboard_entities.dart';
import 'package:ecommerce/domain/dashboard/entities/recent_transaction_entity.dart';
import 'package:ecommerce/domain/dashboard/repositories/dashboard_repo.dart';

class GetdashboarddataUsecase {
  final DashboardRepo repo;

  GetdashboarddataUsecase(this.repo);

  Future<DashboardEntities> call(){
    return repo.getDashboardData();
  }

  Stream<DashboardEntities> streamDashboardData() {
    return repo.streamDashboardData();
  }

  Stream<List<RecentTransactionEntity>> streamRecentTransactions() {
    return repo.streamRecentTransactions();
  }
}
