import 'package:ecommerce/domain/authentication/entities/user_entity.dart';
import 'package:ecommerce/domain/authentication/repositories/auth_repositories.dart';

class GetcurrentuserUsecase {
  final AuthRepositories repo;

  GetcurrentuserUsecase(this.repo);

  Future<UserEntity?> call(){
    return repo.getCurrentUser();
  }
}