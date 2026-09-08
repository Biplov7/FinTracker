import 'package:fintracker/domain/add_transaction/entities/expense_entity.dart';
import 'package:fintracker/domain/add_transaction/entities/income_entity.dart';

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

class AddBudgetEvent extends TransactionEvent{
  final double budgetLimit;
  AddBudgetEvent(this.budgetLimit);
}
