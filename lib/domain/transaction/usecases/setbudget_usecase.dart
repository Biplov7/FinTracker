import 'package:ecommerce/domain/transaction/repositories/transaction_repositories.dart';

class SetBudgetUsecase {
  final TransactionRepositories repo;

  SetBudgetUsecase(this.repo);

  Future<void> call(double budgetLimit) {
    return repo.setBudgetLimit(budgetLimit);
  }
}
