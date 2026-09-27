import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintracker/data/add_transaction/model/expense_model.dart';
import 'package:fintracker/data/add_transaction/model/income_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ReportDatasource(this.firestore, this.firebaseAuth);

  String get uid {
    final currentUser = firebaseAuth.currentUser?.uid;
    if (currentUser == null) {
      throw StateError('No user is signed in.');
    }
    return currentUser;
  }

  DocumentReference<Map<String, dynamic>> userDoc(String uid) {
    return firestore.collection('user').doc(uid);
  }

  CollectionReference<Map<String, dynamic>> incomeCollection(String uid) {
    return userDoc(uid).collection('income');
  }

  CollectionReference<Map<String, dynamic>> expenseCollection(String uid) {
    return userDoc(uid).collection('expense');
  }

  Stream<List<IncomeModel>> getIncome({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return incomeCollection(uid)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where('date', isLessThan: Timestamp.fromDate(endDate))
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((income) {
            return IncomeModel.fromMap(income.data());
          }).toList();
        });
  }

  Stream<List<ExpenseModel>> getExpense({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return expenseCollection(uid)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .where('date', isLessThan: Timestamp.fromDate(endDate))
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((expense) {
            return ExpenseModel.fromMap(expense.data());
          }).toList();
        });
  }
}
