import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable()
class RegisterBody {
  final String email;
  final String password;
  final String name;

  RegisterBody({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);
  // Map<String, dynamic> toJson() => {
  //       "email": email,
  //       "password": password,
  //       "name": name,
  //     };
}
