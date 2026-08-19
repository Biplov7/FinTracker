import 'package:ecommerce/domain/transaction/entities/expense_entity.dart';
import 'package:ecommerce/domain/transaction/entities/income_entity.dart';

abstract class TransactionRepositories {
  Future<void> addIncome(IncomeEntity income);
  Future<void> addExpense(ExpenseEntity expense);
}