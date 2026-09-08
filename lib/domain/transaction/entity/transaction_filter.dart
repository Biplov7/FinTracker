import 'package:fintracker/domain/transaction/entity/transaction_enum.dart';

class TransactionFilter {
  TransactionEnum type;
  DateTime startDate;
  DateTime endDate;

  TransactionFilter({
    required this.type,
    required this.startDate,
    required this.endDate,
  });
}