import 'package:ecommerce/domain/transaction/entities/expense_category.dart';
import 'package:ecommerce/domain/transaction/entities/expense_wallet.dart';

class ExpenseEntity {
  final String id;
  final double amount;
  final ExpenseCategory category;
  final String description;
  final DateTime date;
  final ExpenseWallet wallet;

  const ExpenseEntity({
    this.id = '',
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
    required this.wallet
  });

  ExpenseEntity copyWith({
    String? id,
    double? amount,
    ExpenseCategory? category,
    String? description,
    DateTime? date,
    ExpenseWallet? wallet
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      wallet: wallet ?? this.wallet
    );
  }
}
