import 'package:fintracker/domain/transaction/entity/transaction_entity.dart';
import 'package:fintracker/domain/transaction/entity/transaction_filter.dart';

abstract class ViewtransactionRepostiories {
  Future<List<TransactionEntity>> loadTransaction(
    TransactionFilter filter,
  );
}
