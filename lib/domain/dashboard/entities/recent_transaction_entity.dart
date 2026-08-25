import 'package:ecommerce/presentation/transaction/screen/add_transaction_screen.dart';

class RecentTransactionEntity {
  final String id;
  final TransactionType type;
  final String category;
  final double amount;
  final DateTime date;

  RecentTransactionEntity(
    this.id,
    this.type,
    this.category,
    this.amount,
    this.date,
  );

  RecentTransactionEntity copyWith({
    String? id,
    TransactionType? type,
    String? category,
    double? amount,
    DateTime? date,
  }) {
    return RecentTransactionEntity(
      id ?? this.id,
      type ?? this.type,
      category ?? this.category,
      amount ?? this.amount,
      date ?? this.date,
    );
  }
}