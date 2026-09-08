import 'package:fintracker/data/add_transaction/datasource/transaction_datasource.dart';
import 'package:fintracker/data/add_transaction/model/expense_model.dart';
import 'package:fintracker/data/add_transaction/model/income_model.dart';
import 'package:fintracker/domain/add_transaction/entities/expense_entity.dart';
import 'package:fintracker/domain/add_transaction/entities/income_entity.dart';
import 'package:fintracker/domain/add_transaction/repositories/transaction_repositories.dart';

class TransactionRepoImplementation implements TransactionRepositories {
  final TransactionDatasource ds;
  TransactionRepoImplementation(this.ds);
  @override
  Future<void> addExpense(ExpenseEntity expense) async {
    final ExpenseModel model = ExpenseModel(
      id: expense.id,
      amount: expense.amount,
      category: expense.category,
      description: expense.description,
      date: expense.date,
      wallet: expense.wallet
    );
    await ds.addExpense(model);
  }

  @override
  Future<void> addIncome(IncomeEntity income) async{
    final IncomeModel model = IncomeModel(
      id: income.id,
      amount: income.amount,
      category: income.category,
      description: income.description,
      date: income.date,
      source: income.source
    );
    await ds.addIncome(model);
  }

  @override
  Future<void> setBudgetLimit(double budgetLimit) async {
    await ds.updateBudgetLimit(budgetLimit);
  }
  
}

