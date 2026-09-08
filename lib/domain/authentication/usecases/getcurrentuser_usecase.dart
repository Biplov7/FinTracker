import 'package:fintracker/domain/authentication/entities/user_entity.dart';
import 'package:fintracker/domain/authentication/repositories/auth_repositories.dart';

class GetcurrentuserUsecase {
  final AuthRepositories repo;

  GetcurrentuserUsecase(this.repo);

  Future<UserEntity?> call(){
    return repo.getCurrentUser();
  }
}
