class LoginBody {
  final String email;
  final String password;

  LoginBody({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
