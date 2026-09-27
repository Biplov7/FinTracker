import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fintracker/data/add_transaction/model/expense_model.dart';
import 'package:fintracker/data/add_transaction/model/income_model.dart';
import 'package:fintracker/data/transaction/model/transaction_model.dart';
import 'package:fintracker/domain/transaction/entity/transaction_filter.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Stream<List<TransactionModel>> getAllTransaction(
    TransactionFilter filter,
  ) {
    final incomeStream = getIncomeTransaction(filter);
    final expenseStream = getExpenseTransaction(filter);

    return _combineStreams(incomeStream, expenseStream).map((data) {
      final combined = [...data.$1, ...data.$2];
      combined.sort((a, b) => b.date.compareTo(a.date));
      return combined;
    });
  }

  Stream<List<TransactionModel>> getIncomeTransaction(
    TransactionFilter filter,
  ) {
    return income(user)
        .where(
          'date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(filter.startDate),
        )
        .where(
          'date',
          isLessThan: Timestamp.fromDate(filter.endDate),
        )
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((e) {
            final incomeData = IncomeModel.fromMap(e.data());
            return TransactionModel(
              incomeData.id,
              incomeData.amount,
              incomeData.date,
              null,
              incomeData.category,
              incomeData.source,
              null,
            );
          }).toList();
        });
  }

  Stream<List<TransactionModel>> getExpenseTransaction(
    TransactionFilter filter,
  ) {
    return expense(user)
        .where(
          'date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(filter.startDate),
        )
        .where(
          'date',
          isLessThan: Timestamp.fromDate(filter.endDate),
        )
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((e) {
            final expenseData = ExpenseModel.fromMap(e.data());
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
        });
  }

  Stream<(List<TransactionModel>, List<TransactionModel>)> _combineStreams(
    Stream<List<TransactionModel>> streamA,
    Stream<List<TransactionModel>> streamB,
  ) {
    late StreamController<(List<TransactionModel>, List<TransactionModel>)> controller;
    StreamSubscription? subA;
    StreamSubscription? subB;
    List<TransactionModel>? latestA;
    List<TransactionModel>? latestB;

    void emitIfReady() {
      if (latestA != null && latestB != null && !controller.isClosed) {
        controller.add((latestA!, latestB!));
      }
    }

    controller = StreamController<(List<TransactionModel>, List<TransactionModel>)>(
      onListen: () {
        subA = streamA.listen(
          (data) {
            latestA = data;
            emitIfReady();
          },
          onError: (e) {
            if (!controller.isClosed) controller.addError(e);
          },
        );
        subB = streamB.listen(
          (data) {
            latestB = data;
            emitIfReady();
          },
          onError: (e) {
            if (!controller.isClosed) controller.addError(e);
          },
        );
      },
      onCancel: () async {
        await subA?.cancel();
        await subB?.cancel();
      },
    );

    return controller.stream;
  }
}
