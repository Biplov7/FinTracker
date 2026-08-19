import 'package:ecommerce/domain/transaction/entities/expense_entity.dart';
import 'package:ecommerce/domain/transaction/entities/income_entity.dart';

abstract class TransactionEvent {}


class InitialEvent extends TransactionEvent{}

class AddIncomeEvent extends TransactionEvent{
  final IncomeEntity entity;
  AddIncomeEvent(this.entity);
}

class AddExpenseEvent extends TransactionEvent{
  final ExpenseEntity entity;
  AddExpenseEvent(this.entity);
}