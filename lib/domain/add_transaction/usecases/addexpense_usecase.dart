import 'package:fintracker/domain/add_transaction/entities/expense_entity.dart';
import 'package:fintracker/domain/add_transaction/repositories/transaction_repositories.dart';

class AddexpenseUsecase {
  final TransactionRepositories repo;

  AddexpenseUsecase(this.repo);

  Future<void> call(ExpenseEntity expense){
    return repo.addExpense(expense);
  }
}
