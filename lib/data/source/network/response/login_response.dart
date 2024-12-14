import 'package:layar_cerita_app/data/source/network/response/login_result_response.dart';

class LoginResponse {
  final bool error;
  final String message;
  final LoginResultResponse loginResult;

  LoginResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory LoginResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      LoginResponse(
        error: json["error"],
        message: json["message"],
        loginResult: LoginResultResponse.fromJson(json["loginResult"]),
      );
}
