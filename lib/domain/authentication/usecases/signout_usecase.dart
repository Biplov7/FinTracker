import 'package:fintracker/domain/authentication/repositories/auth_repositories.dart';

class SignoutUsecase {
  final AuthRepositories repo;

  SignoutUsecase(this.repo);

  Future<void> call(){
    return repo.signOut();
  }
}
