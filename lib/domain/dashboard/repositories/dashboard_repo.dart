import 'package:ecommerce/domain/dashboard/entities/dashboard_entities.dart';

abstract class DashboardRepo {
  Future<DashboardEntities> getDashboardData();
  Future<void> initializeUserDashboard({
    required String userId,
    required String username,
    required String email,
  });
}
