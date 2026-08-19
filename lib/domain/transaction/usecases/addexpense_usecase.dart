import 'package:ecommerce/domain/transaction/entities/expense_entity.dart';
import 'package:ecommerce/domain/transaction/repositories/transaction_repositories.dart';

class AddexpenseUsecase {
  final TransactionRepositories repo;

  AddexpenseUsecase(this.repo);

  Future<void> call(ExpenseEntity expense){
    return repo.addExpense(expense);
  }
}