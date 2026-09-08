import 'package:fintracker/data/transaction/datasource/gettransactiondata.dart';
import 'package:fintracker/domain/transaction/entity/transaction_entity.dart';
import 'package:fintracker/domain/transaction/entity/transaction_enum.dart';
import 'package:fintracker/domain/transaction/entity/transaction_filter.dart';
import 'package:fintracker/domain/transaction/repositories/viewtransaction_repostiories.dart';

class TransactionRepo implements ViewtransactionRepostiories{
  final Gettransactiondata ds;

  TransactionRepo(this.ds);
  @override
  Future<List<TransactionEntity>> loadTransaction(TransactionFilter filter) async {
    switch (filter.type) {
      case TransactionEnum.all:
        return await ds.getAllTransaction(filter);
      case TransactionEnum.income:
        return await ds.getIncomeTransaction(filter);
      case TransactionEnum.expense:
        return await ds.getExpenseTransaction(filter);
    }
  }
}