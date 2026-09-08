import 'package:fintracker/domain/dashboard/entities/dashboard_entities.dart';
import 'package:fintracker/domain/dashboard/repositories/dashboard_repo.dart';

class UpdatedashboarddataUsecase {
  DashboardRepo repo;
  UpdatedashboarddataUsecase(this.repo);

  Future<DashboardEntities> call() {
    return repo.updateDashboardData();
  }
}

