
import 'package:ecommerce/domain/authentication/entities/signup_entity.dart';
import 'package:ecommerce/domain/authentication/entities/user_entity.dart';
import 'package:ecommerce/domain/authentication/repositories/auth_repositories.dart';

class SignupUsecase {
  final AuthRepositories repo;
  SignupUsecase(this.repo);

  Future<UserEntity> call(SignupEntity signup){
    return repo.signUp(signup);
  }
}