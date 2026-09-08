import 'package:fintracker/domain/transaction/entity/transaction_entity.dart';
import 'package:fintracker/domain/transaction/entity/transaction_enum.dart';
import 'package:fintracker/domain/transaction/entity/transaction_filter.dart';
import 'package:fintracker/domain/transaction/repositories/viewtransaction_repostiories.dart';

class LoadtransactionUsecases {
  final ViewtransactionRepostiories repo;

  LoadtransactionUsecases(this.repo);

  Future<List<TransactionEntity>> call({
    required TransactionEnum type,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return repo.loadTransaction(
      TransactionFilter(type: type, startDate: startDate, endDate: endDate),
    );
  }
}

