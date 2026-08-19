import 'package:ecommerce/domain/transaction/entities/income_entity.dart';
import 'package:ecommerce/domain/transaction/repositories/transaction_repositories.dart';

class AddincomeUsecase{
  final TransactionRepositories repo;

  AddincomeUsecase(this.repo);

  Future<void> call(IncomeEntity income){
    return repo.addIncome(income);
  }
}