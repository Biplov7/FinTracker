import 'package:ecommerce/domain/transaction/entities/expense_category.dart';
import 'package:ecommerce/domain/transaction/entities/expense_wallet.dart';
import 'package:ecommerce/domain/transaction/entities/income_category.dart';
import 'package:ecommerce/domain/transaction/entities/income_source.dart';
import 'package:flutter/material.dart';

IconData incomeCategoryIcon(IncomeCategory? category) {
  return switch (category) {
    IncomeCategory.salary => Icons.payments_outlined,
    IncomeCategory.freelance => Icons.laptop_mac_outlined,
    IncomeCategory.business => Icons.store_outlined,
    IncomeCategory.investment => Icons.trending_up_outlined,
    IncomeCategory.rentalIncome => Icons.home_work_outlined,
    IncomeCategory.interest => Icons.savings_outlined,
    IncomeCategory.gift => Icons.card_giftcard_outlined,
    IncomeCategory.other => Icons.more_horiz,
    null => Icons.add_chart_outlined,
  };
}

IconData expenseCategoryIcon(ExpenseCategory? category) {
  return switch (category) {
    ExpenseCategory.food => Icons.restaurant_outlined,
    ExpenseCategory.shopping => Icons.shopping_bag_outlined,
    ExpenseCategory.transport => Icons.directions_car_outlined,
    ExpenseCategory.bills => Icons.receipt_long_outlined,
    ExpenseCategory.entertainment => Icons.movie_outlined,
    ExpenseCategory.health => Icons.local_hospital_outlined,
    ExpenseCategory.education => Icons.school_outlined,
    ExpenseCategory.other => Icons.more_horiz,
    null => Icons.receipt_long_outlined,
  };
}

IconData incomeSourceIcon(IncomeSource? source) {
  return switch (source) {
    IncomeSource.nabilBank => Icons.account_balance_outlined,
    IncomeSource.esewa => Icons.account_balance_wallet_outlined,
    IncomeSource.savingAccount => Icons.savings_outlined,
    null => Icons.account_balance_wallet_outlined,
  };
}

IconData expenseWalletIcon(ExpenseWallet? wallet) {
  return switch (wallet) {
    ExpenseWallet.cash => Icons.payments_outlined,
    ExpenseWallet.creditCard => Icons.credit_card_outlined,
    null => Icons.account_balance_wallet_outlined,
  };
}
