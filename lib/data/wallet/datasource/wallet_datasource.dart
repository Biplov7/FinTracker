import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintracker/data/add_transaction/model/expense_model.dart';
import 'package:fintracker/data/add_transaction/model/income_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  WalletDatasource(this.firestore, this.auth);

  String get uid {
    final uid = auth.currentUser?.uid;
    if (uid != null) {
      return uid;
    } else {
      throw StateError("No user is signed in");
    }
  }

  CollectionReference<Map<String, dynamic>> get user {
    return firestore.collection('user');
  }

  DocumentReference<Map<String, dynamic>> userDoc(String uid) {
    return user.doc(uid);
  }

  CollectionReference<Map<String, dynamic>> incomeCollection(String uid) {
    return userDoc(uid).collection('income');
  }

  CollectionReference<Map<String, dynamic>> expenseCollection(String uid) {
    return userDoc(uid).collection('expense');
  }

  Future<List<IncomeModel>> getAllIncome() async {
    try {
      final incomeSnapshot = await incomeCollection(uid).get();

      final incomeTransaction = incomeSnapshot.docs.map((income) {
        return IncomeModel.fromMap(income.data());
      }).toList();

      return incomeTransaction;
    } catch (e) {
      throw Exception("Error in fetching the income ${e.toString()}");
    }
  }

  Future<List<ExpenseModel>> getAllExpense() async {
    try {
      final expenseSnapshot = await expenseCollection(uid).get();

      final expenseTransaction = expenseSnapshot.docs.map((expense) {
        return ExpenseModel.fromMap(expense.data());
      }).toList();

      return expenseTransaction;
    } catch (e) {
      throw Exception("Error in fetching the expense ${e.toString()}");
    }
  }
}
