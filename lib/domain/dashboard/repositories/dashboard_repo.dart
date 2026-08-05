import 'package:ecommerce/domain/dashboard/entities/dashboard_entities.dart';

abstract class DashboardRepo {
  Future<DashboardEntities> getDashboardData();
}