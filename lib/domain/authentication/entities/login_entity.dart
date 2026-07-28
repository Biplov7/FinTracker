class LoginEntity {
  final String email;
  final String password;

  const LoginEntity(
    this.email,
    this.password,
  );

  LoginEntity copyWith({
    String? email,
    String? password,
  }) {
    return LoginEntity(
      email ?? this.email,
      password ?? this.password,
    );
  }
}