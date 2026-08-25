import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/authentication/model/user_model.dart';
import 'package:ecommerce/data/dashboard/model/dashboard_model.dart';
import 'package:ecommerce/data/transaction/model/expense_model.dart';
import 'package:ecommerce/data/transaction/model/income_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Getdashboarddata {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  Getdashboarddata(this.firestore, this.firebaseAuth);

  CollectionReference<Map<String, dynamic>> get user =>
      firestore.collection('user');

  CollectionReference<Map<String, dynamic>> get profile =>
      firestore.collection('profile');

  CollectionReference<Map<String, dynamic>> get dashboard =>
      firestore.collection('dashboard');

  DocumentReference<Map<String, dynamic>> userDoc(String uid) {
    return user.doc(uid);
  }

  CollectionReference<Map<String, dynamic>> dashboardCollection(String uid) {
    return userDoc(uid).collection("dashboard");
  }

  CollectionReference<Map<String, dynamic>> profileCollection(String uid) {
    return userDoc(uid).collection('profile');
  }

  CollectionReference<Map<String, dynamic>> expenseCollection(String uid) {
    return userDoc(uid).collection('expense');
  }

  CollectionReference<Map<String, dynamic>> incomeCollection(String uid) {
    return userDoc(uid).collection('income');
  }

  Future<DashboardModel> getDashboardData() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) {
      throw StateError('No user is signed in.');
    }
    final snapshot = await dashboardCollection(uid).doc('summary').get();
    return DashboardModel.fromMap(snapshot.data()!);
  }

  Future<void> createDefaultProfile(String uid, UserModel user) async {
    await profileCollection(
      uid,
    ).doc('detail').set(user.toMap(), SetOptions(merge: true));
  }

  Future<UserModel> getUserProfile() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) {
      throw StateError('No user is signed in.');
    }
    final snapshot = await profileCollection(uid).doc('detail').get();
    return UserModel.fromMap(snapshot.data()!);
  }

  Future<void> createDefaultDashboard(
    String uid,
    DashboardModel dashboard,
  ) async {
    await dashboardCollection(
      uid,
    ).doc('summary').set(dashboard.toMap(), SetOptions(merge: true));
  }

  Future<List<ExpenseModel>> getAllModel() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) {
      throw StateError('No user is signed in');
    }
    final snapshot = await expenseCollection(
      uid,
    ).orderBy('date', descending: true).limit(5).get();

    return snapshot.docs.map((doc) {
      return ExpenseModel.fromMap({...doc.data(), 'id': doc.id});
    }).toList();
  }

  Future<List<IncomeModel>> getFirstFiveIncome() async {
    final uid = firebaseAuth.currentUser?.uid;

    if (uid == null) {
      throw StateError("No user is signed in");
    }
    final snapshot = await incomeCollection(
      uid,
    ).orderBy('date', descending: true).limit(5).get();
    return snapshot.docs.map((e) {
      return IncomeModel.fromMap({...e.data(), 'id': e.id});
    }).toList();
  }

  Future<List<ExpenseModel>> getFirstFiveExpense() async {
    final uid = firebaseAuth.currentUser?.uid;

    if (uid == null) {
      throw StateError('No user is signed in');
    }
    final snapshot = await expenseCollection(
      uid,
    ).orderBy('date', descending: true).limit(5).get();

    return snapshot.docs.map((e) {
      return ExpenseModel.fromMap({...e.data(), 'id': e.id});
    }).toList();
  }

  Future<List<ExpenseModel>> getAllExpense() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) {
      throw StateError("No user is signed in");
    }
    final snapshot = await expenseCollection(uid).get();

    return snapshot.docs.map((expense) {
      return ExpenseModel.fromMap({...expense.data(), "id": expense.id});
    }).toList();
  }

  Future<List<IncomeModel>> getAllIncome() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) {
      throw StateError("No user is signed in");
    }
    final snapshot = await incomeCollection(uid).get();

    return snapshot.docs.map((income) {
      return IncomeModel.fromMap({...income.data(), "id": income.id});
    }).toList();
  }

  Future<List<IncomeModel>> getAllSavingIncome() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) {
      throw StateError("No user is signed in");
    }
    final snapshot = await incomeCollection(
      uid,
    ).where('source', isEqualTo: 'savingAccount').get();

    return snapshot.docs.map((income) {
      return IncomeModel.fromMap({...income.data(), 'id': income.id});
    }).toList();
  }

  Future<DashboardModel> calculateDashboard() async {
    final uid = firebaseAuth.currentUser?.uid;

    if (uid == null) {
      throw StateError("No user is signed in");
    }
    final income = await getAllIncome();
    final expenses = await getAllExpense();
    final savingIncome = await getAllSavingIncome();

    final totalSaving = savingIncome.fold<double>(
      0.0,
      (double sum, IncomeModel income) => sum + income.amount,
    );
    final totalIncome = income.fold<double>(
      0.0,
      (double sum, IncomeModel income) => sum + income.amount,
    );
    final totalExpense = expenses.fold<double>(
      0.0,
      (double sum, ExpenseModel expense) => sum + expense.amount,
    );

    final currentBalance = totalIncome - totalExpense;
    final budgetUsed = totalExpense;
    final dashbaordsnapshot = await dashboardCollection(
      uid,
    ).doc('summary').get();
    final budgetLimit =
        (dashbaordsnapshot.data()?['budgetLimit'] as num?)?.toDouble() ?? 0.0;

    final dashboarddata = DashboardModel(
      currentBalance,
      totalIncome,
      totalExpense,
      totalSaving,
      budgetUsed,
      budgetLimit,
    );
    await dashboardCollection(
      uid,
    ).doc('summary').set(dashboarddata.toMap(), SetOptions(merge: true));

    return dashboarddata;
  }


}
