import 'package:fintracker/domain/wallet/entities/wallet_entities.dart';
import 'package:fintracker/domain/wallet/repositories/wallet_repositories.dart';

class GetAmountUsecases {
  final WalletRepositories repo;
  GetAmountUsecases(this.repo);

  Future<WalletEntities> call(){
    return repo.getAmountInformation();
  }
}