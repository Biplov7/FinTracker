import 'package:ecommerce/domain/authentication/entities/user_entity.dart';
import 'package:ecommerce/domain/dashboard/entities/dashboard_entities.dart';
import 'package:ecommerce/domain/dashboard/entities/recent_transaction_entity.dart';

abstract class DashboardRepo {
  Future<DashboardEntities> getDashboardData();
  Future<void> initializeUserDashboard({
    required String userId,
    required String username,
    required String email,
  });

  Future<List<RecentTransactionEntity>> getRecentTransaction();
  Future<DashboardEntities> updateDashboardData();
  Future<UserEntity> getUserProfile();
}
