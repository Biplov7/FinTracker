class SignupEntity {
  final String userName;
  final String email;
  final String password;

  const SignupEntity(this.userName, this.email, this.password);

  SignupEntity copyWith({String? userName, String? email, String? password}) {
    return SignupEntity(
      userName ?? this.userName,
      email ?? this.email,
      password ?? this.password,
    );
  }
}
