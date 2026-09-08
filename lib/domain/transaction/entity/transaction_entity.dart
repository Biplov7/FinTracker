import 'package:fintracker/domain/add_transaction/entities/expense_category.dart';
import 'package:fintracker/domain/add_transaction/entities/expense_wallet.dart';
import 'package:fintracker/domain/add_transaction/entities/income_category.dart';
import 'package:fintracker/domain/add_transaction/entities/income_source.dart';

class TransactionEntity {
  final String id;
  final double amount;
  final DateTime date;
  final ExpenseWallet? wallet;
  final IncomeSource? source;
  final ExpenseCategory? expenseCategory;
  final IncomeCategory? incomeCategory;

  TransactionEntity(
    this.id,
    this.amount,
    this.date,
    this.expenseCategory,
    this.incomeCategory,
    this.source,
    this.wallet,
  );

  TransactionEntity copyWith({
    String? id,
    double? amount,
    DateTime? date,
    ExpenseWallet? wallet,
    IncomeSource? source,
    ExpenseCategory? expenseCategory,
    IncomeCategory? incomeCategory,
  }) {
    return TransactionEntity(
      id ?? this.id,
      amount ?? this.amount,
      date ?? this.date,
      expenseCategory ?? this.expenseCategory,
      incomeCategory ?? this.incomeCategory,
      source ?? this.source,
      wallet ?? this.wallet,
    );
  }
}

