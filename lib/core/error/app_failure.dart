class AppFailure implements Exception {
  const AppFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthenticationFailure extends AppFailure {
  const AuthenticationFailure(super.message);
}
