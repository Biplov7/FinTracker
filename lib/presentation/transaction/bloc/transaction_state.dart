import 'package:fintracker/domain/transaction/entity/transaction_entity.dart';
import 'package:fintracker/domain/transaction/enum/transaction_peroid.dart';
import 'package:fintracker/domain/transaction/entity/transaction_enum.dart';

abstract class TransactionState {}

class InitialState extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final List<TransactionEntity> transactions;
  final TransactionPeroid period;
  final TransactionEnum type;

  TransactionSuccess({
    required this.transactions,
    required this.period,
    required this.type,
  });
}

class TransactionFailure extends TransactionState {
  final String message;

  TransactionFailure(this.message);
}