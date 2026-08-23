import 'package:ecommerce/domain/dashboard/entities/recent_transaction_entity.dart';
import 'package:ecommerce/presentation/transaction/screen/add_transaction_screen.dart';

class RecentTransactionModel extends RecentTransactionEntity {
  RecentTransactionModel(
    super.id,
    super.type,
    super.amount,
    super.date,
  );

  factory RecentTransactionModel.fromMap(Map<String, dynamic> map) {
    return RecentTransactionModel(
      map['id'] as String,
      map['type'] as TransactionType,
      (map['amount'] as num).toDouble(),
      DateTime.parse(map['date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'date': date.toString(),
    };
  }
}