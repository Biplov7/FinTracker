import 'package:ecommerce/domain/authentication/entities/login_entity.dart';
import 'package:ecommerce/domain/authentication/entities/user_entity.dart';
import 'package:ecommerce/domain/authentication/repositories/auth_repositories.dart';

class SigninUsecase {
  final AuthRepositories repo;

  SigninUsecase(this.repo);

  Future<UserEntity> call(LoginEntity login){
    return repo.signIn(login);
  }
}