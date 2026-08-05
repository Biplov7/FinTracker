import 'package:ecommerce/data/authentication/datasource/auth_datasource.dart';
import 'package:ecommerce/data/authentication/model/login_model.dart';
import 'package:ecommerce/data/authentication/model/singup_model.dart';
import 'package:ecommerce/data/authentication/model/user_model.dart';
import 'package:ecommerce/data/dashboard/datasource/getdashboarddata.dart';
import 'package:ecommerce/data/dashboard/model/dashboard_model.dart';
import 'package:ecommerce/domain/authentication/entities/login_entity.dart';
import 'package:ecommerce/domain/authentication/entities/signup_entity.dart';
import 'package:ecommerce/domain/authentication/entities/user_entity.dart';
import 'package:ecommerce/domain/authentication/repositories/auth_repositories.dart';

class AuthRepoimplementation implements AuthRepositories {
  final AuthDatasource ds;
  final Getdashboarddata dashbordds;
  AuthRepoimplementation(this.ds, this.dashbordds);

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = ds.getCurrentUser();
    if (user == null) {
      return null;
    }
    return UserModel(
      id: user.uid,
      username: user.displayName ?? "",
      email: user.email!,
    );
  }

  @override
  Future<bool> isLoggedIn() {
    return ds.isLoggedIn();
  }

  @override
  Future<UserEntity> signIn(LoginEntity logIn) async {
    LoginModel model = LoginModel(logIn.email, logIn.password);
    final credential = await ds.signIn(model);
    final user = credential.user!;
    return UserModel(
      id: user.uid,
      username: user.displayName ?? "",
      email: user.email!,
    );
  }

  @override
  Future<void> signOut() {
    return ds.signOut();
  }

  @override
  Future<UserEntity> signUp(SignupEntity signUp) async {
    final SignupModel model = SignupModel(
      signUp.userName,
      signUp.email,
      signUp.password,
    );
    final credential = await ds.signUp(model);
    final user = credential.user!;
    await user.updateDisplayName(signUp.userName);
    await dashbordds.createDefaultProfile(
      user.uid,
      UserModel(
        id: user.uid,
        username: signUp.userName,
        email: user.email!,
      ),
    );
    await dashbordds.createDefaultDashboard(
      user.uid,
      DashboardModel(0.0, 0.0, 0.0, 0.0, 0.0, 0.0),
    );
    return UserModel(
      id: user.uid,
      username: user.displayName ?? "",
      email: user.email!,
    );
  }
}