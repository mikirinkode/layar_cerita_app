
import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable()
class LoginBody {
  final String email;
  final String password;

  LoginBody({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
  // Map<String, dynamic> toJson() => {
  //       "email": email,
  //       "password": password,
  //     };
}
