import 'package:fintracker/domain/add_transaction/entities/expense_entity.dart';
import 'package:fintracker/domain/add_transaction/entities/income_entity.dart';

abstract class TransactionRepositories {
  Future<void> addIncome(IncomeEntity income);
  Future<void> addExpense(ExpenseEntity expense);
  Future<void> setBudgetLimit(double budgetLimit);
}
