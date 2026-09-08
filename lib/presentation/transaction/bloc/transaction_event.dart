import 'package:fintracker/domain/transaction/enum/transaction_peroid.dart';
import 'package:fintracker/domain/transaction/entity/transaction_enum.dart';

abstract class TransactionEvent {}

class InitialEvent extends TransactionEvent {}

class LoadTransactionEvent extends TransactionEvent {
  final TransactionPeroid period;
  final TransactionEnum type;

  LoadTransactionEvent({
    required this.period,
    required this.type,
  });
}