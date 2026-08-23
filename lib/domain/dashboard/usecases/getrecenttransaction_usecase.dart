import 'package:ecommerce/domain/dashboard/entities/recent_transaction_entity.dart';
import 'package:ecommerce/domain/dashboard/repositories/dashboard_repo.dart';

class GetrecenttransactionUsecase {
  DashboardRepo repo;
  GetrecenttransactionUsecase(this.repo);

  Future<List<RecentTransactionEntity>> call(){
    return repo.getRecentTransaction();
  }
}