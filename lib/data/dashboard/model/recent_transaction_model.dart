import 'package:fintracker/domain/dashboard/entities/recent_transaction_entity.dart';
import 'package:fintracker/domain/add_transaction/entities/transaction_type.dart';

class RecentTransactionModel extends RecentTransactionEntity {
  RecentTransactionModel(
    super.id,
    super.type,
    super.category,
    super.amount,
    super.date,
  );

  factory RecentTransactionModel.fromMap(Map<String, dynamic> map) {
    return RecentTransactionModel(
      map['id'] as String,
      map['type'] as TransactionType,
      map['category'] as String,
      (map['amount'] as num).toDouble(),
      DateTime.parse(map['date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'category': category,
      'amount': amount,
      'date': date.toString(),
    };
  }
}
