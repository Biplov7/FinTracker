import 'package:fintracker/domain/authentication/entities/signup_entity.dart';
import 'package:fintracker/domain/authentication/entities/user_entity.dart';
import 'package:fintracker/domain/authentication/repositories/auth_repositories.dart';
import 'package:fintracker/domain/dashboard/repositories/dashboard_repo.dart';

class SignupUsecase {
  final AuthRepositories repo;
  final DashboardRepo dashboardRepo;

  SignupUsecase(this.repo, this.dashboardRepo);

  Future<UserEntity> call(SignupEntity signup) async {
    final user = await repo.signUp(signup);
    await dashboardRepo.initializeUserDashboard(
      userId: user.id,
      username: user.username,
      email: user.email,
    );
    return user;
  }
}

