import 'package:ecommerce/domain/authentication/entities/login_entity.dart';
import 'package:ecommerce/domain/authentication/entities/signup_entity.dart';
import 'package:ecommerce/domain/authentication/entities/user_entity.dart';
import 'package:ecommerce/domain/authentication/repositories/auth_repositories.dart';
import 'package:ecommerce/domain/authentication/usecases/signin_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeAuthRepository repository;
  late SigninUsecase usecase;

  setUp(() {
    repository = _FakeAuthRepository();
    usecase = SigninUsecase(repository);
  });

  test('delegates to the repository and returns its user', () async {
    final login = LoginEntity('jane@example.com', 'secure-password');
    final expectedUser = UserEntity(
      id: 'user-1',
      username: 'Jane',
      email: 'jane@example.com',
    );
    repository.signInResult = expectedUser;

    final result = await usecase(login);

    expect(result, same(expectedUser));
    expect(repository.receivedLogin, same(login));
    expect(repository.signInCallCount, 1);
  });

  test('propagates a repository error', () async {
    final error = StateError('Invalid credentials');
    repository.signInError = error;

    await expectLater(
      usecase(LoginEntity('jane@example.com', 'wrong-password')),
      throwsA(same(error)),
    );
  });
}

class _FakeAuthRepository implements AuthRepositories {
  UserEntity? signInResult;
  Object? signInError;
  LoginEntity? receivedLogin;
  int signInCallCount = 0;

  @override
  Future<UserEntity> signIn(LoginEntity login) async {
    receivedLogin = login;
    signInCallCount++;

    if (signInError != null) {
      throw signInError!;
    }
    return signInResult!;
  }

  @override
  Future<UserEntity?> getCurrentUser() async => null;

  @override
  Future<bool> isLoggedIn() async => false;

  @override
  Future<void> signOut() async {}

  @override
  Future<UserEntity> signUp(SignupEntity signUp) {
    throw UnimplementedError();
  }
}
