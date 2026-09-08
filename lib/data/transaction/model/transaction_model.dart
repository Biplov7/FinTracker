import 'package:fintracker/domain/transaction/entity/transaction_entity.dart';
import 'package:fintracker/domain/add_transaction/entities/expense_category.dart';
import 'package:fintracker/domain/add_transaction/entities/expense_wallet.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_source.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel(
    super.id,
    super.amount,
    super.date,
    super.expenseCategory,
    super.incomeCategory,
    super.source,
    super.wallet,
  );

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      map['id'] as String,
      (map['amount'] as num).toDouble(),
      DateTime.parse(map['date'] as String),

      map['expenseCategory'] != null
          ? ExpenseCategory.values.byName(map['expenseCategory'] as String)
          : null,

      map['incomeCategory'] != null
          ? IncomeCategory.values.byName(map['incomeCategory'] as String)
          : null,

      map['source'] != null
          ? IncomeSource.values.byName(map['source'] as String)
          : null,

      map['wallet'] != null
          ? ExpenseWallet.values.byName(map['wallet'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'expenseCategory': expenseCategory?.name,
      'incomeCategory': incomeCategory?.name,
      'source': source?.name,
      'wallet': wallet?.name,
    };
  }
}

