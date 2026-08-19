import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/authentication/model/user_model.dart';
import 'package:ecommerce/data/dashboard/model/dashboard_model.dart';
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

  Future<void> createDefaultDashboard(
    String uid,
    DashboardModel dashboard,
  ) async {
    await dashboardCollection(
      uid,
    ).doc('summary').set(dashboard.toMap(), SetOptions(merge: true));
  }
}
