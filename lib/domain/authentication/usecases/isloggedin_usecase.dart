import 'package:ecommerce/domain/authentication/repositories/auth_repositories.dart';

class IsloggedinUsecase {
  final AuthRepositories repo;

  IsloggedinUsecase(this.repo);

  Future<bool> call(){
    return repo.isLoggedIn();
  }
}