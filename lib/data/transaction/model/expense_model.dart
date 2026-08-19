import 'package:ecommerce/domain/transaction/entities/expense_entity.dart';
import 'package:ecommerce/domain/transaction/entities/expense_category.dart';
import 'package:ecommerce/domain/transaction/entities/expense_wallet.dart';

class ExpenseModel extends ExpenseEntity {
  ExpenseModel({
    required super.id,
    required super.amount,
    required super.category,
    required super.description,
    required super.date,
    required super.wallet
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: ExpenseCategory.values.byName(map['category'] as String),
      description: map['description'] as String,
      date: DateTime.parse(map['date'] as String),
      wallet: ExpenseWallet.values.byName(
        (map['wallet'] as String).split('.').last,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category.name,
      'description': description,
      'date': date.toIso8601String(),
      'wallet': wallet.name,
    };
  }
}
