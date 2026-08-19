import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/transaction/model/expense_model.dart';
import 'package:ecommerce/data/transaction/model/income_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  TransactionDatasource(this.firestore, this.firebaseAuth);

  String get uid {
    final currentUserId = firebaseAuth.currentUser?.uid;
    if (currentUserId == null) {
      throw StateError('No user is signed in.');
    }
    return currentUserId;
  }

  CollectionReference<Map<String, dynamic>> get user =>
      firestore.collection('user');

  CollectionReference<Map<String, dynamic>> get expense =>
      firestore.collection('expense');

  CollectionReference<Map<String, dynamic>> get income =>
      firestore.collection('income');

  DocumentReference<Map<String, dynamic>> userDoc() {
    return user.doc(uid);
  }

  CollectionReference<Map<String, dynamic>> expenseCollection() {
    return userDoc().collection("expense");
  }

  CollectionReference<Map<String, dynamic>> incomeCollection() {
    return userDoc().collection("income");
  }

  Future<void> addIncome(IncomeModel income) async {
    final document = incomeCollection().doc();
    await document.set({
      ...income.toMap(),
      'id': document.id,
    });
  }

  Future<void> addExpense(ExpenseModel expense) async {
    final document = expenseCollection().doc();
    await document.set({
      ...expense.toMap(),
      'id': document.id,
    });
  }
}
