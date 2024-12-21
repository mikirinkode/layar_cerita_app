import 'package:json_annotation/json_annotation.dart';

part 'login_result_response.g.dart';

@JsonSerializable()
class LoginResultResponse {
  final String userId;
  final String name;
  final String token;

  LoginResultResponse({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResultResponse.fromJson(Map<String, dynamic> json) => _$LoginResultResponseFromJson(json);

  
  // factory LoginResultResponse.fromJson(
  //   Map<String, dynamic> json,
  // ) {
  //   return LoginResultResponse(
  //     userId: json['userId'],
  //     name: json['name'],
  //     token: json['token'],
  //   );
  // }
}
