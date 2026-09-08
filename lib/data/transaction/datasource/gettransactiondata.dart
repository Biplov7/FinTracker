import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintracker/data/add_transaction/model/expense_model.dart';
import 'package:fintracker/data/add_transaction/model/income_model.dart';
import 'package:fintracker/data/transaction/model/transaction_model.dart';
import 'package:fintracker/domain/transaction/entity/transaction_filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Gettransactiondata {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  Gettransactiondata(this.firestore, this.auth);

  String get user {
    final uid = auth.currentUser?.uid;

    if (uid == null) {
      throw StateError("No user is signed in");
    }
    return uid;
  }

  CollectionReference<Map<String, dynamic>> get users =>
      firestore.collection('user');

  DocumentReference<Map<String, dynamic>> userDoc(String uid) {
    return users.doc(uid);
  }

  CollectionReference<Map<String, dynamic>> income(String uid) {
    return userDoc(uid).collection('income');
  }

  CollectionReference<Map<String, dynamic>> expense(String uid) {
    return userDoc(uid).collection('expense');
  }

  Future<List<TransactionModel>> getAllTransaction(
    TransactionFilter filter,
  ) async {
    final incomeSnapshot = await income(user)
        .where('date', isGreaterThanOrEqualTo: filter.startDate)
        .where('date', isLessThan: filter.endDate)
        .get();

    final expenseSnapshot = await expense(user)
        .where('date', isGreaterThanOrEqualTo: filter.startDate)
        .where('date', isLessThan: filter.endDate)
        .get();

    final incomeTransaction = incomeSnapshot.docs.map((e) {
      final incomeData = IncomeModel.fromMap(e.data());
      // Convert IncomeModel to TransactionModel
      return TransactionModel(
        incomeData.id,
        incomeData.amount,
        incomeData.date,
        null, // expenseCategory
        incomeData.category, // incomeCategory
        incomeData.source,
        null, // wallet
      );
    });

    final expenseTransaction = expenseSnapshot.docs.map((e) {
      final expenseData = ExpenseModel.fromMap(e.data());
      // Convert ExpenseModel to TransactionModel
      return TransactionModel(
        expenseData.id,
        expenseData.amount,
        expenseData.date,
        expenseData.category, // expenseCategory
        null, // incomeCategory
        null, // source
        expenseData.wallet,
      );
    });

    final allTransaction = [
      ...incomeTransaction,
      ...expenseTransaction,
    ].toList();

    allTransaction.sort((a, b) {
      return b.date.compareTo(a.date);
    },);

    return allTransaction;
  }

  Future<List<TransactionModel>> getIncomeTransaction(
    TransactionFilter filter,
  ) async {
    final incomeTransaction = await income(user)
        .where('date', isGreaterThanOrEqualTo: filter.startDate)
        .where('date', isLessThan: filter.endDate)
        .get();

    final incomeTran = incomeTransaction.docs.map((e) {
      final incomeData = IncomeModel.fromMap(e.data());
      // Convert IncomeModel to TransactionModel
      return TransactionModel(
        incomeData.id,
        incomeData.amount,
        incomeData.date,
        null, // expenseCategory
        incomeData.category, // incomeCategory
        incomeData.source,
        null, // wallet
      );
    }).toList();

    return incomeTran;
  }

  Future<List<TransactionModel>> getExpenseTransaction(
    TransactionFilter filter,
  ) async {
    final expesnses = await expense(user)
        .where('date', isGreaterThanOrEqualTo: filter.startDate)
        .where('date', isLessThan: filter.endDate)
        .get();

    final expenseTrans = expesnses.docs.map((e) {
      final expenseData = ExpenseModel.fromMap(e.data());
      // Convert ExpenseModel to TransactionModel
      return TransactionModel(
        expenseData.id,
        expenseData.amount,
        expenseData.date,
        expenseData.category,
        null, 
        null, 
        expenseData.wallet,
      );
    }).toList();

    return expenseTrans;
  }
}