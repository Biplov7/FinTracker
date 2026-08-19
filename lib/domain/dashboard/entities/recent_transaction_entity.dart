import 'package:ecommerce/presentation/transaction/screen/add_transaction_screen.dart';

class RecentTransactionEntity {
  final String id;
  final TransactionType type;
  final double amount;
  final String category;
  final DateTime date;

  RecentTransactionEntity(
    this.id,
    this.type,
    this.amount,
    this.category,
    this.date,
  );

  RecentTransactionEntity copyWith({
    String? id,
    TransactionType? type,
    double? amount,
    String? category,
    DateTime? date,
  }) {
    return RecentTransactionEntity(
      id ?? this.id,
      type ?? this.type,
      amount ?? this.amount,
      category ?? this.category,
      date ?? this.date,
    );
  }
}