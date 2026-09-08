import 'package:fintracker/domain/authentication/entities/user_entity.dart';
import 'package:fintracker/domain/dashboard/repositories/dashboard_repo.dart';

class GetUserProfileUseCase {
  final DashboardRepo repo;

  GetUserProfileUseCase(this.repo);

  Future<UserEntity> call() {
    return repo.getUserProfile();
  }
}

