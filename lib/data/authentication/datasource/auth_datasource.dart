import 'package:ecommerce/data/authentication/model/login_model.dart';
import 'package:ecommerce/data/authentication/model/singup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  Future<UserCredential> signUp(SignupModel signup) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: signup.email,
      password: signup.password,
    );
  }

  Future<UserCredential> signIn(LoginModel login) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: login.email,
      password: login.password,
    );
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
  // Update User for future...
  // Future<void> updateCurrentUser({
  //   required String userName
  // }) async {
  //   await currentUser!.updateDisplayName(userName);
  // }

  Future<void> reAuthenticateCurrentUser({
    required String email,
    required String password,
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("No user is signed in");
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
  }

  Future<void> deleteCurrentUser({
    required String email,
    required String password,
  }) async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception("User is not siggned in");
    }
    user.delete();
  }

  Future<bool> isLoggedIn() async {
    final user = firebaseAuth.currentUser;

    if(user==null){
      return false;
    }
    return true;
  }
}
